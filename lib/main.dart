import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Education App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'SF Pro',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;
  String _searchQuery = '';
  int _selectedChipIndex = 0;
  final Set<int> _bookmarkedLessons = {};
  final Set<int> _bookmarkedRecommended = {};
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _lessons = [
    {
      'title': 'Struktura e ADN-së',
      'subject': 'Biologjia 10',
      'rating': 4.8,
      'duration': '30 min',
    },
    {
      'title': 'Fotosinteza dhe Respirimi',
      'subject': 'Biologjia 10',
      'rating': 4.7,
      'duration': '45 min',
    },
    {
      'title': 'Sistemi Nervor',
      'subject': 'Biologjia 11',
      'rating': 4.9,
      'duration': '40 min',
    },
  ];

  final List<Map<String, dynamic>> _recommendedLessons = [
    {
      'title': 'Dallimi mes qelizës bimore dhe shtazore',
      'subject': 'Biologji 10',
      'rating': 4.9,
      'duration': '55 min',
    },
    {
      'title': 'Mitoza dhe Meioza',
      'subject': 'Biologji 10',
      'rating': 4.6,
      'duration': '35 min',
    },
  ];

  final List<String> _filterChips = [
    'Struktura e qelizës',
    'Kloroplastet dhe pigmentet',
    'Divizioni qelizor',
    'Gjenetika',
  ];

  final List<Map<String, String>> _mentors = [
    {'name': 'Arben', 'active': 'true'},
    {'name': 'Endrit', 'active': 'true'},
    {'name': 'Lira', 'active': 'true'},
    {'name': 'Alba', 'active': 'false'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleBookmark(int index, bool isRecommended) {
    setState(() {
      if (isRecommended) {
        if (_bookmarkedRecommended.contains(index)) {
          _bookmarkedRecommended.remove(index);
        } else {
          _bookmarkedRecommended.add(index);
        }
      } else {
        if (_bookmarkedLessons.contains(index)) {
          _bookmarkedLessons.remove(index);
        } else {
          _bookmarkedLessons.add(index);
        }
      }
    });
  }

  void _onLessonTap(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening: $title'),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF1E3A5F),
      ),
    );
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: _selectedTabIndex == 0
            ? _buildHomeContent()
            : _buildOtherTabContent(),
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  Widget _buildOtherTabContent() {
    final List<String> tabNames = [
      'Kryefaqe',
      'Eksploro',
      'Mësimet',
      'Classroom',
      'Profili'
    ];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getTabIcon(_selectedTabIndex),
            size: 64,
            color: Colors.white54,
          ),
          const SizedBox(height: 16),
          Text(
            tabNames[_selectedTabIndex],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Coming soon...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTabIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home_rounded;
      case 1:
        return Icons.explore_rounded;
      case 2:
        return Icons.menu_book_rounded;
      case 3:
        return Icons.calendar_today_rounded;
      case 4:
        return Icons.person_rounded;
      default:
        return Icons.home_rounded;
    }
  }

  Widget _buildHomeContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildTitle(),
              const SizedBox(height: 28),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildFilterChips(),
              const SizedBox(height: 32),
              _buildBestLessonsSection(),
              const SizedBox(height: 36),
              _buildMentorsSection(),
              const SizedBox(height: 36),
              _buildRecommendedSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Përshëndetje',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Aleks Lime 👋',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('You have 3 new notifications'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      const Center(
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF3B30),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTabIndex = 4;
                  });
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Gjej Mësimin Tënd të\nPreferuar',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.15,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(28),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: 'Biologji',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.4),
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 20, right: 12),
              child: Icon(
                Icons.search,
                color: Colors.black38,
                size: 24,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 56,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _filterChips.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedChipIndex == index;
          return Padding(
            padding: EdgeInsets.only(right: index < _filterChips.length - 1 ? 12 : 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedChipIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Center(
                  child: Text(
                    _filterChips[index],
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBestLessonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Mësimet më të mira',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _lessons.length,
            itemBuilder: (context, index) {
              return _buildLessonCard(
                _lessons[index],
                index,
                false,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLessonCard(Map<String, dynamic> lesson, int index, bool isRecommended) {
    final isBookmarked = isRecommended
        ? _bookmarkedRecommended.contains(index)
        : _bookmarkedLessons.contains(index);

    return Padding(
      padding: EdgeInsets.only(right: index < _lessons.length - 1 ? 16 : 0),
      child: GestureDetector(
        onTap: () => _onLessonTap(lesson['title']),
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF7BA5D6),
                const Color(0xFF6B95C6),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      lesson['title'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        height: 1.2,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _toggleBookmark(index, isRecommended),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                lesson['subject'],
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          lesson['rating'].toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.black,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          lesson['duration'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMentorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Mentorë të Njohur',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Showing all mentors...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'Shiko më shumë',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white.withOpacity(0.7),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _mentors.length,
            itemBuilder: (context, index) {
              return _buildMentorAvatar(
                _mentors[index]['name']!,
                _mentors[index]['active'] == 'true',
                index,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMentorAvatar(String name, bool isActive, int index) {
    return Padding(
      padding: EdgeInsets.only(right: index < _mentors.length - 1 ? 16 : 0),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Viewing $name\'s profile'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF9BB8D3) : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: isActive ? Colors.white : Colors.black,
                size: 36,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Mësimet e Rekomanduara',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _recommendedLessons.length,
            itemBuilder: (context, index) {
              return _buildLessonCard(
                _recommendedLessons[index],
                index,
                true,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_rounded, 'Kryefaqe'),
              _buildNavItem(1, Icons.eco_rounded, 'Eksploro'),
              _buildNavItem(2, Icons.collections_rounded, 'Mësimet'),
              _buildNavItem(3, Icons.calendar_today_rounded, 'Classroom'),
              _buildNavItem(4, Icons.person_rounded, 'Profili'),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: 134,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.white,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
