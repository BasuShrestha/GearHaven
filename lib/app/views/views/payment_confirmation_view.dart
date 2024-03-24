import 'package:flutter/material.dart';
import 'package:gearhaven/app/components/customs/custom_button.dart';
import 'package:gearhaven/app/models/cart_item.dart';
import 'package:gearhaven/app/routes/app_pages.dart';
import 'package:gearhaven/app/utils/colors.dart';

import 'package:get/get.dart';

class PaymentConfirmationView extends GetView {
  const PaymentConfirmationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var paymentId = Get.arguments['paymentId'] ?? 0;
    var orderedItems = Get.arguments['orderedItems'] as List<CartItem>;
    debugPrint(paymentId);
    debugPrint(orderedItems[0].product.productName);
    double getGrandTotal() {
      double grandTotal = 0.00;
      for (CartItem item in orderedItems) {
        grandTotal += (item.product.productPrice! * item.quantity);
      }
      return grandTotal;
    }

    double grandTotal = getGrandTotal();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Confirmation'),
        centerTitle: true,
        backgroundColor: CustomColors.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            Get.offNamed(Routes.MAIN);
          },
          child: Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        color: CustomColors.backgroundColor,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Get.width * 0.5,
              height: Get.width * 0.5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.green.shade100,
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.green.shade200,
                    ),
                  ),
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.green.shade300,
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.green.shade400,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "Payment Successful",
              style: TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Your payment id: $paymentId",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 350,
              height: Get.height * 0.3,
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Payment Summary",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderedItems.length,
                      itemBuilder: (context, index) {
                        var orderedItem = orderedItems[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              orderedItem.product.productName ?? '',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "${(orderedItem.product.productPrice ?? 0) * orderedItem.quantity}",
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: Get.width,
                    child: Divider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Grand Total",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        grandTotal.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              label: "Continue",
              onPressed: () {
                Get.offNamed(Routes.MAIN);
              },
            ),
          ],
        ),
      ),
    );
  }
}
