import 'package:flutter/material.dart';
import '../../theme.dart';

import 'student_home_screen.dart';
import 'student_subject_detail_screen.dart';
import 'student_messages_screen.dart';
import 'student_profile_screen.dart';

class StudentSubjectsScreen extends StatelessWidget {
  final String fullName;
  final String academicId;
  final List<String> subjects; // 👈 نفس List<String> القادمة من الهوم

  const StudentSubjectsScreen({
    super.key,
    required this.fullName,
    required this.academicId,
    required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EduTheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: EduTheme.background,
        centerTitle: true,
        title: const Text(
          'My Subjects',
          style: TextStyle(
            color: EduTheme.primaryDark,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: subjects.isEmpty
              ? const Center(
                  child: Text(
                    'No subjects found for your grade.',
                    style: TextStyle(
                      color: EduTheme.textMuted,
                      fontSize: 13,
                    ),
                  ),
                )
              : GridView.builder(
                  itemCount: subjects.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 3 / 2,
                  ),
                  itemBuilder: (context, index) {
                    final subjectName = subjects[index];
                    final icon = _iconForSubject(subjectName);

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => StudentSubjectDetailScreen(
                              subjectName: subjectName,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x11000000),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              color: EduTheme.primary,
                              size: 28,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              subjectName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: EduTheme.primaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),

      // Bottom Navigation – هنا Subjects هي المحددة
      bottomNavigationBar: Container(
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _BottomNavItem(
              icon: Icons.home_filled,
              label: 'Home',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => StudentHomeScreen(
                      fullName: fullName,
                      academicId: academicId,
                      subjects: subjects,
                    ),
                  ),
                );
              },
            ),
            _BottomNavItem(
              icon: Icons.menu_book_rounded,
              label: 'Subjects',
              selected: true,
              onTap: () {},
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
    );
  }

  static IconData _iconForSubject(String subjectName) {
    switch (subjectName) {
      case 'Quran':
        return Icons.menu_book_rounded;
      case 'Islamic Education':
        return Icons.account_balance_rounded;
      case 'Arabic Language':
        return Icons.language_rounded;
      case 'English Language':
        return Icons.translate_rounded;
      case 'Science':
        return Icons.science_rounded;
      case 'Mathematics':
        return Icons.calculate_rounded;
      case 'Social Studies':
        return Icons.public_rounded;
      case 'Chemistry':
        return Icons.biotech_rounded;
      case 'Physics':
        return Icons.bolt_rounded;
      case 'Biology':
        return Icons.eco_rounded;
      case 'Calculus':
        return Icons.functions_rounded;
      case 'Algebra and Geometry':
        return Icons.square_foot_rounded;
      case 'Geography':
        return Icons.map_rounded;
      case 'History':
        return Icons.history_edu_rounded;
      case 'National Education':
        return Icons.flag_rounded;
      default:
        return Icons.menu_book_rounded;
    }
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
