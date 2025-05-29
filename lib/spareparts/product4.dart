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

            const SizedBox(height: 16),

            // Product details
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sony WH-1000XM5',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     const SizedBox(height: 4),
                    const Row(
                      children: [
                        Text(
                          'Rs.2500.00',
                          style: TextStyle(
                            color: Color(0xFF0030AD),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '|',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        for (int i = 0; i < _availableColors.length; i++)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColorIndex = i;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _availableColors[i],
                                border: _selectedColorIndex == i
                                    ? Border.all(
                                  color: Colors.black,
                                  width: 2,
                                )
                                    : null,
                              ),
                            ),
                          ),
                        const Spacer(),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 24,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '4.8',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(231)',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Action buttons
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Add to cart',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0030AD),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Buy Now',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Fix: This method is now properly placed **inside** the _ProductDetailPageState class.
  Widget _buildCircularButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.grey[600]),
        onPressed: onPressed,
      ),
    );
  }
}