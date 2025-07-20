import 'package:flutter/material.dart';
import '../widgets/simple_calendar.dart';
import '../widgets/subject_card.dart';
import 'add_submission_page.dart';
import 'notification_page.dart';
import 'profile_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Your subject data
  final List<Map<String, String>> subjects = [
    {
      'imageUrl': 'assets/agerii2.jpg',
      'nvqLevel': 'NVQ 4',
      'subjectName': 'A01S018F4.0 - Plant Tissue Culture Laboratory Assistant',
    },
    {
      'imageUrl': 'assets/agri.jpeg',
      'nvqLevel': 'NVQ 6',
      'subjectName': 'SUB-O3-Plantation & Export Agricultural Crop Production',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2F0), // Light background color from image
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Hi, Dinux👋',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfilePage()),
                        );
                      },
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/man.jpg'),
                        radius: 22,
                      ),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.menu),
                    hintText: 'Hinted search text',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
              ),

              const SizedBox(height: 18),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  'My Subjects',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              const SizedBox(height: 12),

              // Subject Carousel with Overlaid Arrows
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 250, // Adjust height to fit your SubjectCard
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: subjects.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final subject = subjects[index];
                        return SubjectCard(
                          imageUrl: subject['imageUrl']!,
                          nvqLevel: subject['nvqLevel']!,
                          subjectName: subject['subjectName']!,
                        );
                      },
                    ),
                  ),
                  // Navigation Arrows
                  if (_currentPage > 0)
                    Positioned(
                      left: 10,
                      child: IconButton(
                        icon: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black54),
                        ),
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  if (_currentPage < subjects.length - 1)
                    Positioned(
                      right: 10,
                      child: IconButton(
                        icon: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.arrow_forward_ios, color: Colors.black54),
                        ),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // Static Calendar
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: SimpleCalendar(),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context, 0),
    );
  }
}

Widget buildBottomNavBar(BuildContext context, int currentIndex) {
  return BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.cloud_upload), label: 'Upload'),
      BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
    currentIndex: currentIndex,
    selectedItemColor: Colors.blue[900],
    unselectedItemColor: Color(0xFF8A8A8A),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
    onTap: (index) {
      if (index == currentIndex) return;
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AddSubmissionPage()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NotificationPage()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
          break;
      }
    },
  );
}
