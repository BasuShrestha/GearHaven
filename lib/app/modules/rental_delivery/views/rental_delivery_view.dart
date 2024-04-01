import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rental_delivery_controller.dart';

class RentalDeliveryView extends GetView<RentalDeliveryController> {
  const RentalDeliveryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RentalDeliveryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RentalDeliveryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
