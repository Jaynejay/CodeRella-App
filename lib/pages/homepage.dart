import 'package:flutter/material.dart';
import '../widgets/subject_card.dart';
import '../widgets/simple_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> subjects = [
    {
      'imageUrl': 'https://images.unsplash.com/photo-1464983953574-0892a716854b',
      'nvqLevel': 'NVQ 4',
      'subjectName': 'A01S018F4.0 - Plant Tissue Culture Laboratory Assistant',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      'nvqLevel': 'NVQ 6',
      'subjectName': 'SUB-O3-Plantation & Export Agricultural Crop Production',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF2EDE6E3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back, size: 28),
                  const SizedBox(width: 8),
                  const Text(
                    'Hi, Dinux👋',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
                    radius: 22,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.menu),
                  hintText: 'Hinted search text',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'My Subjects',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 12),
              Stack(
                children: [
                  SizedBox(
                    height: 320,
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
                          calendar: const SimpleCalendar(),
                        );
                      },
                    ),
                  ),
                  if (_currentPage > 0)
                    Positioned(
                      left: 0,
                      top: 100,
                      child: GestureDetector(
                        onTap: () {
                          _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_back_ios, color: Colors.blue[900]),
                        ),
                      ),
                    ),
                  if (_currentPage < subjects.length - 1)
                    Positioned(
                      right: 0,
                      top: 100,
                      child: GestureDetector(
                        onTap: () {
                          _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_forward_ios, color: Colors.blue[900]),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
