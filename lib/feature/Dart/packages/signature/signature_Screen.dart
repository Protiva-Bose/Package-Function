import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final GlobalKey<SignatureState> _signKey = GlobalKey();
  bool _hasSignature = false;
  bool _isSaving = false;
  Uint8List? _signatureBytes;

  Future<bool> _requestPermission() async {
    if (kIsWeb) return false;
    final ps = await PhotoManager.requestPermissionExtend();
    return ps.isAuth || ps.hasAccess;
  }

  Future<void> _saveSignature() async {
    final sign = _signKey.currentState;
    if (sign == null || sign.points.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please draw your signature first!')),
      );
      return;
    }

    if (kIsWeb) {
      final image = await sign.getData();
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      if (data != null) {
        setState(() => _signatureBytes = data.buffer.asUint8List());
        _showSavedImage();
      }
      return;
    }

    setState(() => _isSaving = true);

    try {
      final image = await sign.getData();
      final originalData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (originalData == null) throw Exception('Failed to convert');

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final size = Size(image.width.toDouble(), image.height.toDouble());

      canvas.drawColor(Colors.white, BlendMode.color);

      final signatureBytes = originalData.buffer.asUint8List();
      final codec = await ui.instantiateImageCodec(signatureBytes);
      final frame = await codec.getNextFrame();
      final signatureImage = frame.image;

      canvas.drawImage(signatureImage, Offset.zero, Paint());

      final picture = recorder.endRecording();
      final finalImage = await picture.toImage(image.width, image.height);
      final byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) throw Exception('Failed to finalize image');

      final buffer = byteData.buffer.asUint8List();
      setState(() => _signatureBytes = buffer);

      final fileName = 'signature_${DateTime.now().millisecondsSinceEpoch}.png';
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$fileName');
      await tempFile.writeAsBytes(buffer);

      final granted = await _requestPermission();
      if (!granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permission denied – saved locally.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final result = await PhotoManager.editor.saveImageWithPath(
        tempFile.path,
        title: fileName,
        relativePath: 'Pictures/Signatures',
      );

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Saved to Gallery!'),
              ],
            ),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'VIEW',
              textColor: Colors.yellow,
              onPressed: _showSavedImage,
            ),
          ),
        );
      } else {
        throw Exception('Save failed');
      }

      await tempFile.delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  void _showSavedImage() {
    if (_signatureBytes == null) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Your Signature'),
        content: Image.memory(
          _signatureBytes!,
          width: 300,
          height: 200,
          fit: BoxFit.contain,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _clearSignature() {
    _signKey.currentState?.clear();
    setState(() {
      _hasSignature = false;
      _signatureBytes = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Draw Signature'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.greenAccent, width: 2.5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      children: [
                        Signature(
                          key: _signKey,
                          color: Colors.black,
                          strokeWidth: 3.5,
                          onSign: () {
                            final has = _signKey.currentState?.points.isNotEmpty ?? false;
                            if (has != _hasSignature) {
                              setState(() => _hasSignature = has);
                            }
                          },
                        ),
                        if (!_hasSignature)
                          const Positioned(
                            bottom: 20,
                            right: 20,
                            child: Opacity(
                              opacity: 0.15,
                              child: Text(
                                'Sign Here',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _hasSignature ? _clearSignature : null,
                      icon: const Icon(Icons.delete_outline, size: 20),
                      label: const Text('Clear'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent.shade200,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _hasSignature && !_isSaving ? _saveSignature : null,
                      icon: _isSaving
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                      )
                          : const Icon(Icons.save_alt, size: 20),
                      label: Text(_isSaving ? 'Saving...' : 'Save to Gallery'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade400,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 4,
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