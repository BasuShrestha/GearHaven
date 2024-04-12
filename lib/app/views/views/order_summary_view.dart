import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gearhaven/app/models/cart_item.dart';
import 'package:gearhaven/app/modules/cart/controllers/cart_controller.dart';
import 'package:gearhaven/app/utils/assets.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:gearhaven/app/utils/constants.dart';

import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class OrderSummaryView extends GetView {
  const OrderSummaryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    var orderedItems = Get.arguments['orderedItems'] as List<CartItem>;
    var orderId = Get.arguments['orderId'].toString();
    debugPrint(orderedItems.length.toString());
    debugPrint(orderId);

    int getItemCount() {
      int count = 0;
      for (CartItem item in orderedItems) {
        count += item.quantity;
      }
      return count;
    }

    int itemCount = getItemCount();

    int getGrandTotal() {
      int grandTotal = 0;
      for (CartItem item in orderedItems) {
        grandTotal += (item.product.productPrice! * item.quantity);
      }
      return grandTotal;
    }

    int grandTotal = getGrandTotal();

    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: CustomColors.accentColor,
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text('Order Summary'),
                centerTitle: true,
                backgroundColor: CustomColors.backgroundColor,
              ),
              body: Container(
                width: Get.width,
                height: Get.height,
                color: CustomColors.backgroundColor,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 10,
                      child: Text(
                        'Pending',
                        style: TextStyle(
                          color: Colors.amber.shade700,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.grey.shade500,
                              offset: const Offset(0, 0.1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: CustomColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.amber.shade700,
                          strokeAlign: BorderSide.strokeAlignInside,
                          style: BorderStyle.solid,
                          width: 3,
                        ),
                      ),
                      child: SizedBox(
                        height: 700,
                        child: orderedItems.isEmpty
                            ? const Center(
                                child: Text(
                                  'No product ordered...',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: CustomColors.primaryColor,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: orderedItems.length,
                                itemBuilder: (context, index) {
                                  var orderedItem = orderedItems[index];
                                  return Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.amber.shade700,
                                            width: 3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.grey.withOpacity(0.5),
                                          //     spreadRadius: 5,
                                          //     blurRadius: 7,
                                          //     offset: const Offset(0, 3),
                                          //   ),
                                          // ],
                                        ),
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        height: 110,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              width: 150,
                                              child: orderedItem.product
                                                          .productImage ==
                                                      null
                                                  ? Image.asset(
                                                      Assets
                                                          .cartItemImagePlaceholder,
                                                      fit: BoxFit.cover,
                                                      // height: int.infinity,
                                                    )
                                                  : Image.network(
                                                      getProductImageUrl(
                                                        orderedItem.product
                                                            .productImage,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    orderedItem.product
                                                            .productName ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Price: ${orderedItem.product.productPrice}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Quantity in order: ${orderedItem.quantity}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Total: ${orderedItem.product.productPrice! * orderedItem.quantity}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 90,
                      left: 30,
                      child: Container(
                        width: 350,
                        height: 200,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Sumary",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Item Count",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "$itemCount",
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Grand Total",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Rs $grandTotal",
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: Get.width,
                              child: const Divider(),
                            ),
                            TextButton(
                              onPressed: () async {
                                var total = grandTotal.ceil().toInt() * 1000;
                                KhaltiScope.of(Get.context!).pay(
                                  preferences: [
                                    PaymentPreference.khalti,
                                    PaymentPreference.connectIPS,
                                  ],
                                  config: PaymentConfig(
                                    // amount: 1000,
                                    // amount: (grandTotal ~/ 100).toInt(),
                                    amount: total,
                                    productIdentity: orderId,
                                    productName: "My Order",
                                  ),
                                  onSuccess: (PaymentSuccessModel v) {
                                    controller.makePayment(
                                      grandTotal: grandTotal,
                                      otherData: jsonEncode({
                                        "idx": v.idx,
                                        "amount": v.amount,
                                        "token": v.token,
                                        "mobile": v.mobile,
                                        "productIdentity": v.productIdentity,
                                        "productName": v.productName,
                                      }),
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
                                    controller.cancelOrder();
                                  },
                                );
                              },
                              child: Container(
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
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                        'https://web.khalti.com/static/img/logo1.png',
                                        height: 40),
                                    const Text('Pay with Khalti'),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
