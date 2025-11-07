import 'package:flutter/material.dart';
import 'package:packages/feature/%20%20table_calendar/Calender_screen.dart';

import '../+x_container/container_screen.dart';
import '../carousel_slider/carousel_Slider.dart';
import '../dialog/dialog_screen.dart';
import '../selected_star/selected_star.dart';
import '../shimmer_package/presentation/view/shimmer.dart';
import '../signature/signature_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  int? _expandedIndex;

  final List<Map<String, dynamic>> _packages = [
    {
      'title': 'table_calendar',
      'description':
      'The table_calendar package is one of the most popular Flutter packages used to display and manage calendar UIs — it lets you show monthly or weekly calendars, select single or multiple dates, and react to user selections easily.',
      'screen': const CalenderScreen(),
    },
    {
      'title': 'shimmer',
      'description': 'A package to create shimmer loading animations for placeholders.',
      'screen':  ShimmerScreen(),
    },
    {
      'title': 'carousel_slider',
      'description': 'The package carousel_slider: ^5.1.1 in Flutter is used to create image or widget carousels (sliders) easily. It’s one of the most popular Flutter packages for this purpose because it provides flexible, ready-to-use carousel functionality without writing complex custom code.',
      'screen':  CarouselExample(),
    },
    {
      'title': 'Signature',
      'description': '''The flutter_signature_pad package is a Flutter plugin that allows you to capture handwritten signatures directly from the user’s touch input — ideal for apps requiring digital authorization, e-signatures, or user consent.
      ''',
      'screen': const SignatureScreen(),
    },

  ];

  final List<Map<String, dynamic>> _apiRelated = [
    {
      'title': 'http',
      'description':
      'Performs network requests (GET, POST, PUT, DELETE) easily in Flutter.',
      'screen': const PackageDetailScreen(title: 'HTTP'),
    },
    {
      'title': 'shared_preferences',
      'description':
      'Stores small persistent data (like user info or theme preferences).',
      'screen': const PackageDetailScreen(title: 'Shared Preferences'),
    },
    {
      'title': 'flutter_svg',
      'description':
      'Renders SVG (Scalable Vector Graphics) easily within Flutter widgets.',
      'screen': const PackageDetailScreen(title: 'Flutter SVG'),
    },
  ];

  final List<Map<String, dynamic>> _functions = [
    {
      'title': 'Selected Star',
      'description': '💡 Core Concept\nThe star rating system works by: \n Keeping track of how many stars the user selected (_selectedStars).\n Using that number to color the stars (yellow for selected, grey for unselected).\n  Updating the state (setState) every time the user taps a star — this rebuilds the widget to reflect the new selection.\n\nfinal isSelected = index < _selectedStars;\nThat means — for every star before the selected number, color it yellow.',
      'screen':SelectedStar(),
    },
    {
      'title': 'resizeToAvoidBottomInset : false,',
      'description': 'The resizeToAvoidBottomInset property in a Scaffold controls whether the body of the Scaffold should resize when the on-screen keyboard appears (or when any system inset appears, like a bottom navigation bar or the keyboard).',
      'screen': const PackageDetailScreen(title: 'resizeToAvoidBottomInset'),
    },
    {
      'title': 'Dialog',
      'description': 'The resizeToAvoidBottomInset property in a Scaffold controls whether the body of the Scaffold should resize when the on-screen keyboard appears (or when any system inset appears, like a bottom navigation bar or the keyboard).',
      'screen': const DialogScreen(),
    },
    {
      'title': '+X” container',
      'description': 'It updates the UI when you tap the “+X” container — ',
      'screen': const XContainer(),
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

  Widget _buildPackageList(List<Map<String, dynamic>> list) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final package = list[index];
        final isExpanded = _expandedIndex == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade100,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              setState(() {
                _expandedIndex = isExpanded ? null : index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          package['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => package['screen'],
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Open',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward_ios,
                                  size: 15, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 400),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: const SizedBox.shrink(),
                    secondChild: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        package['description'],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavBar() {
    const items = [
      {'icon': Icons.add_chart, 'label': 'Add'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -2))
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isSelected = _currentIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
              },
              child: AnimatedContainer(
               height: 60,
                duration: const Duration(milliseconds: 300),
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.blue.shade100.withOpacity(0.5)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(items[index]['icon'] as IconData,
                        color: isSelected ? Colors.blue : Colors.grey),
                    const SizedBox(height: 2),
                    Text(
                      items[index]['label'] as String,
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.grey,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe6f2ff),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E88E5),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 80,
        title: const Text(
          'Flutter App Packages',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.greenAccent,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 2,vertical: 6),
          indicatorWeight: 3,
          unselectedLabelColor: Colors.white,
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.white,
          ),
          labelStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 17,color: Colors.white),
          tabs: [
            Tab(text: 'API Related'),
            Tab(text: 'Packages'),
            Tab(text: 'Functions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildPackageList(_apiRelated),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildPackageList(_packages),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildPackageList(_functions),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }
}

class PackageDetailScreen extends StatelessWidget {
  final String title;
  const PackageDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF1E88E5),
      ),
      body: Center(
        child: Text(
          'Details for $title',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
