import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_filex/open_filex.dart'; // Add this for opening PDFs

class SecureProfileScreen extends StatefulWidget {
  const SecureProfileScreen({super.key});

  @override
  State<SecureProfileScreen> createState() => _SecureProfileScreenState();
}

class _SecureProfileScreenState extends State<SecureProfileScreen> {
  File? _imageFile;
  bool _isUnlocked = false;
  String? _savedPassword;

  List<Map<String, String>> _details = [];

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String? _pdfPath; // store saved PDF path

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// ================= LOAD / SAVE =================

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _savedPassword = prefs.getString('profile_password');

      final detailsString = prefs.getString('profile_details');
      if (detailsString != null) {
        _details = (jsonDecode(detailsString) as List)
            .map((e) => Map<String, String>.from(e))
            .toList();
      }

      final imagePath = prefs.getString('profile_image');
      if (imagePath != null) _imageFile = File(imagePath);

      _pdfPath = prefs.getString('profile_pdf_path');
    });
  }

  Future<void> _saveDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_details', jsonEncode(_details));
  }

  Future<void> _savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_password', password);
  }

  Future<void> _saveImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', path);
  }

  Future<void> _savePdf(Uint8List bytes, String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_pdf_path', path);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF saved at $path')),
    );
  }

  /// ================= IMAGE PICK =================

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
      _saveImage(picked.path);
    }
  }

  /// ================= PASSWORD =================

  void _unlockOrCreatePassword() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:
        Text(_savedPassword == null ? 'Create Password' : 'Enter Password'),
        content: TextField(
          controller: _passwordController,
          obscureText: true,
        ),
        actions: [
          TextButton(onPressed: Navigator.of(context).pop, child: const Text('Cancel')),
          ElevatedButton(
            child: const Text('Confirm'),
            onPressed: () async {
              final input = _passwordController.text.trim();
              if (input.isEmpty) return;

              if (_savedPassword == null) {
                await _savePassword(input);
                _savedPassword = input;
                _isUnlocked = true;
              } else if (input == _savedPassword) {
                _isUnlocked = true;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wrong password')),
                );
              }

              _passwordController.clear();
              setState(() {});
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  /// ================= ADD / EDIT DETAIL =================

  void _addOrEditDetail({int? index}) {
    if (index != null) {
      _titleController.text = _details[index]['title']!;
      _descController.text = _details[index]['desc']!;
    } else {
      _titleController.clear();
      _descController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? 'Add Detail' : 'Edit Detail'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: Navigator.of(context).pop, child: const Text('Cancel')),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              final title = _titleController.text.trim();
              final desc = _descController.text.trim();
              if (title.isEmpty || desc.isEmpty) return;

              setState(() {
                if (index == null) {
                  _details.add({'title': title, 'desc': desc});
                } else {
                  _details[index] = {'title': title, 'desc': desc};
                }
              });

              _saveDetails();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _deleteDetail(int index) {
    setState(() => _details.removeAt(index));
    _saveDetails();
  }

  /// ================= PDF GENERATION =================

  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Profile Details',
                  style:
                  pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 16),
              for (var detail in _details)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(detail['title'] ?? '',
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text(detail['desc'] ?? '',
                        style: const pw.TextStyle(fontSize: 14)),
                    pw.SizedBox(height: 12),
                  ],
                ),
            ],
          );
        },
      ),
    );

    final bytes = await pdf.save();

    // Save to device documents directory
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/my_profile.pdf');
    await file.writeAsBytes(bytes);

    _pdfPath = file.path;
    await _savePdf(bytes, file.path);
    setState(() {});
  }

  /// ================= OPEN PDF =================

  void _openPdf() {
    if (_pdfPath != null) {
      OpenFilex.open(_pdfPath!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No PDF found! Generate first.')),
      );
    }
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  'assets/images/hp_2.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage:
                      _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? const Icon(Icons.camera_alt, size: 40)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 350),
                  Card(
                    color: Colors.lightBlueAccent.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Personal Details',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: _unlockOrCreatePassword,
                                    child: Image.asset(
                                        _isUnlocked
                                            ? "assets/icons/unlocked.png"
                                            : 'assets/icons/lock.png',
                                        scale: 3),
                                  ),
                                  const SizedBox(width: 12),
                                  if (_isUnlocked) ...[
                                    IconButton(
                                      icon: const Icon(Icons.picture_as_pdf),
                                      onPressed: _generatePdf,
                                      tooltip: 'Save as PDF',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.open_in_new),
                                      onPressed: _openPdf,
                                      tooltip: 'Open PDF',
                                    ),
                                  ],
                                ],
                              )
                            ],
                          ),
                          const Divider(),
                          if (_isUnlocked) ...[
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _details.length,
                              itemBuilder: (_, i) => ListTile(
                                title: Text(_details[i]['title']!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(_details[i]['desc']!),
                                trailing: PopupMenuButton(
                                  onSelected: (v) {
                                    if (v == 'edit') {
                                      _addOrEditDetail(index: i);
                                    } else {
                                      _deleteDetail(i);
                                    }
                                  },
                                  itemBuilder: (_) => const [
                                    PopupMenuItem(
                                        value: 'edit', child: Text('Edit')),
                                    PopupMenuItem(
                                        value: 'delete', child: Text('Delete')),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => _addOrEditDetail(),
                              child: const Text('Add Detail'),
                            ),
                          ] else
                            const Text(
                              'Details are locked 🤪\nEnter password to view.',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
