import 'package:flutter/material.dart';
import 'package:restrospt/food_item.dart'; // <-- Add this import

class FoodMenu extends StatefulWidget {
  const FoodMenu({super.key});

  @override
  State<FoodMenu> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Food Menu",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Food Items title
            const Text(
              "Food Items",
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            /// Search Bar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.deepOrange),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search Food Dishes here",
                  prefixIcon: Icon(Icons.search, color: Colors.deepOrange),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Starter Section
            buildCategoryTitle("Starter"),
            buildFoodGrid([
              {
                "name": "Samosa",
                "price": "₹50",
                "image": "assets/paneer-butter-masala.jpg",
              },
              {
                "name": "Paneer Tikka",
                "price": "₹199",
                "image": "assets/paneer-butter-masala.jpg",
              },
            ]),
            const SizedBox(height: 20),

            /// Main Course Section
            buildCategoryTitle("Main Course"),
            buildFoodGrid([
              {
                "name": "Dal Makhni",
                "price": "₹149",
                "image": "assets/paneer-butter-masala.jpg",
              },
              {
                "name": "Paneer Butter Masala",
                "price": "₹229",
                "image": "assets/paneer-butter-masala.jpg",
              },
            ]),
            const SizedBox(height: 20),

            /// Chinese Section
            buildCategoryTitle("Chinese"),
            buildFoodGrid([
              {
                "name": "Hakka Noodles",
                "price": "₹129",
                "image": "assets/paneer-butter-masala.jpg",
              },
              {
                "name": "Manchurian",
                "price": "₹149",
                "image": "assets/paneer-butter-masala.jpg",
              },
            ]),
          ],
        ),
      ),
    );
  }

  /// Category title widget
  Widget buildCategoryTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  /// Food grid widget
  Widget buildFoodGrid(List<Map<String, String>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FoodDetailPage()),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    item["image"]!,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item["name"]!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item["price"]!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
