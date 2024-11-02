import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border, color: Colors.white),
            onPressed: () {
              // Toggle favorite
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Show more options
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildDetailItem(
              Icons.description_outlined,
              'Add details',
            ),
            const SizedBox(height: 16),
            _buildDetailItem(
              Icons.access_time,
              'Add date/time',
            ),
            const SizedBox(height: 16),
            _buildDetailItem(
              Icons.list,
              'Add subtasks',
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TextButton(
            onPressed: () {
              // Mark task as completed
            },
            child: const Text(
              'Mark completed',
              style: TextStyle(color: Colors.brown),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white54),
        const SizedBox(width: 16),
        Text(
          text,
          style: const TextStyle(color: Colors.white54),
        ),
      ],
    );
  }
}
