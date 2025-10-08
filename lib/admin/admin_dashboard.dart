import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Total Orders', '453', const Color(0xFFFF5733)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildStatCard('Revenue', '₹ 35786', const Color(0xFFFF5733)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Restaurants', '50', const Color(0xFFFF5733)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildStatCard('Total Items', '325', const Color(0xFFFF5733)),
              ),
            ],
          ),
          
          const SizedBox(height: 30),
          
          // Recent Orders
          const Text(
            'Recent Orders',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _buildOrdersTable(),
          
          const SizedBox(height: 30),
          
          // User Reviews
          const Text(
            'User Reviews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _buildReviewsTable(),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color borderColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTable() {
    final orders = [
      {'id': '#12345', 'customer': 'Rahul', 'total': '₹500', 'status': 'Pending', 'date': '05-11-2024'},
      {'id': '#12345', 'customer': 'Rahul', 'total': '₹500', 'status': 'Pending', 'date': '05-11-2024'},
      {'id': '#12345', 'customer': 'Rahul', 'total': '₹500', 'status': 'Pending', 'date': '05-11-2024'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: const Row(
              children: [
                Expanded(child: Text('Order Id', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Customer', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('status', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          ...orders.map((order) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              children: [
                Expanded(child: Text(order['id']!)),
                Expanded(child: Text(order['customer']!)),
                Expanded(child: Text(order['total']!)),
                Expanded(child: Text(order['status']!)),
                Expanded(child: Text(order['date']!)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildReviewsTable() {
    final reviews = [
      {'id': '#12345', 'user': 'Rahul', 'item': 'Pizza', 'rating': '4.5', 'review': 'Delicious and fresh!'},
      {'id': '#12346', 'user': 'Priya', 'item': 'Pasta', 'rating': '5.0', 'review': 'Amazing taste, loved it'},
      {'id': '#12347', 'user': 'Arsh', 'item': 'Full Thali', 'rating': '4.0', 'review': 'Good variety, value for money'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: const Row(
              children: [
                Expanded(child: Text('Review Id', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('User', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Food Item', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Rating', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Review', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          ...reviews.map((review) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              children: [
                Expanded(child: Text(review['id']!)),
                Expanded(child: Text(review['user']!)),
                Expanded(child: Text(review['item']!)),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(review['rating']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    review['review']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
