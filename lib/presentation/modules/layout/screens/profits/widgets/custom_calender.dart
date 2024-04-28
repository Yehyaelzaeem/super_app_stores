import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendar extends StatefulWidget {
  final Function(DateTime) onDateChange;

  const CustomCalendar({Key? key, required this.onDateChange}) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _selectedDate = DateTime.now();
  int _currentMonth = DateTime.now().month;
  int _currentYear = DateTime.now().year;

  void _handleDateChange(DateTime date) {
    setState(() {
      _selectedDate = date;
      widget.onDateChange(date);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _currentMonth++;
      if (_currentMonth > 12) {
        _currentMonth = 1;
        _currentYear++;
      }
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      _currentMonth--;
      if (_currentMonth < 1) {
        _currentMonth = 12;
        _currentYear--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _goToPreviousMonth,
            ),
            Text('${DateFormat.MMMM().format(DateTime(_currentYear, _currentMonth))} $_currentYear'),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: _goToNextMonth,
            ),
          ],
        ),
        // Include your calendar UI here or use the HorizontalWeekCalendar widget
        // For simplicity, let's use a Text widget to display the selected date
        Text('Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
      ],
    );
  }
}
