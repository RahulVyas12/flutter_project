import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FoodDetailPage(),
    ),
  );
}

class FoodDetailPage extends StatelessWidget {
  const FoodDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Food image
              Center(
                child: ClipOval(
                  child: Image.asset(
                    "assets/samosa.jpg",
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Food name and description
              const Text(
                "Samosa",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Crispy and savory pastry filled with spicy potatoes.\nPrice: ₹25",
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              const Text(
                "₹ 25",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const Spacer(),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Add to cart",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Place Order",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
