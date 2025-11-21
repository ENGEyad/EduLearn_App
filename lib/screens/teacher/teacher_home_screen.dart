import 'package:flutter/material.dart';
import '../../theme.dart';
import 'teacher_classes_screen.dart';
import 'teacher_messages_screen.dart';
import 'teacher_profile_screen.dart';

class TeacherHomeScreen extends StatelessWidget {
  final String fullName;
  final String teacherCode;

  // 👇 البيانات القادمة من الـ API
  final List<dynamic> assignments;
  final int totalAssignedStudents;

  const TeacherHomeScreen({
    super.key,
    required this.fullName,
    required this.teacherCode,
    required this.assignments,
    required this.totalAssignedStudents,
  });

  String get _firstName {
    final parts = fullName.trim().split(' ');
    if (parts.isEmpty) return fullName;
    return parts.first;
  }

  // نحسب عدد الكلاسات الفعّالة من الإسنادات
  int _calculateActiveClasses(List<dynamic> assignments) {
    final Set<String> uniqueClasses = {};

    for (final item in assignments) {
      if (item is Map<String, dynamic>) {
        final grade = (item['class_grade'] ?? '').toString();
        final section = (item['class_section'] ?? '').toString();

        if (grade.isNotEmpty || section.isNotEmpty) {
          uniqueClasses.add('$grade-$section');
        }
      }
    }

    return uniqueClasses.length;
  }

  // 🔁 دالة مشتركة للتنقّل بين الصفحات الأربع من أي شاشة
  void _onBottomTap(BuildContext context, int index) {
    if (index == 0) {
      // Dashboard (نفس الصفحة) – لا نعمل شيء
      return;
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
    final int activeClasses = _calculateActiveClasses(assignments);

    return Scaffold(
      backgroundColor: EduTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== Header (Avatar + Notifications) =====
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.white,
                              child: Text(
                                _firstName.isNotEmpty
                                    ? _firstName[0].toUpperCase()
                                    : '?',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: EduTheme.primaryDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.notifications_none_rounded,
                                color: EduTheme.primaryDark,
                                size: 22,
                              ),
                            ),
                            Positioned(
                              right: -2,
                              top: -2,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Center(
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ===== Welcome text =====
                    Text(
                      'Welcome back, $_firstName!',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: EduTheme.primaryDark,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Here’s a quick overview of your classes.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: EduTheme.textMuted,
                          ),
                    ),

                    const SizedBox(height: 24),

                    // ===== Stats cards: 2x2 =====
                    Row(
                      children: [
                        const Expanded(
                          child: _StatCard(
                            title: 'Lessons Created',
                            value: '24',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(
                            title: 'Active Classes',
                            value: activeClasses.toString(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            title: 'Total Students',
                            value: totalAssignedStudents.toString(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: _StatCard(
                            title: 'Pending Tasks',
                            value: '8',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // ===== Quick Access =====
                    Text(
                      'Quick Access',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: EduTheme.primaryDark,
                          ),
                    ),
                    const SizedBox(height: 12),

                    const _QuickActionCard(
                      title: 'Create a New Lesson',
                      subtitle: 'Design your next engaging activity',
                      icon: Icons.edit_outlined,
                    ),
                    const SizedBox(height: 10),
                    const _QuickActionCard(
                      title: 'View All Classes',
                      subtitle: 'Manage your class rosters and schedules',
                      icon: Icons.school_outlined,
                    ),
                    const SizedBox(height: 10),
                    const _QuickActionCard(
                      title: 'Check Performance',
                      subtitle: 'Review student progress and analytics',
                      icon: Icons.show_chart_rounded,
                    ),

                    const SizedBox(height: 28),

                    // ===== What's New =====
                    Text(
                      "What's New",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: EduTheme.primaryDark,
                          ),
                    ),
                    const SizedBox(height: 12),

                    const _WhatsNewItem(
                      icon: Icons.help_outline_rounded,
                      title: "Alex Morgan asked a question in 'Algebra II'",
                      time: '2 hours ago',
                    ),
                    const SizedBox(height: 10),
                    const _WhatsNewItem(
                      icon: Icons.assignment_turned_in_outlined,
                      title: '5 new assignments submitted for grading',
                      time: '8 hours ago',
                    ),
                    const SizedBox(height: 10),
                    const _WhatsNewItem(
                      icon: Icons.check_circle_outline_rounded,
                      title: "Reminder: 'Chapter 5 Quiz' is due tomorrow",
                      time: 'Yesterday',
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ===== Bottom Navigation =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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

// ===== نفس الـ Widgets المساعدة كما هي بدون تغيير =====
class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: EduTheme.textMuted,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: EduTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: EduTheme.primaryDark,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: EduTheme.textMuted,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F3FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: EduTheme.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _WhatsNewItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;

  const _WhatsNewItem({
    required this.icon,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F3FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: EduTheme.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: EduTheme.primaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: EduTheme.textMuted,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
