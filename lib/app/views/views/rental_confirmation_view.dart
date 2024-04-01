import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:get/get.dart';
import 'package:gearhaven/app/models/rental_product.dart';
import 'package:gearhaven/app/modules/rental_product_description/controllers/rental_product_description_controller.dart';
import 'package:gearhaven/app/views/views/rental_terms_view.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart'; // For date formatting

class RentalConfirmationView
    extends GetView<RentalProductDescriptionController> {
  const RentalConfirmationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RentalProduct product = Get.arguments as RentalProduct;
    final controller = Get.find<RentalProductDescriptionController>();

    RxBool isTermsAccepted = false.obs;

    Widget infoTile(String title, String subtitle) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rental Confirmation'),
        centerTitle: true,
      ),
      body: Container(
        height: Get.height,
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'product+${product.productId}',
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              getProductImageUrl(product.productImage ?? ''),
                              width: 150,
                              height: Get.height * 0.1,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      infoTile('Product Name', product.productName ?? ''),
                      infoTile('Rate per Day', 'Rs ${product.ratePerDay}'),
                      infoTile(
                        'Rental Period',
                        '${DateFormat('dd/MM/yyyy').format(controller.fromDate.value)} - ${DateFormat('dd/MM/yyyy').format(controller.toDate.value)}',
                      ),
                      infoTile('Total Amount',
                          'Rs ${controller.calculateTotalAmount(product.ratePerDay ?? 0)}'),
                      infoTile('Owner', product.userName ?? ''),
                      infoTile('Location', product.userLocation ?? ''),
                      infoTile('Contact', product.userContact ?? ''),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              Obx(
                () => CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: CustomColors.accentColor,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "I agree to the rental terms and conditions.",
                        style: TextStyle(fontSize: 17),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const RentalTermsView());
                        },
                        child: Text(
                          "View terms and conditions",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  value: isTermsAccepted.value,
                  onChanged: (bool? newValue) =>
                      isTermsAccepted.value = newValue ?? false,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(height: 5),
              Obx(
                () => InkWell(
                  onHover: (value) {},
                  onTap: isTermsAccepted.value
                      ? () async {
                          var total = controller
                                  .calculateTotalAmount(product.ratePerDay ?? 0)
                                  .toInt() *
                              100;
                          KhaltiScope.of(Get.context!).pay(
                            preferences: [
                              PaymentPreference.khalti,
                              PaymentPreference.connectIPS,
                            ],
                            config: PaymentConfig(
                              // amount: 1000,
                              // amount: (grandTotal ~/ 100).toInt(),
                              amount: total,
                              productIdentity: product.productId.toString(),
                              productName: product.productName ?? 'My Product',
                            ),
                            onSuccess: (PaymentSuccessModel v) {
                              debugPrint("On success total: $total");
                              controller.makePayment(
                                productId: product.productId,
                                ownerId: product.productownerId,
                                fromDate: controller.fromDate.value.toString(),
                                toDate: controller.toDate.value.toString(),
                                amountPaid: double.tryParse(total.toString()),
                                otherData: jsonEncode({
                                  "idx": v.idx,
                                  "amount": v.amount,
                                  "token": v.token,
                                  "mobile": v.mobile,
                                  "productIdentity": v.productIdentity,
                                  "productName": v.productName,
                                }),
                                productName: product.productName,
                                ownerFCM: product.ownerFcm,
                                product: product,
                              );
                            },
                            onFailure: (v) {
                              Get.showSnackbar(
                                const GetSnackBar(
                                  backgroundColor: Colors.red,
                                  message: 'Payment failed!',
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            },
                            onCancel: () {
                              // controller.cancelOrder();
                            },
                          );
                        }
                      : null,
                  child: Center(
                    child: Container(
                      height: Get.height * 0.07,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://web.khalti.com/static/img/logo1.png',
                            color: isTermsAccepted.value ? null : Colors.grey,
                            height: 40,
                          ),
                          Text(
                            'Pay with Khalti',
                            style: TextStyle(
                              color: isTermsAccepted.value
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
