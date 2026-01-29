import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'upload_page.dart';
import 'homepage.dart';
import 'notification_page.dart';
import 'profile_page.dart';

class AddSubmissionPage extends StatefulWidget {
  final DateTime? lastModified;
  const AddSubmissionPage({super.key, this.lastModified});

  @override
  State<AddSubmissionPage> createState() => _AddSubmissionPageState();
}

class _AddSubmissionPageState extends State<AddSubmissionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2F0),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom header with white border
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A3C6B), Color(0xFF3B6BA5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                border: Border(
                  top: BorderSide(color: Colors.white, width: 40),
                ),
              ),
              padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Upload Files',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // To balance the back arrow
                ],
              ),
            ),
            // Dates
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Open Date :  Saturday, 21 December 2024, 12:00 AM',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Due Date   :  Tuesday, 21 January 2024, 11:59 PM',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            // Submission Status Card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Submission Status',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Submission Status :', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                              const SizedBox(height: 14),
                              const Text('Open Date    :   Saturday, 21 December 2024, 12:00 AM', style: TextStyle(fontSize: 14)),
                              const SizedBox(height: 10),
                              const Text('Due Date     :   Tuesday, 21 January 2024, 11:59 PM', style: TextStyle(fontSize: 14)),
                              const SizedBox(height: 10),
                              Text(
                                widget.lastModified != null
                                    ? 'Last Modified : ${DateFormat('EEEE, d MMMM yyyy, hh:mm a').format(widget.lastModified!)}'
                                    : 'Last Modified :',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              const Text('Submission Comment :', style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A3C6B),
                              minimumSize: const Size(0, 54),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const UploadPage()),
                              );
                            },
                            child: const Text('Add Submission', style: TextStyle(color: Colors.white))),
                          ),
                      
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context, 1),
    );
  }
}

Widget buildBottomNavBar(BuildContext context, int currentIndex) {
  return BottomNavigationBar(
    backgroundColor: const Color(0xFFF7F2F0),
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.cloud_upload), label: 'Upload'),
      BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
    currentIndex: currentIndex,
    selectedItemColor: const Color(0xFF1A3C6B),
    unselectedItemColor: const Color(0xFF8A8A8A),
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
