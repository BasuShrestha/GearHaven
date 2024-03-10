import 'package:flutter/material.dart';
import 'package:gearhaven/app/components/cart_card.dart';
import 'package:gearhaven/app/models/cart_item.dart';
import 'package:gearhaven/app/utils/colors.dart';

import 'package:get/get.dart';

class OrderSummaryView extends GetView {
  const OrderSummaryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var orderedItems = Get.arguments as List<CartItem>;
    debugPrint(orderedItems[0].product.productName);
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderSummaryView'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: 625,
        child: orderedItems.isNotEmpty
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
                itemCount: orderedItems.length,
                itemBuilder: (context, index) => Stack(
                  children: [
                    CartCard(
                      cartItem: orderedItems[index],
                      index: index,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
