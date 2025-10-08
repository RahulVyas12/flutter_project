import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminFoodItems extends StatefulWidget {
  const AdminFoodItems({super.key});

  @override
  State<AdminFoodItems> createState() => _AdminFoodItemsState();
}

class _AdminFoodItemsState extends State<AdminFoodItems> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _foodImage;

  final List<Map<String, dynamic>> foodList = [
    {
      "name": "Samosa Dish",
      "price": "₹150",
      "desc": "samosa a crispy, flaky pastry filled with a spiced mixture potatoes.",
      "category": "Starter",
      "image": null,
    },
    {
      "name": "Samosa Dish",
      "price": "₹150",
      "desc": "samosa a crispy, flaky pastry filled with a spiced mixture potatoes.",
      "category": "Starter",
      "image": null,
    },
    {
      "name": "Samosa Dish",
      "price": "₹150",
      "desc": "samosa a crispy, flaky pastry filled with a spiced mixture potatoes.",
      "category": "Starter",
      "image": null,
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
            'Add Food Items',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          
          // Add Food Form
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFFFF5733), width: 2),
            ),
            child: Column(
              children: [
                // Image Upload
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _foodImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(_foodImage!, fit: BoxFit.cover),
                          )
                        : const Icon(Icons.add, size: 40, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Upload Image here', style: TextStyle(fontSize: 12)),
                const SizedBox(height: 20),
                
                // Food Name
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Food Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFFF5733)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFFF5733), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                
                // Price
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFFF5733)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFFF5733), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                
                // Description
                TextField(
                  controller: descController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter Food Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFFF5733)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFFF5733), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                
                // Category
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    hintText: 'Enter Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFFF5733)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFFF5733), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Done Button
                ElevatedButton(
                  onPressed: _addFoodItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5733),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Food List
          const Text(
            'Food List Items',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          
          ...foodList.map((food) => _buildFoodCard(food)),
        ],
      ),
    );
  }

  Widget _buildFoodCard(Map<String, dynamic> food) {
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
          // Food Image
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: food['image'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(food['image'], fit: BoxFit.cover),
                  )
                : const Icon(Icons.restaurant, size: 40, color: Colors.grey),
          ),
          const SizedBox(width: 15),
          
          // Food Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food['name'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  food['price'],
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  'Category: ${food['category']}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  food['desc'],
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Column(
            children: [
              _buildActionButton('View', Colors.blue, food),
              const SizedBox(height: 5),
              _buildActionButton('Edit', Colors.orange, food),
              const SizedBox(height: 5),
              _buildActionButton('Delete', Colors.red, food),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, Map<String, dynamic> food) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'View') {
          _viewFoodItem(food);
        } else if (text == 'Edit') {
          _editFoodItem(food);
        } else if (text == 'Delete') {
          _deleteFoodItem(food);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        minimumSize: const Size(60, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 11),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    if (pickedFile != null) {
      setState(() {
        _foodImage = File(pickedFile.path);
      });
    }
  }

  void _addFoodItem() {
    if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
      setState(() {
        foodList.insert(0, {
          "name": nameController.text,
          "price": "₹${priceController.text}",
          "desc": descController.text,
          "category": categoryController.text,
          "image": _foodImage,
        });
      });
      
      // Clear form
      nameController.clear();
      priceController.clear();
      descController.clear();
      categoryController.clear();
      _foodImage = null;
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Food item added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // View Food Item Details
  void _viewFoodItem(Map<String, dynamic> food) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Row(
          children: [
            const Icon(Icons.restaurant, color: Color(0xFFFF5733)),
            const SizedBox(width: 10),
            const Text(
              'Food Item Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Food Image
              if (food['image'] != null)
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFFF5733)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(food['image'], fit: BoxFit.cover),
                    ),
                  ),
                ),
              if (food['image'] != null) const SizedBox(height: 15),
              
              _buildDetailRow('Name:', food['name']),
              const Divider(),
              _buildDetailRow('Price:', food['price']),
              const Divider(),
              _buildDetailRow('Category:', food['category']),
              const Divider(),
              _buildDetailRow('Description:', food['desc']),
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

  // Edit Food Item
  void _editFoodItem(Map<String, dynamic> food) {
    final nameController = TextEditingController(text: food['name']);
    final priceController = TextEditingController(text: food['price'].replaceAll('₹', ''));
    final descController = TextEditingController(text: food['desc']);
    final categoryController = TextEditingController(text: food['category']);
    File? editImage = food['image'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Row(
            children: [
              const Icon(Icons.edit, color: Color(0xFFFF5733)),
              const SizedBox(width: 10),
              const Text(
                'Edit Food Item',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image Upload
                GestureDetector(
                  onTap: () async {
                    final XFile? pickedFile = await _picker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 512,
                      maxHeight: 512,
                      imageQuality: 75,
                    );
                    if (pickedFile != null) {
                      setDialogState(() {
                        editImage = File(pickedFile.path);
                      });
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: editImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(editImage!, fit: BoxFit.cover),
                          )
                        : const Icon(Icons.add_photo_alternate, size: 40, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Tap to change image', style: TextStyle(fontSize: 12)),
                const SizedBox(height: 15),
                
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Food Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.restaurant_menu),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.currency_rupee),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: descController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
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
                setState(() {
                  food['name'] = nameController.text;
                  food['price'] = '₹${priceController.text}';
                  food['desc'] = descController.text;
                  food['category'] = categoryController.text;
                  food['image'] = editImage;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Food item updated successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5733),
              ),
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // Delete Food Item
  void _deleteFoodItem(Map<String, dynamic> food) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          'Delete Food Item',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text('Are you sure you want to delete "${food['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                foodList.remove(food);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${food['name']} deleted successfully!'),
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

  // Helper method to build detail rows
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
