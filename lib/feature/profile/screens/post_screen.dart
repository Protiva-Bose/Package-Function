import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<String> _posts = [];
  List<List<String>> _comments = [];
  int? _highlightedIndex;

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  @override
  void dispose() {
    _controller.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _posts = prefs.getStringList('posts') ?? [];
      _highlightedIndex = prefs.getInt('highlightedIndex');
      final savedComments = prefs.getStringList('comments') ?? [];
      _comments = savedComments
          .map((c) => (jsonDecode(c) as List<dynamic>).cast<String>())
          .toList();

      // Initialize empty comments for new posts
      while (_comments.length < _posts.length) {
        _comments.add([]);
      }
    });
  }

  Future<void> _savePosts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('posts', _posts);
    await prefs.setInt('highlightedIndex', _highlightedIndex ?? -1);
    final commentsEncoded = _comments
        .map((c) => jsonEncode(c))
        .toList(growable: false);
    await prefs.setStringList('comments', commentsEncoded);
  }

  void _addPost(String text) {
    setState(() {
      _posts.add(text);
      _comments.add([]);
    });
    _savePosts();
  }

  void _editPost(int index, String newText) {
    setState(() {
      _posts[index] = newText;
    });
    _savePosts();
  }

  void _deletePost(int index) {
    setState(() {
      if (_highlightedIndex == index) _highlightedIndex = null;
      _posts.removeAt(index);
      _comments.removeAt(index);
    });
    _savePosts();
  }

  void _showEditDialog(int index) {
    _controller.text = _posts[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Post'),
        content: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter text'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _editPost(index, _controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(int index) {
    _controller.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index >= 0 ? 'Add More Text' : 'Add New Post'),
        content: TextField(
          controller: _controller,
          autofocus: true,
          maxLines: 5,
          decoration: const InputDecoration(hintText: 'Enter text'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.trim().isEmpty) return;

              if (index >= 0) {
                _editPost(
                  index,
                  _posts[index] + "\n" + _controller.text.trim(),
                );
              } else {
                _addPost(_controller.text.trim());
              }

              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showCommentDialog(int index) {
    _commentController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Comment'),
        content: TextField(
          controller: _commentController,
          autofocus: true,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Write a comment'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_commentController.text.trim().isNotEmpty) {
                setState(() {
                  _comments[index].add(_commentController.text.trim());
                });
                _savePosts();
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showFullTextDialog(String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Post Details'),
        content: SingleChildScrollView(child: Text(text)),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLongPressMenu(int index) {
    showModalBottomSheet(
      backgroundColor: Colors.lightBlueAccent.shade100,
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: Image.asset('assets/icons/copy.png', scale: 4),
            title: const Text('Copy'),
            onTap: () {
              Clipboard.setData(ClipboardData(text: _posts[index]));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied to clipboard')),
              );
            },
          ),
          ListTile(
            leading: Image.asset('assets/icons/edit.png', scale: 4),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              _showEditDialog(index);
            },
          ),
          ListTile(
            leading: Image.asset('assets/icons/remove.png', scale: 4),
            title: const Text('Delete'),
            onTap: () {
              Navigator.pop(context);
              _deletePost(index);
            },
          ),
          ListTile(
            leading: Image.asset('assets/icons/highlight.png', scale: 4),
            title: const Text('Highlight'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _highlightedIndex = _highlightedIndex == index ? null : index;
              });
              _savePosts();
            },
          ),
          ListTile(
            leading: Image.asset('assets/icons/add.png', scale: 4),
            title: const Text('Add Text'),
            onTap: () {
              Navigator.pop(context);
              _showAddDialog(index);
            },
          ),
          ListTile(
            leading: Image.asset('assets/icons/comment.png', scale: 4),
            title: const Text('Comment'),
            onTap: () {
              Navigator.pop(context);
              _showCommentDialog(index);
            },
          ),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }

  Widget _buildPostTab() {
    return _posts.isEmpty
        ? Center(
            child: ElevatedButton(
              onPressed: () => _showAddDialog(-1),
              child: const Text('Add First Post'),
            ),
          )
        : SafeArea(
          child: Stack(
              children: [
                Positioned(
                    bottom: 5,
                    left: 0,
                    child: Image.asset('assets/images/happy_women.png')),
                Column(
                  children: [
                    SizedBox(height: 20.h),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: _posts.length,
                          itemBuilder: (context, index) {
                            final post = _posts[index];
                            final isHighlighted = _highlightedIndex == index;
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                GestureDetector(
                                  onTap: () => _showFullTextDialog(post),
                                  onLongPress: () => _showLongPressMenu(index),
                                  child: Card(
                                    color: isHighlighted
                                        ? Colors.yellow.shade200
                                        : Colors.lightBlueAccent.shade100,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        post,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                if (_comments[index].isNotEmpty)
                                  Positioned(
                                    right: -3,
                                    top: 2,
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Comments'),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: _comments[index]
                                                    .map(
                                                      (c) => Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 4.0,
                                                            ),
                                                        child: Text("- $c"),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Image.asset(
                                        'assets/icons/msg.png',
                                        scale: 2.5,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPostTab();
  }
}
