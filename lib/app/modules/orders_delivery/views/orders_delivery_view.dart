import 'package:flutter/material.dart';
import 'package:gearhaven/app/components/sold_product_card.dart';
import 'package:gearhaven/app/utils/colors.dart';

import 'package:get/get.dart';

import '../controllers/orders_delivery_controller.dart';

class OrdersDeliveryView extends GetView<OrdersDeliveryController> {
  const OrdersDeliveryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersDeliveryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders to deliver',
          style: TextStyle(
            color: CustomColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: CustomColors.backgroundColor,
        centerTitle: true,
      ),
      body: GetBuilder<OrdersDeliveryController>(
        builder: (controller) => Container(
          color: CustomColors.backgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: controller.orders.isEmpty
              ? const Center(
                  child: Text(
                    'No products ordered yet...',
                    style: TextStyle(
                      fontSize: 22,
                      color: CustomColors.primaryColor,
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      SoldProductCard(
                        orderDetail: controller.orders[index],
                        index: index,
                        deliveryStatuses: controller.deliveryStatuses,
                        onStatusChanged: (newStatus) {
                          // Call a method in the controller to update the status
                          controller.updateDeliveryStatus(
                            controller.orders[index].orderId ?? 0,
                            controller.orders[index].productId ?? 0,
                            newStatus,
                          );
                        },
                      ),
                      Positioned(
                        right: 10,
                        top: 20,
                        child: Text(
                          'Total: ${controller.orders[index].lineTotal}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
