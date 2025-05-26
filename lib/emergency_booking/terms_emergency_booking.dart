import 'package:flutter/material.dart';
import 'package:arunalu/emergency_booking/booking_sucessful_emergency.dart';
import 'package:arunalu/emergency_booking/booking_unsucessful_emergency.dart';

class TermsConditionsScreen extends StatelessWidget {
  final Map<String, String> bookingData;
  final int appointmentsCount;

  const TermsConditionsScreen({
    Key? key,
    required this.bookingData,
    required this.appointmentsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF9F9F9),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      TermItem(
                        number: 1,
                        title: 'Service Booking:',
                        description: 'Users must provide accurate information when booking a repair.',
                      ),
                      SizedBox(height: 30),
                      TermItem(
                        number: 2,
                        title: 'Appointment Changes:',
                        description: 'Bookings can be rescheduled up to 24 hours before the appointment.',
                      ),
                      SizedBox(height: 30),
                      TermItem(
                        number: 3,
                        title: 'Payment:',
                        description: 'Charges may vary based on issue type. Payment is due after service completion.',
                      ),
                      SizedBox(height: 30),
                      TermItem(
                        number: 4,
                        title: 'Warranty:',
                        description: 'Repairs may include limited warranty based on parts replaced.',
                      ),
                      SizedBox(height: 30),
                      TermItem(
                        number: 5,
                        title: 'Liability:',
                        description: 'We are not responsible for damages caused by user mishandling before or after repair.',
                      ),
                      SizedBox(height: 30),
                      TermItem(
                        number: 6,
                        title: 'Cancellations:',
                        description: 'Cancellations made less than 12 hours before may incur a fee.',
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Check appointment limit (max 6 per day)
                      if (appointmentsCount >= 6) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BookingUnsuccessfulScreen(),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BookingSuccessfulScreen(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A2885),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Agree & Confirm Booking',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class TermItem extends StatelessWidget {
  final int number;
  final String title;
  final String description;

  const TermItem({
    Key? key,
    required this.number,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number.',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '$title ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: description,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
