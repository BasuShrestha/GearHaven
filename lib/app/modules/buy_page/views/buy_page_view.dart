import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/buy_page_controller.dart';

class BuyPageView extends GetView<BuyPageController> {
  const BuyPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BuyPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BuyPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
