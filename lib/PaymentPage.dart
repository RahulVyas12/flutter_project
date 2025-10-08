import 'package:flutter/material.dart';
import 'package:restrospt/food_item.dart';

class PaymentPage extends StatefulWidget {
  final double total;
  final String deliveryMethod;
  const PaymentPage({
    super.key,
    required this.total,
    this.deliveryMethod = "Door delivery",
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String paymentMethod = "Card";

  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _handlePayment() {
    if (paymentMethod == "Card") {
      if (!_formKey.currentState!.validate()) {
        return;
      }
    }
    _showOrderSuccessDialog();
  }

  void _showOrderSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.green.shade400,
                size: 64,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Order Placed Successfully!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Thank you for your order!\nYour food will be ${widget.deliveryMethod == 'Pick up' ? 'ready for pickup' : 'delivered'} soon.",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  cartItems.clear();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  "Back to Home",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
          "Payment",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Payment Method Section
                  Row(
                    children: [
                      Icon(Icons.payment, color: primary, size: 24),
                      const SizedBox(width: 8),
                      const Text(
                        "Payment Method",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Card Payment
                  _buildPaymentOption(
                    icon: Icons.credit_card,
                    title: "Debit / Credit Card",
                    value: "Card",
                    primary: primary,
                  ),
                  if (paymentMethod == "Card") ...[
                    const SizedBox(height: 16),
                    _buildCardForm(primary),
                  ],
                  const SizedBox(height: 12),

                  // UPI Payment
                  _buildPaymentOption(
                    icon: Icons.account_balance_wallet,
                    title: "UPI Payment",
                    value: "UPI",
                    primary: primary,
                  ),
                  const SizedBox(height: 12),

                  // Cash on Delivery
                  _buildPaymentOption(
                    icon: Icons.money,
                    title: "Cash on Delivery",
                    value: "Cash on Delivery",
                    primary: primary,
                  ),

                  const SizedBox(height: 24),

                  // Order Summary
                  Row(
                    children: [
                      Icon(Icons.receipt_long, color: primary, size: 24),
                      const SizedBox(width: 8),
                      const Text(
                        "Order Summary",
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
                      children: [
                        _buildSummaryRow("Subtotal", widget.total),
                        const SizedBox(height: 8),
                        _buildSummaryRow("Delivery Fee", 0),
                        const SizedBox(height: 8),
                        _buildSummaryRow("Tax (5%)", widget.total * 0.05),
                        const Divider(height: 24),
                        _buildSummaryRow(
                          "Total",
                          widget.total + (widget.total * 0.05),
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Payment Button
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
              child: SizedBox(
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
                  onPressed: _handlePayment,
                  child: Text(
                    "Pay ₹${(widget.total + (widget.total * 0.05)).toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String value,
    required Color primary,
  }) {
    final isSelected = paymentMethod == value;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? primary : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: primary.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: InkWell(
        onTap: () => setState(() => paymentMethod = value),
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
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? primary : Colors.black87,
                  ),
                ),
              ),
              Radio<String>(
                value: value,
                groupValue: paymentMethod,
                onChanged: (val) => setState(() => paymentMethod = val!),
                activeColor: primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardForm(Color primary) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            TextFormField(
              controller: cardNameController,
              decoration: InputDecoration(
                labelText: "Cardholder Name",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primary, width: 2),
                ),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? "Enter cardholder name"
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              maxLength: 16,
              decoration: InputDecoration(
                labelText: "Card Number",
                prefixIcon: const Icon(Icons.credit_card),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primary, width: 2),
                ),
                counterText: "",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Enter card number";
                if (value.length < 16) return "Invalid card number";
                return null;
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: expiryController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: "MM/YY",
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primary, width: 2),
                      ),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter expiry" : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: cvvController,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    decoration: InputDecoration(
                      labelText: "CVV",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primary, width: 2),
                      ),
                      counterText: "",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Enter CVV";
                      if (value.length < 3) return "Invalid";
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 15,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? Colors.black : Colors.black87,
          ),
        ),
        Text(
          "₹${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: isTotal ? 18 : 15,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
            color: isTotal ? Colors.deepOrange : Colors.black87,
          ),
        ),
      ],
    );
  }
}
