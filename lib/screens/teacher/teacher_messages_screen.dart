import 'package:flutter/material.dart';
import '../../theme.dart';
import 'teacher_home_screen.dart';
import 'teacher_classes_screen.dart';
import 'teacher_profile_screen.dart';

class TeacherMessagesScreen extends StatelessWidget {
  final String fullName;
  final String teacherCode;
  final List<dynamic> assignments;
  final int totalAssignedStudents;

  const TeacherMessagesScreen({
    super.key,
    required this.fullName,
    required this.teacherCode,
    required this.assignments,
    required this.totalAssignedStudents,
  });

  void _onBottomTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => TeacherHomeScreen(
            fullName: fullName,
            teacherCode: teacherCode,
            assignments: assignments,
            totalAssignedStudents: totalAssignedStudents,
          ),
        ),
      );
    } else if (index == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => TeacherClassesScreen(
            assignments: assignments,
            fullName: fullName,
            teacherCode: teacherCode,
            totalAssignedStudents: totalAssignedStudents,
          ),
        ),
      );
    } else if (index == 2) {
      // نحن في صفحة Messages
      return;
    } else if (index == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => TeacherProfileScreen(
            fullName: fullName,
            teacherCode: teacherCode,
            assignments: assignments,
            totalAssignedStudents: totalAssignedStudents,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduTheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: EduTheme.background,
        centerTitle: true,
        title: const Text('Messages'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: EduTheme.primaryDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.search_rounded,
              color: EduTheme.primaryDark,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: const [
          _MessageItem(
            avatarText: 'A',
            name: 'Anna Kowalski (Parent)',
            preview: "Sounds good, I’ll make sure she bri...",
            time: '11:30 AM',
            unreadCount: 2,
          ),
          _MessageItem(
            avatarText: 'B',
            name: 'Ben Carter (Student)',
            preview: "I have a question about the homework.",
            time: '10:45 AM',
          ),
          _MessageItem(
            avatarText: 'C',
            name: 'Carlos Reyes (Parent)',
            preview: "Thank you for the update!",
            time: 'Yesterday',
          ),
          _MessageItem(
            avatarText: 'D',
            name: 'Diana Prince (Student)',
            preview: "Okay, I understand.",
            time: 'Tuesday',
          ),
          _MessageItem(
            avatarText: 'E',
            name: 'Emily Fields (Parent)',
            preview: "Can we schedule a meeting next week?",
            time: 'Monday',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // لاحقاً: إنشاء محادثة جديدة
        },
        backgroundColor: EduTheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: EduTheme.primary,
        unselectedItemColor: EduTheme.textMuted,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_rounded),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
        ],
        onTap: (index) => _onBottomTap(context, index),
      ),
    );
  }
}

class _MessageItem extends StatelessWidget {
  final String avatarText;
  final String name;
  final String preview;
  final String time;
  final int? unreadCount;

  const _MessageItem({
    required this.avatarText,
    required this.name,
    required this.preview,
    required this.time,
    this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            child: Text(
              avatarText,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: EduTheme.primaryDark,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: EduTheme.primaryDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  preview,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: EduTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: EduTheme.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              if (unreadCount != null && unreadCount! > 0)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: const BoxDecoration(
                    color: EduTheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    unreadCount.toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
