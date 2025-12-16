import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<Map<String, dynamic>> _todos = [];
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  // ================= STORAGE =================

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('todos');
    if (data != null) {
      setState(() {
        _todos = List<Map<String, dynamic>>.from(jsonDecode(data));
        _sortTodos();
      });
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('todos', jsonEncode(_todos));
  }

  void _sortTodos() {
    _todos.sort((a, b) =>
        DateTime.parse(a['time']).compareTo(DateTime.parse(b['time'])));
  }

  // ================= ADD / EDIT =================

  Future<void> _addOrEditTodo({int? index}) async {
    DateTime selectedDateTime = DateTime.now();
    _taskController.text = index != null ? _todos[index]['title'] : '';

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Add Task' : 'Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                hintText: 'Enter task',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.access_time),
              label: const Text('Pick Date & Time'),
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  initialDate: selectedDateTime,
                );
                if (date == null) return;

                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                );
                if (time == null) return;

                selectedDateTime = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  time.hour,
                  time.minute,
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result == true && _taskController.text.trim().isNotEmpty) {
      setState(() {
        if (index == null) {
          _todos.add({
            'title': _taskController.text.trim(),
            'time': selectedDateTime.toIso8601String(),
            'done': false,
          });
        } else {
          _todos[index]['title'] = _taskController.text.trim();
        }
        _sortTodos();
      });
      _saveTodos();
    }
  }

  // ================= DELETE =================

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
    _saveTodos();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.shade100,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => _addOrEditTodo(),
        child: const Icon(Icons.add),
      ),
      body: _todos.isEmpty
          ? const Center(child: Text('No tasks added'))
          : SafeArea(
            child: Stack(
              children: [
                Positioned(
                    top: 5,
                    left: 0,
                    child: Image.asset('assets/images/hp_1.png',scale: 1.2,)),
            
                Positioned(
                    bottom: 200,
                    left: 20,
                    child: Image.asset('assets/icons/love.png',scale: 2,)),
                Positioned(
                    top: 200,
                    right: 20,
                    child: Image.asset('assets/icons/love.png',scale: 2,)),

                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset('assets/images/hp_2.png')),
                Expanded(
                  child: ListView.builder(
                          itemCount: _todos.length,
                          itemBuilder: (context, index) {
                  final todo = _todos[index];
                  final time = DateTime.parse(todo['time']);
            
                  return Column(
                    children: [
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: ListTile(
                                leading: Checkbox(
                                  value: todo['done'],
                                  onChanged: (v) {
                                    setState(() {
                                      todo['done'] = v!;
                                    });
                                    _saveTodos();
                                  },
                                ),
                                title: Text(
                                  todo['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    decoration:
                                    todo['done'] ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                                subtitle: Text(
                                  "${time.day}/${time.month}/${time.year}  "
                                      "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
                                ),
                                trailing: PopupMenuButton(
                                  itemBuilder: (context) => const [
                                    PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      _addOrEditTodo(index: index);
                                    } else {
                                      _deleteTodo(index);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
            
                    ],
                  );
                          },
                        ),
                ),
              ],
            ),
          ),
    );
  }
}
