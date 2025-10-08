import 'package:flutter/material.dart';
import 'package:restrospt/CartPage.dart';
import 'package:restrospt/DeliveryPage.dart';
import 'package:restrospt/WishlistPage.dart';
import 'package:restrospt/food_item.dart'; // Add this import at the top
import 'package:restrospt/foodmenu.dart';
import 'package:restrospt/my_bookings.dart';
import 'package:restrospt/profile_page.dart';
import 'package:restrospt/restaurants.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Color primary = Color(0xFFEB5E44);

  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  // Filter variables
  String selectedCategory = 'All';
  String selectedPriceRange = 'All';
  double minRating = 0.0;

  final List<String> categories = ['All', 'Starters', 'Vegetarian', 'Chinese'];
  final List<String> priceRanges = [
    'All',
    'Under ₹100',
    '₹100-₹200',
    '₹200-₹300',
    'Above ₹300',
  ];

  final List<Map<String, String>> foodItems = [
    // Starters
    {
      'image': 'assets/paneer-butter-masala.jpg',
      'name': 'Samosa',
      'description':
          'A popular Indian snack made of a crispy pastry filled with spiced potatoes and peas.',
      'price': '₹50',
      'category': 'Starters',
      'rating': '4.0',
    },
    {
      'image': 'assets/paneer-butter-masala.jpg',
      'name': 'Paneer Tikka',
      'description':
          'Chunks of paneer marinated in spices and grilled to perfection.',
      'price': '₹199',
      'category': 'Starters',
      'rating': '4.5',
    },
    // Main Course
    {
      'image': 'assets/paneer-butter-masala.jpg',
      'name': 'Dal Makhni',
      'description':
          'A rich and creamy lentil dish made with black lentils and kidney beans, cooked with butter and cream.',
      'price': '₹149',
      'category': 'Vegetarian',
      'rating': '4.3',
    },
    {
      'image': 'assets/paneer-butter-masala.jpg',
      'name': 'Paneer Butter Masala',
      'description':
          'A popular North Indian dish made with paneer cubes cooked in a rich and creamy tomato-based gravy.',
      'price': '₹229',
      'category': 'Vegetarian',
      'rating': '4.7',
    },
    // Chinese
    {
      'image': 'assets/paneer-butter-masala.jpg',
      'name': 'Hakka Noodles',
      'description':
          'A popular Indo-Chinese dish made with stir-fried noodles and vegetables.',
      'price': '₹129',
      'category': 'Chinese',
      'rating': '4.2',
    },
    {
      'image': 'assets/paneer-butter-masala.jpg',
      'name': 'Manchurian',
      'description':
          'A popular Indo-Chinese dish made with fried vegetable or chicken balls in a spicy sauce.',
      'price': '₹149',
      'category': 'Chinese',
      'rating': '4.4',
    },
  ];

  double getTotalPrice() {
    double total = 0.0;
    for (var item in cartItems) {
      final price = double.tryParse(item['price'].toString()) ?? 0.0;
      final quantity = int.tryParse(item['quantity'].toString()) ?? 1;
      total += price * quantity;
    }
    return total;
  }

  List<Map<String, String>> get filteredItems {
    var items = List<Map<String, String>>.from(foodItems);

    // Filter by category
    if (selectedCategory != 'All') {
      items = items.where((item) {
        final category = item['category'];
        return category != null && category == selectedCategory;
      }).toList();
    }

    // Filter by price range
    if (selectedPriceRange != 'All') {
      items = items.where((item) {
        final priceStr = item['price'] ?? '0';
        // Remove ₹ symbol and any other non-numeric characters
        final cleanPrice = priceStr.replaceAll(RegExp(r'[^0-9.]'), '');
        final price = double.tryParse(cleanPrice) ?? 0;
        switch (selectedPriceRange) {
          case 'Under ₹100':
            return price < 100;
          case '₹100-₹200':
            return price >= 100 && price <= 200;
          case '₹200-₹300':
            return price >= 200 && price <= 300;
          case 'Above ₹300':
            return price > 300;
          default:
            return true;
        }
      }).toList();
    }

    // Filter by rating
    if (minRating > 0) {
      items = items.where((item) {
        final ratingStr = item['rating'];
        if (ratingStr == null) return true; // Show items without ratings
        final rating = double.tryParse(ratingStr) ?? 0;
        return rating >= minRating;
      }).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      items = items
          .where(
            (item) =>
                item['name']!.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ) ||
                item['description']!.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return items;
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.filter_list, color: primary, size: 24),
              const SizedBox(width: 8),
              const Text(
                'Filter Options',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Filter
                const Text(
                  'Category',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: categories.map<Widget>((category) {
                    final isSelected = selectedCategory == category;
                    return FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setDialogState(() {
                          selectedCategory = category;
                        });
                      },
                      selectedColor: primary.withOpacity(0.2),
                      checkmarkColor: primary,
                      labelStyle: TextStyle(
                        color: isSelected ? primary : Colors.black87,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // Price Range Filter
                const Text(
                  'Price Range',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                ...priceRanges.map<Widget>((range) {
                  final isSelected = selectedPriceRange == range;
                  return RadioListTile<String>(
                    title: Text(
                      range,
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                    value: range,
                    groupValue: selectedPriceRange,
                    activeColor: primary,
                    onChanged: (value) {
                      setDialogState(() {
                        selectedPriceRange = value!;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  );
                }).toList(),
                const SizedBox(height: 20),

                // Rating Filter
                const Text(
                  'Minimum Rating',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(5, (index) {
                    final rating = (index + 1).toDouble();
                    final isSelected = minRating >= rating;
                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          setDialogState(() {
                            minRating = minRating == rating ? 0 : rating;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              isSelected ? Icons.star : Icons.star_border,
                              color: isSelected ? Colors.amber : Colors.grey,
                              size: 32,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${rating.toInt()}+',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isSelected ? primary : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  selectedCategory = 'All';
                  selectedPriceRange = 'All';
                  minRating = 0.0;
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Clear All',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                setState(() {
                  // Apply filters
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Apply Filters',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get hasActiveFilters {
    return selectedCategory != 'All' ||
        selectedPriceRange != 'All' ||
        minRating > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    _buildSearchRow(context),
                    SizedBox(height: 18),
                    _buildOptions(context),
                    SizedBox(height: 20),
                    Text(
                      'Popular Items',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                    SizedBox(height: 12),
                    Column(
                      children: List.generate(
                        filteredItems.length,
                        (i) => _foodCard(context, filteredItems[i]),
                      ),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, primary),
    );
  }

  // Header
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: primary,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
            child: CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: primary, size: 32),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Arsh Pathan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.white70,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Amreli',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }

  // Search bar and filter button
  Widget _buildSearchRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Color(0xFFEDDCD7)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search here',
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12),
        Container(
          height: 48,
          width: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              IconButton(
                icon: Icon(Icons.filter_list, color: primary),
                onPressed: _showFilterDialog,
              ),
              if (hasActiveFilters)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // Option cards row
  Widget _buildOptions(BuildContext context) {
    return Row(
      children: [
        _optionCard(context, Icons.menu_book, 'Food Menu', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FoodMenu()),
          );
        }),
        SizedBox(width: 12),
        Container(height: 100, width: 1, color: Colors.black12),
        SizedBox(width: 12),
        _optionCard(context, Icons.restaurant, 'Restaurants', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RestaurantsScreen()),
          );
        }),
      ],
    );
  }

  // Clickable Option Card
  Widget _optionCard(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Column(
          children: [
            Container(
              height: 88,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 13, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  // Food Cards
  Widget _foodCard(BuildContext context, Map<String, String> item) {
    // Check if item is in wishlist or cart
    final isInWishlist = FoodDetailPage.wishlistItems.any(
      (wish) => wish['name'] == item['name'],
    );
    final isInCart = cartItems.any((cart) => cart['name'] == item['name']);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item['image']!,
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isInWishlist
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isInWishlist
                                  ? Colors.deepOrange
                                  : Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isInWishlist) {
                                  FoodDetailPage.wishlistItems.removeWhere(
                                    (wish) => wish['name'] == item['name'],
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${item['name']} removed from favorites!',
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                } else {
                                  FoodDetailPage.wishlistItems.add({
                                    'image': item['image'],
                                    'name': item['name'],
                                    'description': item['description'],
                                    'price': item['price'],
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${item['name']} added to favorites!',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Description: ${item['description']}',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Price: ${item['price']}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: isInCart
                                  ? Colors.deepOrange
                                  : Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isInCart) {
                                  cartItems.removeWhere(
                                    (cart) => cart['name'] == item['name'],
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${item['name']} removed from cart!',
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                } else {
                                  cartItems.add({
                                    'image': item['image'],
                                    'name': item['name'],
                                    'description': item['description'],
                                    'price': item['price'],
                                    'quantity': 1,
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${item['name']} added to cart!',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              });
                            },
                          ),
                          Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeliveryPage(
                                    totalAmount:
                                        double.tryParse(
                                          item['price']!.replaceAll(
                                            RegExp(r'[^0-9.]'),
                                            '',
                                          ),
                                        ) ??
                                        0,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Order',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Navigation
  Widget _buildBottomNav(BuildContext context, Color primary) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {},
            child: _navItem(Icons.home, primary, true),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
            child: _navItem(Icons.shopping_cart, primary, false),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistPage()),
              );
            },
            child: _navItem(Icons.favorite, primary, false),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyBookingsScreen()),
              );
            },
            child: _navItem(Icons.restaurant_menu, primary, false),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, Color primary, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: active ? primary : Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Icon(icon, color: active ? Colors.white : primary),
        ),
      ],
    );
  }
}
