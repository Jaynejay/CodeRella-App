import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final String imageUrl;
  final String nvqLevel;
  final String subjectName;
  final Widget calendar;

  const SubjectCard({
    super.key,
    required this.imageUrl,
    required this.nvqLevel,
    required this.subjectName,
    required this.calendar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  nvqLevel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          subjectName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        calendar,
      ],
    );
  }
} 