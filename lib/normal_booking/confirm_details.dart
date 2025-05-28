import 'package:flutter/material.dart';
import 'package:arunalu/normal_booking/booking_sucessful_normal_booking.dart';
import 'package:arunalu/normal_booking/booking_unsucessful_normal_booking.dart';
import 'package:arunalu/normal_booking/normal_booking.dart';


class ConfirmDetailsScreen extends StatefulWidget {
  final String selectedDate;
  final String selectedTime;
  final bool isMorning;

  const ConfirmDetailsScreen({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.isMorning,
  });

  @override
  State<ConfirmDetailsScreen> createState() => _ConfirmDetailsScreenState();
}

class _ConfirmDetailsScreenState extends State<ConfirmDetailsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final String _selectedServiceType = ''; // Made final as suggested

  Widget _buildBookingSummary() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Appointment Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 20),
                const SizedBox(width: 8),
                Text(
                  widget.selectedDate,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  widget.isMorning ? Icons.wb_sunny : Icons.nightlight_round,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.selectedTime,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildDropdownField() {
    String dropdownValue = _selectedServiceType;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Service Type',
          labelStyle: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          border: InputBorder.none,
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        value: dropdownValue.isEmpty ? null : dropdownValue,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>[
          'Consultation',
          'Maintenance',
          'Installation',
          'Repair',
          'Other',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        isExpanded: true,
      ),
    );
  }

Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          final allFieldsComplete = _nameController.text.isNotEmpty &&
              _emailController.text.isNotEmpty &&
              _contactController.text.isNotEmpty &&
              _selectedServiceType.isNotEmpty;

          if (allFieldsComplete) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BookingSuccessScreen(
                  bookingDate: widget.selectedDate,
                  bookingTime: widget.selectedTime,
                ),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BookingUnsuccessfulScreen(
                  errorMessage: 'Please fill all required fields',
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0C2D83),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Confirm',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 16,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Confirm Your Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBookingSummary(),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _nameController,
                labelText: 'Name',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildDropdownField(),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _contactController,
                labelText: 'Contact',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 40),
              _buildConfirmButton(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }
}