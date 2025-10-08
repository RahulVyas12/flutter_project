import 'package:flutter/material.dart';
import 'PaymentPage.dart';

class DeliveryPage extends StatefulWidget {
  final double totalAmount;
  const DeliveryPage({super.key, required this.totalAmount});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  String deliveryMethod = "Door delivery";
  bool isEditing = false;

  final TextEditingController nameController = TextEditingController(
    text: "Arsh Pathan",
  );
  final TextEditingController addressController = TextEditingController(
    text: "RKU Boys hostel\nRajkot - Bhavnagar highway, Rajkot",
  );
  final TextEditingController phoneController = TextEditingController(
    text: "+91 9011039271",
  );

  String? _validatePhone(String value) {
    final phone = value.replaceAll("+91", "").replaceAll(" ", "");
    final phoneRegex = RegExp(r'^[6-9]\d{9}$');
    if (phone.isEmpty) {
      return "Please enter your phone number";
    }
    if (!phoneRegex.hasMatch(phone)) {
      return "Enter a valid 10-digit phone number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final primary = Colors.deepOrange;

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
          "Delivery Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.check_circle : Icons.edit,
              color: primary,
            ),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address Section
                  Row(
                    children: [
                      Icon(Icons.location_on, color: primary, size: 24),
                      const SizedBox(width: 8),
                      const Text(
                        "Delivery Address",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAddressField(
                          icon: Icons.person,
                          label: "Name",
                          controller: nameController,
                          isEditing: isEditing,
                        ),
                        const Divider(height: 24),
                        _buildAddressField(
                          icon: Icons.home,
                          label: "Address",
                          controller: addressController,
                          isEditing: isEditing,
                          maxLines: 3,
                        ),
                        const Divider(height: 24),
                        _buildAddressField(
                          icon: Icons.phone,
                          label: "Phone",
                          controller: phoneController,
                          isEditing: isEditing,
                          keyboardType: TextInputType.phone,
                          errorText: isEditing
                              ? _validatePhone(phoneController.text)
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Delivery Method Section
                  Row(
                    children: [
                      Icon(Icons.local_shipping, color: primary, size: 24),
                      const SizedBox(width: 8),
                      const Text(
                        "Delivery Method",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildDeliveryOption(
                          icon: Icons.delivery_dining,
                          title: "Door Delivery",
                          subtitle: "Delivered to your doorstep",
                          value: "Door delivery",
                          primary: primary,
                        ),
                        const Divider(height: 1),
                        _buildDeliveryOption(
                          icon: Icons.store,
                          title: "Pick Up",
                          subtitle: "Collect from restaurant",
                          value: "Pick up",
                          primary: primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, -4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '₹${widget.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        final phoneError = _validatePhone(phoneController.text);
                        if (nameController.text.isEmpty ||
                            addressController.text.isEmpty ||
                            phoneController.text.isEmpty ||
                            phoneError != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                phoneError ?? "Please fill in all address details",
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPage(
                              total: widget.totalAmount,
                              deliveryMethod: deliveryMethod,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Proceed to Payment",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? errorText,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey.shade600, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: isEditing
              ? TextField(
                  controller: controller,
                  maxLines: maxLines,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    labelText: label,
                    errorText: errorText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.text,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildDeliveryOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required Color primary,
  }) {
    final isSelected = deliveryMethod == value;
    return InkWell(
      onTap: () => setState(() => deliveryMethod = value),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? primary.withOpacity(0.1)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? primary : Colors.grey.shade600,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? primary : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: deliveryMethod,
              onChanged: (val) => setState(() => deliveryMethod = val!),
              activeColor: primary,
            ),
          ],
        ),
      ),
    );
  }
}
