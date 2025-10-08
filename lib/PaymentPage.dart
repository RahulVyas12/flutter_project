import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final double total;
  const PaymentPage({super.key, required this.total});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String paymentMethod = "Card";

  // Controllers for card details
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _showDeliveryChargesDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Delivery Info"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Estimated delivery time:"),
            Divider(),
            Text("Door delivery: 30 - 45 minutes"),
            Text("Pick up: Ready in 15 minutes"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              _handlePayment();
            },
            child: const Text("Proceed", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _handlePayment() {
    if (paymentMethod == "Card") {
      if (_formKey.currentState!.validate()) {
        _showOrderSuccessDialog();
      }
    } else {
      _showOrderSuccessDialog();
    }
  }

  void _showOrderSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Order placed successfully 🎉"),
        content: const Text(
          "Thank you for your purchase!\nYour order will be delivered soon.",
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text("OK", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildCardPaymentForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 10),
          TextFormField(
            controller: cardNameController,
            decoration: const InputDecoration(
              labelText: "Cardholder Name",
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? "Enter cardholder name" : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: cardNumberController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Card Number",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return "Enter card number";
              if (value.length < 16) return "Invalid card number";
              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: expiryController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    labelText: "Expiry (MM/YY)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Enter expiry date"
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "CVV",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter CVV";
                    if (value.length < 3) return "Invalid CVV";
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment method",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  RadioListTile<String>(
                    value: "Card",
                    groupValue: paymentMethod,
                    title: const Text("Card"),
                    onChanged: (value) =>
                        setState(() => paymentMethod = value!),
                  ),
                  if (paymentMethod == "Card") _buildCardPaymentForm(),
                  RadioListTile<String>(
                    value: "Cash on Delivery",
                    groupValue: paymentMethod,
                    title: const Text("Cash on Delivery"),
                    onChanged: (value) =>
                        setState(() => paymentMethod = value!),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  "₹ ${widget.total.toStringAsFixed(0)}",
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
              onPressed: _showDeliveryChargesDialog,
              child: const Text(
                "Proceed to payment",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
