// ignore_for_file: prefer_const_constructors

import 'package:gearhaven/app/components/cart_card.dart';
import 'package:gearhaven/app/components/customs/custom_button.dart';
import 'package:gearhaven/app/routes/app_pages.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Cart',
          style: TextStyle(
            color: CustomColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: CustomColors.backgroundColor,
        centerTitle: true,
      ),
      body: GetBuilder<CartController>(
        builder: (controller) => Container(
          color: CustomColors.backgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 625,
                child: controller.cart.isEmpty
                    ? const Center(
                        child: Text(
                          'No product in the cart...',
                          style: TextStyle(
                            fontSize: 22,
                            color: CustomColors.primaryColor,
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.cart.length,
                        itemBuilder: (context, index) => Stack(
                          children: [
                            CartCard(
                              cartItem: controller.cart[index],
                              index: index,
                            ),
                            Positioned(
                              right: 0,
                              child: Checkbox(
                                onChanged: (value) {
                                  controller.updateSelectedItem(
                                    index,
                                    value ?? false,
                                  );
                                },
                                value: controller.cart[index].isSelected,
                              ),
                            )
                          ],
                        ),
                      ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Your total:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.primaryColor,
                          ),
                        ),
                        Obx(
                          () => Text(
                            'Rs. ${controller.total.value}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        // TextButton(
                        //   onPressed: () async {
                        //     if (controller.cart.isEmpty) {
                        //       Get.showSnackbar(const GetSnackBar(
                        //         backgroundColor: Colors.red,
                        //         message: 'Cart is empty!',
                        //         duration: Duration(seconds: 3),
                        //       ));
                        //       return;
                        //     }
                        //     var orderId = await controller.makeOrder();
                        //     if (orderId == null) {
                        //       return;
                        //     }
                        //     KhaltiScope.of(Get.context!).pay(
                        //       preferences: [
                        //         PaymentPreference.khalti,
                        //         PaymentPreference.connectIPS
                        //       ],
                        //       config: PaymentConfig(
                        //         amount: 1000,
                        //         productIdentity: orderId.toString(),
                        //         productName: "My Product",
                        //       ),
                        //       onSuccess: (PaymentSuccessModel v) {
                        //         controller.makePayment(
                        //             total: (v.amount / 100).toString(),
                        //             orderId: orderId.toString(),
                        //             otherData: v.toString());
                        //       },
                        //       onFailure: (v) {
                        //         Get.showSnackbar(const GetSnackBar(
                        //           backgroundColor: Colors.red,
                        //           message: 'Payment failed!',
                        //           duration: Duration(seconds: 3),
                        //         ));
                        //       },
                        //       onCancel: () {
                        //         Get.showSnackbar(const GetSnackBar(
                        //           backgroundColor: Colors.red,
                        //           message: 'Payment cancelled!',
                        //           duration: Duration(seconds: 3),
                        //         ));
                        //       },
                        //     );
                        //   },
                        //   child: Container(
                        //       padding: const EdgeInsets.all(10),
                        //       margin: const EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(10),
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 5,
                        //               blurRadius: 7,
                        //             ),
                        //           ]),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Image.network(
                        //               'https://web.khalti.com/static/img/logo1.png',
                        //               height: 40),
                        //           Text('Pay with Khalti'),
                        //         ],
                        //       )),
                        // ),
                      ],
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    CustomButton(
                      color: Colors.green,
                      width: 100,
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      label: 'Continue',
                      onPressed: () {
                        controller.selectedCartItems.isEmpty
                            ? Get.snackbar(
                                'Info',
                                'Please select an item to proceed',
                                colorText: Colors.white,
                                backgroundColor: Colors.amber,
                                duration: const Duration(seconds: 1),
                              )
                            : Get.toNamed(Routes.HOME);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
