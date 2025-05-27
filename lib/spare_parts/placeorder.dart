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