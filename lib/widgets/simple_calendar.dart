import 'package:flutter/material.dart';

class SimpleCalendar extends StatelessWidget {
  const SimpleCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Text(
            'December\n2024',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          // Placeholder for calendar grid
          Container(
            height: 80,
            color: Colors.transparent,
            child: const Center(child: Text('Calendar Grid')),
          ),
        ],
      ),
    );
  }
} 