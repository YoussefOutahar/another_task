import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc.dart';
import '../models/task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Tasks',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.brown.shade800,
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryTabs(),
          Expanded(
            child: _buildTaskList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
        onPressed: () {
          // Add task logic
        },
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildCategoryTab(Icons.star, 'Favorites', true),
          _buildCategoryTab(null, 'Daily', false),
          _buildCategoryTab(null, 'Work', false),
          _buildCategoryTab(null, 'Luggage', false),
          _buildCategoryTab(null, 'QEqualizer', false),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(IconData? icon, String text, bool showIcon) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          if (showIcon) Icon(icon, color: Colors.brown),
          Text(
            text,
            style: TextStyle(
              color: text == 'Daily' ? Colors.brown : Colors.white,
            ),
          ),
          if (text == 'Daily')
            Container(
              height: 2,
              width: 20,
              margin: const EdgeInsets.only(top: 4),
              color: Colors.brown,
            ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TaskLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.tasks.length + 1, // +1 for completed section
            itemBuilder: (context, index) {
              if (index == state.tasks.length) {
                return _buildCompletedSection();
              }
              final task = state.tasks[index];
              return _buildTaskItem(task);
            },
          );
        }
        return const Center(child: Text('No tasks found'));
      },
    );
  }

  Widget _buildTaskItem(Task task) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          // Update task completion status
        },
        fillColor: WidgetStateProperty.all(Colors.brown),
      ),
      title: Text(
        task.title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.star_border, color: Colors.white),
        onPressed: () {
          // Toggle favorite
        },
      ),
    );
  }

  Widget _buildCompletedSection() {
    return const ExpansionTile(
      title: Text(
        'Completed (2)',
        style: TextStyle(color: Colors.white),
      ),
      children: [
        // Add completed tasks here
      ],
    );
  }
}
