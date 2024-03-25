import 'package:flutter/material.dart';
import 'package:gearhaven/app/models/order_detail.dart';
import 'package:gearhaven/app/modules/Orders_page/controllers/orders_page_controller.dart';

import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderStatusView extends GetView<OrdersPageController> {
  const OrderStatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var orderDetail = Get.arguments['orderDetail'] as OrderDetail;
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Your Order Status'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 15),
        child: Stack(
          children: [
            Column(
              children: [
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
              ],
            ),
            Positioned(
              child: Expanded(
                child: ListView(
                  children: [
                    CustomTimelineTile(
                      isFirst: true,
                      isLast: false,
                      isPast: orderDetail.deliveryStatus == "Pending" ||
                              orderDetail.deliveryStatus == "Dispatched" ||
                              orderDetail.deliveryStatus == "In Transit" ||
                              orderDetail.deliveryStatus == "Delivered"
                          ? true
                          : false,
                      task: "Order Pending",
                    ),
                    CustomTimelineTile(
                      isFirst: false,
                      isLast: false,
                      isPast: orderDetail.deliveryStatus == "Pending" ||
                              orderDetail.deliveryStatus == "Dispatched" ||
                              orderDetail.deliveryStatus == "In Transit" ||
                              orderDetail.deliveryStatus == "Delivered"
                          ? true
                          : false,
                      task: "Order Placed",
                    ),
                    CustomTimelineTile(
                      isFirst: false,
                      isLast: false,
                      isPast: orderDetail.deliveryStatus == "Dispatched" ||
                              orderDetail.deliveryStatus == "In Transit" ||
                              orderDetail.deliveryStatus == "Delivered"
                          ? true
                          : false,
                      task: "Order Dispatched",
                    ),
                    CustomTimelineTile(
                      isFirst: false,
                      isLast: false,
                      isPast: orderDetail.deliveryStatus == "In Transit" ||
                              orderDetail.deliveryStatus == "Delivered"
                          ? true
                          : false,
                      task: "Order In Transit",
                    ),
                    CustomTimelineTile(
                      isFirst: false,
                      isLast: true,
                      isPast: orderDetail.deliveryStatus == "Delivered"
                          ? true
                          : false,
                      task: "Order Delivered",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String task;
  const CustomTimelineTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast ? Colors.green : Colors.lightGreenAccent.shade700,
        ),
        indicatorStyle: IndicatorStyle(
          width: 30,
          color: isPast ? Colors.green : Colors.lightGreenAccent.shade700,
          iconStyle: IconStyle(
            iconData: isPast ? Icons.circle_outlined : Icons.circle,
            color: Colors.white,
          ),
        ),
        endChild: Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            task,
            style: TextStyle(
              fontSize: isPast ? 18 : 22,
              color: isPast ? Colors.green : Colors.lightGreenAccent.shade700,
            ),
          ),
        ),
      ),
    );
  }
}
