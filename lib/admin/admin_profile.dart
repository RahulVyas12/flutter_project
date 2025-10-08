import 'package:flutter/material.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final TextEditingController nameController = TextEditingController(text: 'Rahul Vyas');
  final TextEditingController restaurantController = TextEditingController(text: 'Golden spot');
  final TextEditingController cityController = TextEditingController(text: 'Rajkot');
  final TextEditingController addressController = TextEditingController(text: 'Xyz Road , Oppo ABC building, Rajkot');
  final TextEditingController mobileController = TextEditingController(text: '+91 9810299389');
  final TextEditingController emailController = TextEditingController(text: 'rvyas66@rku.ac.in');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF5733),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ADMIN',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Admin Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            
            // Profile Picture
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFFFF5733),
              child: Icon(Icons.person, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 40),
            
            // Profile Information
            _buildInfoRow('Name :', nameController.text),
            const SizedBox(height: 15),
            _buildInfoRow('Restorunt :', restaurantController.text),
            const SizedBox(height: 15),
            _buildInfoRow('City :', cityController.text),
            const SizedBox(height: 15),
            _buildInfoRow('Address :', addressController.text),
            const SizedBox(height: 15),
            _buildInfoRow('Mobile No. :', mobileController.text),
            const SizedBox(height: 15),
            _buildInfoRow('Email :', emailController.text),
            const SizedBox(height: 40),
            
            // Update Profile Button
            OutlinedButton(
              onPressed: _showUpdateDialog,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFFF5733), width: 2),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Update Profile',
                style: TextStyle(
                  color: Color(0xFFFF5733),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Update Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: restaurantController,
                decoration: const InputDecoration(
                  labelText: 'Restaurant',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: mobileController,
                decoration: const InputDecoration(
                  labelText: 'Mobile No.',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5733),
            ),
            child: const Text('Update', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
