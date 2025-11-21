import 'package:flutter/material.dart';
import '../../theme.dart';

import 'student_subjects_screen.dart';
import 'student_messages_screen.dart';
import 'student_profile_screen.dart';

class StudentHomeScreen extends StatelessWidget {
  final String fullName;
  final String academicId;
  final List<String> subjects; // 👈 نفس المنطق القادم من الـ API

  const StudentHomeScreen({
    super.key,
    required this.fullName,
    required this.academicId,
    required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // المحتوى قابل للسكرول
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الهيدر
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundImage:
                              AssetImage('assets/avatar_placeholder.png'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, $fullName!',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: EduTheme.primaryDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'ID: $academicId',
                                style: const TextStyle(
                                  color: EduTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_none_rounded),
                          color: EduTheme.primaryDark,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Overall Progress
                    const Text(
                      'Overall Progress',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: EduTheme.primaryDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.68,
                            backgroundColor: Color(0xFFE3E7F3),
                            minHeight: 6,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '68%',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: EduTheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Keep it up, you're doing great!",
                      style: TextStyle(
                        color: EduTheme.textMuted,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 👉 هنا كان Grid المواد في الكود الأصلي وتم إزالته من الهوم
                    // المنطق نفسه: subjects تأتي من الـ API وتُمرَّر لشاشة المواد
                    // StudentSubjectsScreen

                    // بطاقة الدرس الحالي (ثابتة الآن كمثال)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Ongoing Lesson',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: EduTheme.textMuted,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Chapter 3:\nPhotosynthesis',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: EduTheme.primaryDark,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'You are 75% through this lesson.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: EduTheme.textMuted,
                                  ),
                                ),
                                SizedBox(height: 12),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE5F5F5),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.local_florist,
                              color: EduTheme.primary,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Upcoming Assessments',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: EduTheme.primaryDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _assessmentCard(
                      title: 'Math Quiz 2',
                      subtitle: 'Due: Friday, 11:59 PM',
                    ),
                    const SizedBox(height: 8),
                    _assessmentCard(
                      title: 'History Essay',
                      subtitle: 'Due: Sunday, 8:00 PM',
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Recommended for you',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: EduTheme.primaryDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _recommendedCard(
                      title: 'Explore: The Roman Empire',
                      subtitle: 'Expand your historical knowledge.',
                    ),
                    const SizedBox(height: 12),
                    _recommendedCard(
                      title: 'Practice: Advanced Algebra',
                      subtitle: 'Struggling with Algebra? Try this.',
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x11000000),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _BottomNavItem(
                    icon: Icons.home_filled,
                    label: 'Home',
                    selected: true,
                    onTap: () {
                      // أنت في الهوم بالفعل
                    },
                  ),
                  _BottomNavItem(
                    icon: Icons.menu_book_rounded,
                    label: 'Subjects',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => StudentSubjectsScreen(
                            fullName: fullName,
                            academicId: academicId,
                            subjects: subjects, // 👈 تمرير المواد كما هي
                          ),
                        ),
                      );
                    },
                  ),
                  _BottomNavItem(
                    icon: Icons.message_rounded,
                    label: 'Messages',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const StudentMessagesScreen(),
                        ),
                      );
                    },
                  ),
                  _BottomNavItem(
                    icon: Icons.person_rounded,
                    label: 'Profile',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const StudentProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _assessmentCard(
      {required String title, required String subtitle}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFE5F2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.assignment_rounded,
              color: EduTheme.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: EduTheme.primaryDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: EduTheme.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _recommendedCard(
      {required String title, required String subtitle}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E9F6),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: EduTheme.primaryDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: EduTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? EduTheme.primary : EduTheme.textMuted,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? EduTheme.primary : EduTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
