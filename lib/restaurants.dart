import 'package:flutter/material.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primary = Colors.deepOrange;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Restaurants",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Restaurants",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            const SizedBox(height: 12),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search Restaurants city here",
                prefixIcon: const Icon(Icons.search, color: Colors.deepOrange),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.deepOrange.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: primary),
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildCitySection("Amreli"),
            const SizedBox(height: 20),

            _buildCitySection("Rajkot"),
            const SizedBox(height: 20),

            _buildCitySection("Baroda"),
          ],
        ),
      ),
    );
  }

  // Reusable section
  Widget _buildCitySection(String city) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          city,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return _buildRestaurantCard();
            },
          ),
        ),
      ],
    );
  }

  // Reusable restaurant card
  Widget _buildRestaurantCard() {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                ),
              ),
            ],
          ),

          // Info
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Golden Spot Restorant",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "Review : ",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    Text(
                      "4.4 ",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "Open : 8 am to 10 pm",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
