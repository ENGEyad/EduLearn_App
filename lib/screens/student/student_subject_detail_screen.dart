import 'package:flutter/material.dart';
import '../../theme.dart';

class StudentSubjectDetailScreen extends StatefulWidget {
  final String subjectName;

  const StudentSubjectDetailScreen({
    super.key,
    required this.subjectName,
  });

  @override
  State<StudentSubjectDetailScreen> createState() =>
      _StudentSubjectDetailScreenState();
}

class _StudentSubjectDetailScreenState extends State<StudentSubjectDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // بيانات دروس تجريبية – لاحقاً تربطها بالـ API
  final List<Map<String, dynamic>> _lessons = [
    {
      'number': 1,
      'title': 'The Foundations of Algebra',
      'duration': '12 mins',
      'status': 'completed',
    },
    {
      'number': 2,
      'title': 'Linear Equations',
      'duration': '15 mins',
      'status': 'in_progress',
    },
    {
      'number': 3,
      'title': 'Functions and Graphs',
      'duration': '18 mins',
      'status': 'locked',
    },
    {
      'number': 4,
      'title': 'Polynomials',
      'duration': '22 mins',
      'status': 'locked',
    },
    {
      'number': 5,
      'title': 'Rational Expressions',
      'duration': '20 mins',
      'status': 'locked',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  IconData _iconForSubject(String name) {
    if (name.toLowerCase().contains('math') ||
        name.toLowerCase().contains('algebra')) {
      return Icons.calculate_rounded;
    }
    if (name.toLowerCase().contains('history')) {
      return Icons.public_rounded;
    }
    if (name.toLowerCase().contains('chem')) {
      return Icons.biotech_rounded;
    }
    if (name.toLowerCase().contains('english')) {
      return Icons.menu_book_rounded;
    }
    return Icons.menu_book_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final subjectIcon = _iconForSubject(widget.subjectName);

    return Scaffold(
      backgroundColor: EduTheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: EduTheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded,
              color: EduTheme.primaryDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          widget.subjectName,
          style: const TextStyle(
            color: EduTheme.primaryDark,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
              color: EduTheme.primaryDark,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerScrolled) {
            return [
              // كرت المادة في الأعلى
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5F2FF),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Icon(
                            subjectIcon,
                            color: EduTheme.primary,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Algebra II',
                                // ممكن لاحقاً تربطها بالـ API حسب المادة
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: EduTheme.primaryDark,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Prof. Emily Carter',
                                style: TextStyle(
                                  color: EduTheme.textMuted,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: 0.75,
                                      minHeight: 6,
                                      backgroundColor: Color(0xFFE3E7F3),
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                              EduTheme.primary),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '75%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: EduTheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // TabBar مثبتة عند التمرير
              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarHeaderDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: EduTheme.primary,
                    unselectedLabelColor: EduTheme.textMuted,
                    indicatorColor: EduTheme.primary,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                    tabs: const [
                      Tab(text: 'Lessons'),
                      Tab(text: 'Quizzes'),
                      Tab(text: 'Question Bank'),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              // ===== تبويب الدروس =====
              _buildLessonsTab(),

              // ===== تبويب الاختبارات =====
              _buildPlaceholderTab(
                title: 'No quizzes yet',
                subtitle:
                    'Your teacher will add quizzes for this subject soon.',
              ),

              // ===== تبويب بنك الأسئلة =====
              _buildPlaceholderTab(
                title: 'Question bank is empty',
                subtitle:
                    'Practice questions will appear here once they are added.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLessonsTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: _lessons.length,
      itemBuilder: (context, index) {
        final lesson = _lessons[index];
        return _lessonItem(
          number: lesson['number'] as int,
          title: lesson['title'] as String,
          duration: lesson['duration'] as String,
          status: lesson['status'] as String,
        );
      },
    );
  }

  Widget _buildPlaceholderTab({required String title, required String subtitle}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: EduTheme.primaryDark,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: EduTheme.textMuted,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lessonItem({
    required int number,
    required String title,
    required String duration,
    required String status,
  }) {
    Color circleColor;
    IconData trailingIcon;

    switch (status) {
      case 'completed':
        circleColor = const Color(0xFF4CAF50);
        trailingIcon = Icons.check_circle_rounded;
        break;
      case 'in_progress':
        circleColor = EduTheme.primary;
        trailingIcon = Icons.play_circle_fill_rounded;
        break;
      default:
        circleColor = EduTheme.textMuted.withOpacity(0.3);
        trailingIcon = Icons.lock_rounded;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
      child: Row(
        children: [
          // رقم الدرس داخل دائرة
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: circleColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: circleColor ==
                          EduTheme.textMuted.withOpacity(0.3)
                      ? EduTheme.textMuted
                      : circleColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // العنوان + المدة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: EduTheme.primaryDark,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: const TextStyle(
                    fontSize: 12,
                    color: EduTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            trailingIcon,
            color: circleColor ==
                    EduTheme.textMuted.withOpacity(0.3)
                ? EduTheme.textMuted
                : circleColor,
            size: 26,
          ),
        ],
      ),
    );
  }
}

class _TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarHeaderDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: EduTheme.background,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarHeaderDelegate oldDelegate) => false;
}
