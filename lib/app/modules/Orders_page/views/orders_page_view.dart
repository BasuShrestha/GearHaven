import 'package:flutter/material.dart';
import 'package:gearhaven/app/components/ordered_product_card.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:gearhaven/app/views/views/order_status_view.dart';

import 'package:get/get.dart';

import '../controllers/orders_page_controller.dart';

class OrdersPageView extends GetView<OrdersPageController> {
  const OrdersPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders to receive',
          style: TextStyle(
            color: CustomColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: CustomColors.backgroundColor,
        centerTitle: true,
      ),
      body: GetBuilder<OrdersPageController>(
        builder: (controller) => Container(
          color: CustomColors.backgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: controller.allOrders.isEmpty
              ? const Center(
                  child: Text(
                    'No orders left to receive...',
                    style: TextStyle(
                      fontSize: 22,
                      color: CustomColors.primaryColor,
                    ),
                  ),
                )
              : Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.allOrders.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Get.to(() => const OrderStatusView(), arguments: {
                          "orderDetail": controller.allOrders[index],
                        });
                      },
                      child: OrderedProductCard(
                        orderDetail: controller.allOrders[index],
                        index: index,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
