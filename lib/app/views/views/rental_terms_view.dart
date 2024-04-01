import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentalTermsView extends GetView {
  const RentalTermsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rental Terms and Conditions'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        height: Get.height,
        color: Colors.white,
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1. Rental Period",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "The rental period is specified in the rental agreement. Late returns exceeding 1 day may incur additional charges.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "2. Product Condition",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "The product must be returned in the same condition as it was at the beginning of the rental period, normal wear and tear accepted.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "3. Renter's Responsibility",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "The renter is responsible for any loss, theft, damage, or destruction of the rented product.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "4. Liability",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "The product owner is not responsible for any injury, loss, or damage caused by the use of the rented product.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "5. Dispute Resolution",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Disputes arising out of the rental agreement will be resolved through negotiation, mediation, or arbitration.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 32),
              // Text(
              //   "By proceeding, you agree to these Terms and Conditions.",
              //   style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
