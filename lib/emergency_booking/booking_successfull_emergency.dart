import 'package:flutter/material.dart';

class BookingUnsuccessfulScreen extends StatelessWidget {
  const BookingUnsuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Unsuccessful Illustration
                        SizedBox(
                          height: 380,
                          child: Image.asset(
                            'assets/images/booking_unsucessful_alert.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Unsuccessful Title
                        const Text(
                          'Booking Unsuccessful!',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A1A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        // Unsuccessful Message
                        const Text(
                          'We have reached the maximum bookings for this day (6 appointments). Please try another day.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF8E8E8E),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),

                        // Divider
                        const Divider(
                          color: Color(0xFFE0E0E0),
                          thickness: 1,
                          indent: 40,
                          endIndent: 40,
                        ),
                        const SizedBox(height: 30),

                        // Try Another Day Button
                        SizedBox(
                          width: 305,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate back to booking screen
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0A2885),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Try Another Day',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
