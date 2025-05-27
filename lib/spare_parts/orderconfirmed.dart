import 'package:flutter/material.dart';

void main() {
  runApp(OrderConfirmedApp());
}

class OrderConfirmedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrderConfirmedPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OrderConfirmedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Phone image with check mark
                Container(
                  height: 250,
                  child: Image.asset(
                    'assets/images/order_confirm.png', // Replace with your image asset
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 40),

                // Order Confirmed Text
                Text(
                  'Order Confirmed!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 12),

                // Confirmation message
                Text(
                  'Your order has been confirmed, we will send\nyou confirmation email shortly.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 40),

                // OK button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF001B7D),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'ok',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
