import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  Map<String, String> _comments = {}; // dateString -> comment
  DateTime _selectedDay = DateTime.now();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('calendarComments');
    if (saved != null) {
      setState(() {
        _comments = (jsonDecode(saved) as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value.toString()));
      });
    }
  }

  Future<void> _saveComments() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('calendarComments', jsonEncode(_comments));
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  void _showCommentDialog(DateTime date) {
    final dateKey = _formatDate(date);
    _commentController.text = _comments[dateKey] ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Comment for ${dateKey}'),
        content: TextField(
          controller: _commentController,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Write a comment'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          if (_comments.containsKey(dateKey))
            TextButton(
              onPressed: () {
                setState(() {
                  _comments.remove(dateKey);
                  _saveComments();
                });
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ElevatedButton(
            onPressed: () {
              if (_commentController.text.trim().isNotEmpty) {
                setState(() {
                  _comments[dateKey] = _commentController.text.trim();
                });
              } else {
                setState(() {
                  _comments.remove(dateKey);
                });
              }
              _saveComments();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  bool _hasComment(DateTime date) {
    return _comments.containsKey(_formatDate(date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,

      body: Stack(
        children: [
          
          Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: _selectedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if (_hasComment(day)) {
                      return  Positioned(
                        bottom: 4,
                        left: 4,
                        child: Image.asset('assets/icons/calender.png',scale: 4.8,),
                      );
                    }
                    return null;
                  },
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                  });
                  _showCommentDialog(selectedDay);
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: _comments.entries.map((entry) {
                    return Card(
                      color: Colors.blue.shade100,
                      margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(entry.value),
                        subtitle: Text(entry.key),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showCommentDialog(DateTime.parse(entry.key));
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
