import 'package:flutter/material.dart';
import 'package:arunalu/starting_screens/home.dart';
import 'package:arunalu/emergency_booking/emergency_booking.dart';
import 'package:arunalu/normal_booking/normal_booking.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  bool isUpcoming = true;

  List<Map<String, dynamic>> appointments = [
    {
      'technician': 'S.A. devindi',
      'device': 'LED TV',
      'issue': 'Screen Issue',
      'date': 'May 10, 2025',
      'time': '10.00 PM',
      'isEmergency': true,
    },
    {
      'technician': 'S.A. devindi',
      'device': 'LED TV',
      'issue': 'No Power',
      'date': 'May 5, 2025',
      'time': '8.00 AM',
      'isEmergency': false,
    },
    {
      'technician': 'S.A. devindi',
      'device': 'LED TV',
      'issue': 'No Power',
      'date': 'May 5, 2025',
      'time': '8.00 AM',
      'isEmergency': false,
    },
    {
      'technician': 'S.A. devindi',
      'device': 'Oled TV',
      'issue': 'Audio Repair',
      'date': 'May 5, 2025',
      'time': '8.00 AM',
      'isEmergency': true,
    },
    {
      'technician': 'S.A. devindi',
      'device': 'LCD TV',
      'issue': 'No Power',
      'date': 'May 5, 2025',
      'time': '8.00 AM',
      'isEmergency': false,
    },
    {
      'technician': 'S.A. devindi',
      'device': 'Oled TV',
      'issue': 'Audio Repair',
      'date': 'May 5, 2025',
      'time': '8.00 AM',
      'isEmergency': true,
    },
  ];

  void _deleteAppointment(int index) {
    setState(() {
      final deletedAppointment = appointments.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Appointment for ${deletedAppointment['device']} on ${deletedAppointment['date']} has been deleted'),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  Future<void> _handleScheduleButtonPress(BuildContext context, bool isEmergency, int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Schedule'),
        content: const Text('This will remove the appointment and take you to booking. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Continue'),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      _deleteAppointment(index);
      if (isEmergency) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EmergencyBookingScreen(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AppointmentBookingScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Appointments',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.arrow_back_ios, color: Colors.black54, size: 18),
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
                  (route) => false,
            );
          },
        ),
      ),