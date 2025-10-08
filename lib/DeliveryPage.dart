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

  // Controllers for address fields
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.check : Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Address details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isEditing
                      ? TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(),
                          ),
                        )
                      : Text(
                          nameController.text,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                  const SizedBox(height: 8),
                  isEditing
                      ? TextField(
                          controller: addressController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: "Address",
                            border: OutlineInputBorder(),
                          ),
                        )
                      : Text(addressController.text),
                  const SizedBox(height: 8),
                  isEditing
                      ? TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Phone number",
                            border: const OutlineInputBorder(),
                            errorText: _validatePhone(phoneController.text),
                          ),
                          onChanged: (_) {
                            setState(() {});
                          },
                        )
                      : Text(phoneController.text),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Delivery method",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  RadioListTile<String>(
                    value: "Door delivery",
                    groupValue: deliveryMethod,
                    title: const Text("Door delivery"),
                    onChanged: (value) =>
                        setState(() => deliveryMethod = value!),
                  ),
                  RadioListTile<String>(
                    value: "Pick up",
                    groupValue: deliveryMethod,
                    title: const Text("Pick up"),
                    onChanged: (value) =>
                        setState(() => deliveryMethod = value!),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  '₹ ${widget.totalAmount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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
                    ),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PaymentPage(total: widget.totalAmount),
                  ),
                );
              },
              child: const Text(
                "Proceed to payment",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
