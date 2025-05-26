import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentBookingScreen> createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  int selectedDateIndex = 0;
  String selectedTimeSlot = '';
  bool isMorningSelected = true;

  List<DateTime> get nextTenDays {
    DateTime today = DateTime.now();
    return List.generate(10, (index) => today.add(Duration(days: index)));
  }

  List<String> get currentSlots {
    return List.generate(12, (i) => isMorningSelected ? 'M${i + 1}' : 'A${i + 1}');
  }

  @override
  Widget build(BuildContext context) {
    final dates = nextTenDays;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildDateSection(dates),
                const SizedBox(height: 30),
                _buildAvailableBookingsSection(),
                const SizedBox(height: 30),
                _buildBookButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          'Book An Appointment',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDateSection(List<DateTime> dates) {
    final String monthYear = DateFormat('MMMM yyyy').format(dates.first);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          monthYear,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0,
          ),
          itemCount: dates.length,
          itemBuilder: (context, index) {
            final date = dates[index];
            final day = DateFormat('E').format(date);
            final dayNum = date.day.toString();
            final isSelected = selectedDateIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDateIndex = index;
                  selectedTimeSlot = ''; // Reset slot when changing date
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      dayNum,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAvailableBookingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Bookings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildTimeOfDaySelector(),
        const SizedBox(height: 20),
        _buildTimeSlots(),
      ],
    );
  }

  Widget _buildTimeOfDaySelector() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: isMorningSelected ? const Color(0xFF0A2472) : Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  isMorningSelected = true;
                  selectedTimeSlot = '';
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wb_sunny,
                    color: isMorningSelected ? Colors.white : Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Morning',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isMorningSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: !isMorningSelected ? const Color(0xFF0A2472) : Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  isMorningSelected = false;
                  selectedTimeSlot = '';
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.nightlight_round,
                    color: !isMorningSelected ? Colors.white : Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Afternoon',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: !isMorningSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlots() {
    final List<String> slots = currentSlots;

    return Column(
      children: List.generate(3, (row) {
        final rowSlots = slots.skip(row * 4).take(4).toList();
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowSlots.map((slot) => _buildTimeSlotItem(slot)).toList(),
          ),
        );
      }),
    );
  }

  Widget _buildTimeSlotItem(String slot) {
    final bool isSelected = selectedTimeSlot == slot;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTimeSlot = slot;
        });
      },
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            slot,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: selectedTimeSlot.isEmpty
            ? null
            : () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Appointment booked for ${DateFormat('EEE, MMM d').format(nextTenDays[selectedDateIndex])} at $selectedTimeSlot')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0A2472),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Book An Appointment',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// For testing
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AppointmentBookingScreen(),
  ));
}
