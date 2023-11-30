import 'package:exercise_flutter_acs/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';

class ScheduleEmployeesScreen extends StatefulWidget {
  final UserGroup userGroup;
  const ScheduleEmployeesScreen({super.key, required this.userGroup});

  @override
  _ScheduleEmployeesScreenState createState() =>
      _ScheduleEmployeesScreenState();
}

class _ScheduleEmployeesScreenState extends State<ScheduleEmployeesScreen> {
  late DateTime _startDate;
  late DateTime _endDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late List<bool> _days;
  final DateFormat _dateFormat = DateFormat.yMd();

  @override
  void initState() {
    super.initState();
    _startDate = widget.userGroup.schedule.fromDate;
    _endDate = widget.userGroup.schedule.toDate;
    _startTime = widget.userGroup.schedule.fromTime;
    _endTime = widget.userGroup.schedule.toTime;
    _days = [];
    for (var i = 1; i <= 7; i++) {
      _days.add(widget.userGroup.schedule.weekdays.contains(i));
    }
  }

  Future<void> _pickDate(BuildContext context, bool start, DateTime initialDate,
      Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
    );
    if (picked != null && picked != initialDate) {
      if (start) {
        _startDate = picked;
      } else {
        _endDate = picked;
      }
      setState(() => onDateSelected(picked));
    }
  }

  Future<void> _pickTime(BuildContext context, bool start,
      TimeOfDay initialTime, Function(TimeOfDay) onTimeSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null && picked != initialTime) {
      if (start) {
        _startTime = picked;
      } else {
        _endTime = picked;
      }
      setState(() => onTimeSelected(picked));
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Accept'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Employees'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('From'),
              subtitle: Text(_dateFormat.format(_startDate)),
              trailing: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _pickDate(
                    context, true, _startDate, (date) => _startDate = date),
              ),
            ),
            ListTile(
              title: Text('To'),
              subtitle: Text(_dateFormat.format(_endDate)),
              trailing: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _pickDate(
                    context, false, _endDate, (date) => _endDate = date),
              ),
            ),
            WeekdaySelector(
              onChanged: (int day) {
                setState(() {
                  _days[day % 7] = !_days[day % 7];
                });
              },
              values: _days,
            ),
            ListTile(
              title: Text('From'),
              subtitle: Text('${_startTime.format(context)}'),
              trailing: IconButton(
                icon: Icon(Icons.access_time),
                onPressed: () => _pickTime(
                    context, true, _startTime, (time) => _startTime = time),
              ),
            ),
            ListTile(
              title: Text('To'),
              subtitle: Text('${_endTime.format(context)}'),
              trailing: IconButton(
                icon: Icon(Icons.access_time),
                onPressed: () => _pickTime(
                    context, false, _endTime, (time) => _endTime = time),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_endDate.isAfter(_startDate)) {
                    // Aquí se manejaría la lógica para guardar la programación
                    widget.userGroup.schedule.fromDate = _startDate;
                    widget.userGroup.schedule.toDate = _endDate;
                    widget.userGroup.schedule.fromTime = _startTime;
                    widget.userGroup.schedule.toTime = _endTime;
                    widget.userGroup.schedule.weekdays.clear();
                    for (var i = 0; i < 7; i++) {
                      if(_days[i]==true) widget.userGroup.schedule.weekdays.add(i+1);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Schedule Saved')),
                    );
                  } else {
                    _showErrorDialog(
                      'Range dates',
                      'The From date is after the To date. Please, select a new date range.',
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
