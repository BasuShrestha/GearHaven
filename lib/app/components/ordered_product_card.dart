import 'package:gearhaven/app/models/order_detail.dart';
import 'package:gearhaven/app/modules/cart/controllers/cart_controller.dart';
import 'package:gearhaven/app/utils/assets.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderedProductCard extends StatelessWidget {
  final OrderDetail orderDetail;
  final int index;
  const OrderedProductCard({
    super.key,
    required this.orderDetail,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 20),
      height: 120,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: orderDetail.productImage == null
                ? Image.asset(
                    Assets.cartItemImagePlaceholder,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  )
                : Container(
                    padding: EdgeInsets.all(5),
                    child: Image.network(
                      getProductImageUrl(
                        orderDetail.productImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    orderDetail.productName ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Seller: ${orderDetail.userName}',
                    style: const TextStyle(fontSize: 11),
                  ),
                  Text(
                    'Contact: ${orderDetail.userContact}',
                    style: const TextStyle(fontSize: 11),
                  ),
                  Text(
                    'Location: ${orderDetail.userLocation}',
                    style: const TextStyle(fontSize: 11),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const Text(
                      //   "Delivery Status:",
                      //   style: TextStyle(
                      //     fontSize: 11,
                      //   ),
                      // ),
                      Text(
                        orderDetail.deliveryStatus ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: orderDetail.deliveryStatus == 'Delivered'
                              ? Colors.green.shade700
                              : Colors.amber.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
