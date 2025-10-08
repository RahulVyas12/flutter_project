import 'package:flutter/material.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({super.key});

  @override
  State<AdminOrders> createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> orders = [
    {
      'id': '#12345',
      'customer': 'Arsh Pathan',
      'items': 'Paneer Butter Masala x2, Dal Makhani x1',
      'total': 780,
      'status': 'Pending',
      'date': '8 Oct 2025, 2:30 PM',
      'phone': '+91 9011039271',
      'address': 'RKU Boys Hostel, Rajkot',
    },
    {
      'id': '#12346',
      'customer': 'Rahul Vyas',
      'items': 'Chicken Biryani x1, Gulab Jamun x2',
      'total': 510,
      'status': 'In Progress',
      'date': '8 Oct 2025, 1:15 PM',
      'phone': '+91 9810299389',
      'address': 'Golden Spot, Rajkot',
    },
    {
      'id': '#12347',
      'customer': 'Priya Shah',
      'items': 'Hakka Noodles x1, Manchurian x1',
      'total': 278,
      'status': 'Delivered',
      'date': '8 Oct 2025, 12:00 PM',
      'phone': '+91 9876543210',
      'address': 'ABC Building, Rajkot',
    },
    {
      'id': '#12348',
      'customer': 'John Doe',
      'items': 'Pizza x1, Pasta x1',
      'total': 650,
      'status': 'Pending',
      'date': '8 Oct 2025, 11:30 AM',
      'phone': '+91 9123456789',
      'address': 'XYZ Road, Rajkot',
    },
    {
      'id': '#12349',
      'customer': 'Jane Smith',
      'items': 'Full Thali x2',
      'total': 500,
      'status': 'Cancelled',
      'date': '8 Oct 2025, 10:00 AM',
      'phone': '+91 9234567890',
      'address': 'PQR Street, Rajkot',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredOrders = selectedFilter == 'All'
        ? orders
        : orders.where((order) => order['status'] == selectedFilter).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All Orders',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  ['All', 'Pending', 'In Progress', 'Delivered', 'Cancelled']
                      .map(
                        (filter) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(filter),
                            selected: selectedFilter == filter,
                            onSelected: (selected) {
                              setState(() {
                                selectedFilter = filter;
                              });
                            },
                            selectedColor: const Color(
                              0xFFFF5733,
                            ).withOpacity(0.3),
                            checkmarkColor: const Color(0xFFFF5733),
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              color: selectedFilter == filter
                                  ? const Color(0xFFFF5733)
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          const SizedBox(height: 20),

          // Orders List
          if (filteredOrders.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  'No orders found',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ),
            )
          else
            ...filteredOrders.map((order) => _buildOrderCard(order)),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFFF5733), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFFF5733).withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(13),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['id'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order['date'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                _buildStatusChip(order['status']),
              ],
            ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Customer Info
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 18,
                      color: Color(0xFFFF5733),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      order['customer'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Phone
                Row(
                  children: [
                    const Icon(Icons.phone, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      order['phone'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Address
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        order['address'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Items
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.restaurant,
                        size: 16,
                        color: Color(0xFFFF5733),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          order['items'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '₹${order['total']}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF5733),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Action Buttons
                Row(
                  children: [
                    if (order['status'] == 'Pending')
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _updateStatus(order, 'In Progress'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 18,
                          ),
                          label: const Text(
                            'Accept',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    if (order['status'] == 'In Progress') ...[
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _updateStatus(order, 'Delivered'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(
                            Icons.delivery_dining,
                            color: Colors.white,
                            size: 18,
                          ),
                          label: const Text(
                            'Mark Delivered',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                    if (order['status'] != 'Delivered' &&
                        order['status'] != 'Cancelled') ...[
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _cancelOrder(order),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 18,
                          ),
                          label: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                    if (order['status'] == 'Delivered' ||
                        order['status'] == 'Cancelled')
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _viewDetails(order),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade600,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(
                            Icons.visibility,
                            color: Colors.white,
                            size: 18,
                          ),
                          label: const Text(
                            'View Details',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Delivered':
        color = Colors.green;
        break;
      case 'In Progress':
        color = Colors.blue;
        break;
      case 'Cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _updateStatus(Map<String, dynamic> order, String newStatus) {
    setState(() {
      order['status'] = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order ${order['id']} updated to $newStatus'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _cancelOrder(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Cancel Order'),
        content: Text('Are you sure you want to cancel order ${order['id']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                order['status'] = 'Cancelled';
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Order ${order['id']} cancelled'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _viewDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text('Order ${order['id']}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Customer:', order['customer']),
              _buildDetailRow('Phone:', order['phone']),
              _buildDetailRow('Address:', order['address']),
              _buildDetailRow('Items:', order['items']),
              _buildDetailRow('Total:', '₹${order['total']}'),
              _buildDetailRow('Status:', order['status']),
              _buildDetailRow('Date:', order['date']),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5733),
            ),
            child: const Text('Close', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
