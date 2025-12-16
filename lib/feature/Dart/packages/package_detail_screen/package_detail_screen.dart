import 'package:flutter/material.dart';

class PackageDetailScreen extends StatelessWidget {
  final String title;
  const PackageDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF1E88E5),
      ),
      body: Center(
        child: Text('Details for $title', style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
