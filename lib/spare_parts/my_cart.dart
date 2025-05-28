
import 'package:flutter/material.dart';
import 'package:arunalu/starting_screens/home.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key}); // Changed to super.key

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  // Use a list to store cart items for easier management
  List<CartItem> cartItems = [
    CartItem(
      name: 'TV Dust Cover',
      price: 2300.00,
      quantity: 2,
      imagePath: 'assets/images/cart_image.png',
    ),
    CartItem(
      name: 'TV Wall Mount Stand',
      price: 1500.00,
      quantity: 1,
      imagePath: 'assets/images/cart_image.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double subtotal = cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
    double shippingFee = 0;
    double total = subtotal + shippingFee;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: cartItems.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return _buildCartItem(
                    item,
                        (value) {
                      if (value != null && value >= 1) {
                        setState(() {
                          item.quantity = value;
                        });
                      }
                    },
                        () {
                      setState(() {
                        cartItems.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),

            _buildSummaryRow('Sub-total', 'Rs.${subtotal.toStringAsFixed(0)}'),
            const SizedBox(height: 12),
            _buildSummaryRow('Shipping fee', 'Rs.${shippingFee.toStringAsFixed(0)}'),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Divider(thickness: 1),
            ),

            _buildSummaryRow('Total', 'Rs.${total.toStringAsFixed(0)}', isTotal: true),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A2885),
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Go To Checkout',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(CartItem item, Function(int?) onQuantityChanged, VoidCallback onDelete) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(item.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rs ${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: onDelete,
          ),

          Row(
            children: [
              _buildQuantityButton(
                Icons.remove,
                    () {
                  if (item.quantity > 1) {
                    onQuantityChanged(item.quantity - 1);
                  }
                },
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  item.quantity.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              _buildQuantityButton(
                Icons.add,
                    () {
                  onQuantityChanged(item.quantity + 1);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 18),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class CartItem {
  final String name;
  final double price;
  int quantity;
  final String imagePath;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });
}