import 'package:flutter/material.dart';

class SimpleCalendar extends StatefulWidget {
  const SimpleCalendar({super.key});

  @override
  State<SimpleCalendar> createState() => _SimpleCalendarState();
}

class _SimpleCalendarState extends State<SimpleCalendar> {
  late DateTime _currentMonth;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade900),
      ),
      child: Column(
        children: [
          // Calendar header with month/year and navigation
          _buildCalendarHeader(),

          // Day names header
          _buildDaysOfWeekHeader(),

          // Calendar grid with fixed height
          SizedBox(
            height: 250, // Fixed height to show full calendar grid
            child: _buildCalendarGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.blue[900]),
            onPressed: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year,
                  _currentMonth.month - 1,
                  1,
                );
              });
            },
          ),
          Text(
            '${_getMonthName(_currentMonth.month)} ${_currentMonth.year}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, color: Colors.blue[900]),
            onPressed: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year,
                  _currentMonth.month + 1,
                  1,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDaysOfWeekHeader() {
    final List<String> weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weekdays.map((day) {
          return Expanded(
            child: Text(
              day,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    // Calculate first day of the displayed month
    final DateTime firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    // Calculate what day of week the first day falls on (0 = Sunday, 1 = Monday, etc.)
    final int firstWeekdayOfMonth = firstDayOfMonth.weekday % 7;
    // Calculate how many days in the month
    final int daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

    // Create list of dates to display
    final List<DateTime?> daysToDisplay = List.generate(42, (index) {
      if (index < firstWeekdayOfMonth) {
        return null; // Empty cell before the first day of month
      } else if (index < firstWeekdayOfMonth + daysInMonth) {
        return DateTime(_currentMonth.year, _currentMonth.month, index - firstWeekdayOfMonth + 1);
      } else {
        return null; // Empty cell after the last day of month
      }
    });

    // Display dates in 6 rows of 7 columns grid
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      childAspectRatio: 1.2,
      padding: const EdgeInsets.all(8),
      children: daysToDisplay.map((date) {
        if (date == null) {
          return const SizedBox.shrink(); // Empty cell
        }

        final bool isSelected = _isSameDay(date, _selectedDay);
        final bool isToday = _isSameDay(date, DateTime.now());

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDay = date;
            });
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue[100] : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontWeight: isToday || isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.blue[900] : Colors.black87,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _getMonthName(int month) {
    const List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}
