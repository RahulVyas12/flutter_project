import 'package:flutter/material.dart';

class AdminTableBooking extends StatefulWidget {
  const AdminTableBooking({super.key});

  @override
  State<AdminTableBooking> createState() => _AdminTableBookingState();
}

class _AdminTableBookingState extends State<AdminTableBooking> {
  final List<Map<String, dynamic>> bookings = [
    {
      'name': 'Arsh Pathan',
      'table': 'Table no. 3',
      'date': 'Date 26/Jan/2025',
      'time': 'Time : 9:30 pm',
      'status': 'pending',
    },
    {
      'name': 'Arsh Pathan',
      'table': 'Table no. 3',
      'date': 'Date 26/Jan/2025',
      'time': 'Time : 9:30 pm',
      'status': 'pending',
    },
    {
      'name': 'Arsh Pathan',
      'table': 'Table no. 3',
      'date': 'Date 26/Jan/2025',
      'time': 'Time : 9:30 pm',
      'status': 'pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Table Booking',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          ...bookings.map((booking) => _buildBookingCard(booking)),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFFF5733), width: 2),
      ),
      child: Row(
        children: [
          // Profile Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.person, size: 40, color: Colors.pink),
          ),
          const SizedBox(width: 15),
          
          // Booking Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking['name'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  booking['table'],
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  booking['date'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  booking['time'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Column(
            children: [
              ElevatedButton(
                onPressed: () => _confirmBooking(booking),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _deleteBooking(booking),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmBooking(Map<String, dynamic> booking) {
    setState(() {
      bookings.remove(booking);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Booking confirmed successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deleteBooking(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Booking'),
        content: const Text('Are you sure you want to delete this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                bookings.remove(booking);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking deleted!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
