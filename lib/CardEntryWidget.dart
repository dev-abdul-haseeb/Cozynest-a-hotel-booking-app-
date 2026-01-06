import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'detailsScreen.dart';

class CardEntryWidget extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final double amount;
  final VoidCallback onSuccess;

  const CardEntryWidget({
    required this.screenWidth,
    required this.screenHeight,
    required this.amount,
    required this.onSuccess,
  });

  @override
  State<CardEntryWidget> createState() => _CardEntryWidgetState();
}
class _CardEntryWidgetState extends State<CardEntryWidget> {
  final nameController = TextEditingController();
  final cardController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final zipController = TextEditingController();

  bool isPaid = false;
  bool showSuccess = false;  // <-- ADD THIS


  void handlePayment() {
    if (nameController.text.isEmpty ||
        cardController.text.isEmpty ||
        expiryController.text.isEmpty ||
        cvvController.text.isEmpty ||
        zipController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() {
      isPaid = true;
      showSuccess = true;
    });

    Future.delayed(Duration(milliseconds: 1700), () {
      widget.onSuccess();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Paid successfully!')),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final sw = widget.screenWidth;
    final sh = widget.screenHeight;
    final amount = widget.amount;

    if (showSuccess) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: sw * 0.6,
              height: sh * 0.3,
              child: Lottie.asset('Assets/Animations/success.json'),
            ),
            SizedBox(height: sh * 0.02),
            Text(
              'Payment Successful!',
              style: TextStyle(
                color: Colors.green.shade700,
                fontSize: sh * 0.03,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
              ),
            ),
          ],
        ),
      );
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: sw,
              height: sh * 0.07,
              color: Colors.green.shade100,
              child: Center(
                child: Text(
                  'Bill Invoice',
                  style: TextStyle(
                    fontSize: sh * 0.04,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoCondensed',
                  ),
                ),
              ),
            ),
            SizedBox(height: sh * 0.04),

            /// Card Images Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: cardImages.map((imgPath) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: sw * 0.015),
                  child: Container(
                    width: sw * 0.15,
                    height: sh * 0.04,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade700,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(imgPath, fit: BoxFit.contain),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: sh * 0.05),

            /// Input Fields
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment amount',
                      style: TextStyle(
                          fontSize: sh * 0.02,
                          color: Colors.blue.shade500,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: sh * 0.01),
                  Text('PKR $amount', style: TextStyle(fontSize: sh * 0.025)),
                  SizedBox(height: sh * 0.02),

                  labelAndInput('Name on card', nameController, 'e.g. Abdul Haseeb'),
                  SizedBox(height: sh * 0.02),
                  labelAndInput('Card number', cardController, 'e.g. 1234 5678 9012 3456', TextInputType.number),
                  SizedBox(height: sh * 0.02),

                  /// Expiry & CVV
                  Row(
                    children: [
                      Expanded(
                          child: labelAndInput('Expiry date', expiryController, 'MM/YY', TextInputType.datetime)),
                      SizedBox(width: sw * 0.05),
                      Expanded(
                          child: labelAndInput('Security code', cvvController, 'CVV', TextInputType.number, true)),
                    ],
                  ),
                  SizedBox(height: sh * 0.02),

                  labelAndInput('ZIP/Postal code', zipController, 'e.g. 60000', TextInputType.number),
                ],
              ),
            ),

            SizedBox(height: sh * 0.04),

            /// Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade900),
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel',
                        style: TextStyle(fontSize: sh * 0.025, color: Colors.white)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700),
                    onPressed: isPaid ? null : handlePayment,
                    child: Text(
                      isPaid ? 'Paid' : 'Pay Now',
                      style: TextStyle(fontSize: sh * 0.025, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: sh * 0.05),
          ],
        ),
      ),
    );
  }

  Widget labelAndInput(String label, TextEditingController controller, String hint,
      [TextInputType type = TextInputType.text, bool obscure = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: widget.screenHeight * 0.02,
                color: Colors.blue.shade500,
                fontWeight: FontWeight.bold)),
        TextField(
          controller: controller,
          keyboardType: type,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
      ],
    );
  }
}
