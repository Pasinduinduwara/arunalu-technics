import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool saveCardInfo = false;
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  final List<Map<String, dynamic>> _cards = [
    {
      'name': 'Devindi',
      'type': 'Visa Classic',
      'number': '5254 **** **** 7690',
      'balance': 'Rs 1000',
      'colors': [Color(0xFFFFD54F), Color(0xFFFFAB40), Color(0xFFFF8A65)],
      'logoPath': 'assets/images/card 1.png',
    },
    {
      'name': 'Martin',
      'type': 'Visa Platinum',
      'number': '5382 **** **** 3920',
      'balance': '\$2,500',
      'colors': [Color(0xFFE0F2F1), Color(0xFF4DB6AC), Color(0xFF00796B)],
      'logoPath': 'assets/images/card 3.png',
    },
    {
      'name': 'Sarah',
      'type': 'Mastercard Gold',
      'number': '4278 **** **** 5612',
      'balance': '€1,750',
      'colors': [Color(0xFFE1F5FE), Color(0xFF4FC3F7), Color(0xFF0277BD)],
      // logoPath omitted intentionally
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final card = _cards[_currentPage];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _cards.length,
                itemBuilder: (context, index) {
                  final card = _cards[index];
                  double scale = _currentPage == index ? 1.0 : 0.9;
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.9, end: scale),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, double value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: List<Color>.from(card['colors']),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                card['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (card['logoPath'] != null)
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    card['logoPath'],
                                    height: 20,
                                    color: Colors.white,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.credit_card,
                                                color: Colors.white),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Text(
                            card['type'],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            card['number'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            card['balance'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_cards.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentPage == index
                        ? const Color(0xFF0D2F8F)
                        : Colors.grey.withOpacity(0.3),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            buildLabel('Card Owner'),
            buildTextField(card['name']),
            const SizedBox(height: 20),
            buildLabel('Card Number'),
            buildTextField(card['number'].replaceAll('*', '0'), isNumber: true),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel('EXP'),
                      buildTextField('24/24', isNumber: true),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel('CVV'),
                      buildTextField('7763', isNumber: true, isObscure: true),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Save card info',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Switch(
                  value: saveCardInfo,
                  onChanged: (value) {
                    setState(() {
                      saveCardInfo = value;
                    });
                  },
                  activeColor: Colors.green,
                  activeTrackColor: Colors.green.withOpacity(0.5),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D2F8F),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment processing...')),
                );
              },
              child: const Text(
                'Pay Now',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget buildTextField(String hintText,
      {bool isNumber = false, bool isObscure = false}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        obscureText: isObscure,
      ),
    );
  }
}
