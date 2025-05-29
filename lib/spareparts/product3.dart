import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arunalu Technics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const ProductDetailPage(),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _currentImageIndex = 1;
  int _selectedColorIndex = 0;

  final List<String> _productImages = [
    'assets/images/headphone1.png',
    'assets/images/headphone2.png',
    'assets/images/headphone3.png',
    'assets/images/headphone4.png'
  ];

  final List<Color> _availableColors = [
    const Color(0xFF2E3A48), // Navy Blue
    const Color(0xFFE6DED1), // Beige
    const Color(0xFFD9D9D9), // Silver
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top navigation and action buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCircularButton(
                    icon: Icons.arrow_back_ios_new,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      _buildCircularButton(
                        icon: Icons.favorite_border,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 12),
                      _buildCircularButton(
                        icon: Icons.share,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Main product image
            Expanded(
              flex: 5,
              child: Center(
                child: Image.asset(
                  _productImages[_currentImageIndex],
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Image indicator dots
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _productImages.length,
                      (index) => Container(
                    width: index == _currentImageIndex ? 24.0 : 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: index == _currentImageIndex
                          ? const Color(0xFF0030AD)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ),
            ),

            // Product thumbnails
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _productImages.length,
                      (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: index == _currentImageIndex
                            ? Border.all(color: const Color(0xFF0030AD), width: 2.0)
                            : null,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14.0),
                        child: Image.asset(
                          _productImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),