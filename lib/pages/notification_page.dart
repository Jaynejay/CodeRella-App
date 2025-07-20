import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'homepage.dart';
import 'add_submission_page.dart';
import 'profile_page.dart';

class NotificationItem {
  final String id;
  final String message;
  final String timeAgo;
  final String fullMessage;
  final String date;
  final IconData icon;
  final bool isExpanded;

  NotificationItem({
    required this.id,
    required this.message,
    required this.timeAgo,
    required this.fullMessage,
    required this.date,
    required this.icon,
    this.isExpanded = false,
  });

  NotificationItem copyWith({bool? isExpanded}) {
    return NotificationItem(
      id: id,
      message: message,
      timeAgo: timeAgo,
      fullMessage: fullMessage,
      date: date,
      icon: icon,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      message: 'You have submitted y...',
      timeAgo: '2 days ago',
      fullMessage: 'You have submitted your assignment for Agricultural Crop Production.',
      date: '18/12/2024',
      icon: Icons.chat_bubble_outline,
    ),
    NotificationItem(
      id: '2',
      message: 'You assigned for SUB....',
      timeAgo: '2 days ago',
      fullMessage: 'You assigned for SUB12 Plantation & Export Agricultural Crop Production.',
      date: '20/12/2024',
      icon: Icons.format_list_bulleted,
    ),
    NotificationItem(
      id: '3',
      message: 'New assignment available...',
      timeAgo: '1 day ago',
      fullMessage: 'New assignment available for Crop Management Systems.',
      date: '19/12/2024',
      icon: Icons.assignment,
    ),
    NotificationItem(
      id: '4',
      message: 'Grade updated for...',
      timeAgo: '3 days ago',
      fullMessage: 'Grade updated for your Agricultural Economics submission.',
      date: '17/12/2024',
      icon: Icons.grade,
    ),
  ];

  void _toggleNotification(String id) {
    setState(() {
      notifications = notifications.map((notification) {
        if (notification.id == id) {
          return notification.copyWith(isExpanded: !notification.isExpanded);
        }
        return notification;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2F0), // Light beige background
      body: Column(
        children: [
          // Custom header with extra top padding
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
                      'Notifications',
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
          // Content with adjusted padding
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationItem(notification);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFF7F2F0),
        child: buildBottomNavBar(context, 2),
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => _toggleNotification(notification.id),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF23272F), // darker gray for icon bg
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        notification.icon,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.message,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF22223B), // darker text
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notification.timeAgo,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF8A8A8A), // lighter gray
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      notification.isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: const Color(0xFF8A8A8A),
                    ),
                  ],
                ),
                if (notification.isExpanded) ...[
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.only(left: 52),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFF23272F),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                notification.icon,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              notification.date,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF374151),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          notification.fullMessage,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF22223B),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
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
}
