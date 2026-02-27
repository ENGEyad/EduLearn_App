import 'package:flutter/material.dart';
import '../../theme.dart';

import 'student_home_screen.dart';
import 'student_subjects_screen.dart';
import 'student_messages_screen.dart';
import 'student_profile_screen.dart';

class StudentMainScreen extends StatefulWidget {
  final Map<String, dynamic> student;
  final List<dynamic> assignedSubjects;

  const StudentMainScreen({
    super.key,
    required this.student,
    required this.assignedSubjects,
  });

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      StudentHomeScreen(
        student: widget.student,
        assignedSubjects: widget.assignedSubjects,
      ),
      StudentSubjectsScreen(
        student: widget.student,
        assignedSubjects: widget.assignedSubjects,
      ),
      StudentMessagesScreen(student: widget.student),
      StudentProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: EduTheme.background,
        body: IndexedStack(index: _currentIndex, children: pages),
        bottomNavigationBar: _BottomNav(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
        ),
      ),
    );
  }
}

// ── Premium Bottom Navigation Bar ─────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.currentIndex, required this.onTap});

  static const _items = [
    _NavItem(icon: Icons.home_rounded, outlinedIcon: Icons.home_outlined, label: 'Home'),
    _NavItem(icon: Icons.menu_book_rounded, outlinedIcon: Icons.menu_book_outlined, label: 'Subjects'),
    _NavItem(icon: Icons.chat_bubble_rounded, outlinedIcon: Icons.chat_bubble_outline_rounded, label: 'Messages'),
    _NavItem(icon: Icons.person_rounded, outlinedIcon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: EduTheme.primaryDark.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final selected = i == currentIndex;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: selected ? 18 : 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: selected ? EduTheme.primaryGradient : null,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        selected ? item.icon : item.outlinedIcon,
                        color: selected ? Colors.white : EduTheme.textMuted,
                        size: 22,
                      ),
                      if (selected) ...[
                        const SizedBox(width: 6),
                        Text(
                          item.label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData outlinedIcon;
  final String label;
  const _NavItem({required this.icon, required this.outlinedIcon, required this.label});
}
