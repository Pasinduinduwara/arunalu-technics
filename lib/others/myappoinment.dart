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
      ),body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isUpcoming = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: isUpcoming ? const Color(0xFF0A2F87) : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Upcoming',
                        style: TextStyle(
                          color: isUpcoming ? Colors.white : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isUpcoming = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: !isUpcoming ? const Color(0xFF0A2F87) : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Past',
                        style: TextStyle(
                          color: !isUpcoming ? Colors.white : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return Dismissible(
                  key: Key(appointment['date'] + appointment['time']),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    _deleteAppointment(index);
                  },
                  child: AppointmentCard(
                    technician: appointment['technician'],
                    device: appointment['device'],
                    issue: appointment['issue'],
                    date: appointment['date'],
                    time: appointment['time'],
                    isUpcoming: isUpcoming,
                    isEmergency: appointment['isEmergency'],
                    onSchedulePressed: () {
                      _handleScheduleButtonPress(context, appointment['isEmergency'], index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String technician;
  final String device;
  final String issue;
  final String date;
  final String time;
  final bool isUpcoming;
  final bool isEmergency;
  final VoidCallback onSchedulePressed;

  const AppointmentCard({
    Key? key,
    required this.technician,
    required this.device,
    required this.issue,
    required this.date,
    required this.time,
    required this.isUpcoming,
    required this.isEmergency,
    required this.onSchedulePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    technician,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$device - $issue',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$date - $time',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isEmergency ? 'Emergency Booking' : 'Normal Booking',
                    style: TextStyle(
                      fontSize: 14,
                      color: isEmergency ? Colors.red : Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: isUpcoming ? onSchedulePressed : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isUpcoming
                      ? (isEmergency ? Colors.red : Colors.blue)
                      : Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  isUpcoming ? 'Schedule' : 'Completed',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}