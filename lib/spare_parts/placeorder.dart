// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void main() {
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//     ),
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'Poppins',
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.grey[50],
//       ),
//       home: const CashOnDeliveryScreen(),
//     );
//   }
// }
//
// class CashOnDeliveryScreen extends StatefulWidget {
//   const CashOnDeliveryScreen({super.key});
//
//   @override
//   State<CashOnDeliveryScreen> createState() => _CashOnDeliveryScreenState();
// }
//
// class _CashOnDeliveryScreenState extends State<CashOnDeliveryScreen> {
//   bool _agreeToPayInCash = true;
//   String _deliveryAddress = 'Temple Rd, Galle';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[50],
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           'Cash on Delivery',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         leading: Container(
//           margin: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             shape: BoxShape.circle,
//           ),
//           child: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           const Divider(height: 1, thickness: 1),
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(0),
//               children: [
//                 _buildAddressSection(),
//                 const Divider(height: 1, thickness: 1),
//                 _buildOrderSummarySection(),
//                 const Divider(height: 1, thickness: 1),
//                 _buildPaymentInstructions(),
//                 _buildAgreementCheckbox(),
//                 const SizedBox(height: 40),
//                 _buildPlaceOrderButton(),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAddressSection() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Delivery Address',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 _deliveryAddress,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//           IconButton(
//             icon: const Icon(Icons.edit, color: Colors.black),
//             onPressed: () async {
//               String? newAddress = await showDialog<String>(
//                 context: context,
//                 builder: (BuildContext context) {
//                   String tempAddress = _deliveryAddress;
//                   return AlertDialog(
//                     title: const Text('Edit Address'),
//                     content: TextField(
//                       onChanged: (value) {
//                         tempAddress = value;
//                       },
//                       controller: TextEditingController(text: _deliveryAddress),
//                       decoration: const InputDecoration(
//                         hintText: 'Enter new delivery address',
//                       ),
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context, null);
//                         },
//                         child: const Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context, tempAddress);
//                         },
//                         child: const Text('Save'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//               if (newAddress.isNotEmpty) {
//                 setState(() {
//                   _deliveryAddress = newAddress;
//                 });
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildOrderSummarySection() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Order Summary',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Text('Items', style: TextStyle(fontSize: 16)),
//               Text('Rs 4000', style: TextStyle(fontWeight: FontWeight.w600)),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Text('Delivery Charges', style: TextStyle(fontSize: 16)),
//               Text('Rs 350', style: TextStyle(fontWeight: FontWeight.w600)),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Text('Total Amount',
//                   style: TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold)),
//               Text('Rs 4350',
//                   style: TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPaymentInstructions() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           Icon(Icons.lock, size: 24),
//           SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               'Please keep exact amount ready for the delivery',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAgreementCheckbox() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 _agreeToPayInCash = !_agreeToPayInCash;
//               });
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.grey,
//                   width: 1,
//                 ),
//               ),
//               child: Container(
//                 margin: const EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color:
//                   _agreeToPayInCash ? Colors.black : Colors.transparent,
//                 ),
//                 child: _agreeToPayInCash
//                     ? const Icon(Icons.check,
//                     size: 18, color: Colors.white)
//                     : const SizedBox(width: 18, height: 18),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Text(
//               'I agree to pay in cash upon delivery',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPlaceOrderButton() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: SizedBox(
//         width: double.infinity,
//         height: 55,
//         child: ElevatedButton(
//           onPressed: () {
//             if (_agreeToPayInCash) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Order placed successfully!'),
//                 ),
//               );
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Please agree to pay in cash.'),
//                 ),
//               );
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF0A2472),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30),
//             ),
//             elevation: 2,
//           ),
//           child: const Text(
//             'Place Order',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
