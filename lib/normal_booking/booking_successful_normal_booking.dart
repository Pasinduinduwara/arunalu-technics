import 'package:flutter/material.dart';

class BookingSuccessScreen extends StatelessWidget {
  final String? bookingId;
  final String? bookingDate;
  final String? bookingTime;

  const BookingSuccessScreen({
    super.key,
    this.bookingId,
    this.bookingDate,
    this.bookingTime,
  });

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
                        // Success Illustration
                        SizedBox(
                          height: 250,
                          child: Image.asset(
                            'assets/images/booking_sucessful_alert.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Success Title
                        const Text(
                          'Booking Confirmed!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),

                        // Booking Details
                        if (bookingId != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Booking ID: $bookingId',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ),

                        if (bookingDate != null && bookingTime != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              '$bookingDate at $bookingTime',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ),

                        const SizedBox(height: 20),

                        // Success Message
                        const Text(
                          'Your appointment has been successfully booked. '
                          'A confirmation has been sent to your email.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),

                        // OK Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate back to home screen
                              Navigator.of(
                                context,
                              ).popUntil((route) => route.isFirst);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0A2885),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Back to Home',
                              style: TextStyle(
                                fontSize: 16,
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
