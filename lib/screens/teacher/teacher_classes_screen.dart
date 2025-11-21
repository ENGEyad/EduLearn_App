import 'package:flutter/material.dart';
import '../../theme.dart';
import 'teacher_home_screen.dart';
import 'teacher_messages_screen.dart';
import 'teacher_profile_screen.dart';

class TeacherClassesScreen extends StatelessWidget {
  final List<dynamic> assignments;

  // نمرّر نفس بيانات المعلّم لاستخدامها في التنقّل
  final String fullName;
  final String teacherCode;
  final int totalAssignedStudents;

  const TeacherClassesScreen({
    super.key,
    required this.assignments,
    required this.fullName,
    required this.teacherCode,
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
      // نحن بالفعل في صفحة Classes
      return;
    } else if (index == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => TeacherMessagesScreen(
            fullName: fullName,
            teacherCode: teacherCode,
            assignments: assignments,
            totalAssignedStudents: totalAssignedStudents,
          ),
        ),
      );
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
        title: const Text('My Classes'),
        // ⬅️ سهم رجوع
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
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: assignments.length,
          itemBuilder: (context, index) {
            final item = assignments[index];
            if (item is! Map<String, dynamic>) {
              return const SizedBox.shrink();
            }

            final String grade = (item['class_grade'] ?? '').toString();
            final String section = (item['class_section'] ?? '').toString();
            final String subjectName = (item['subject_name'] ?? '').toString();

            final String title =
                grade.isNotEmpty ? '$grade - $subjectName' : subjectName;

            final int studentsCount = (item['students_count'] as int?) ?? 0;
            const String scheduleText = 'Mon, Wed, Fri - 10:00 AM';

            final double progress = [0.85, 0.45, 1.0, 0.6][index % 4];
            final String progressText = '${(progress * 100).round()}%';

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _classCard(
                title: title,
                studentsCount: studentsCount,
                schedule: scheduleText,
                progress: progress,
                progressText: progressText,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // لاحقاً: إضافة كلاس جديد أو درس
        },
        backgroundColor: EduTheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      // 🔽 نفس البار السفلي
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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

  Widget _classCard({
    required String title,
    required int studentsCount,
    required String schedule,
    required double progress,
    required String progressText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D6C3C),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.eco_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: EduTheme.primaryDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.group_rounded,
                          size: 16,
                          color: EduTheme.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$studentsCount Students',
                          style: const TextStyle(
                            fontSize: 13,
                            color: EduTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_rounded,
                          size: 16,
                          color: EduTheme.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          schedule,
                          style: const TextStyle(
                            fontSize: 13,
                            color: EduTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: EduTheme.textMuted,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: const Color(0xFFE3E7F3),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF8DD2F0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                progressText,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: EduTheme.primaryDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
