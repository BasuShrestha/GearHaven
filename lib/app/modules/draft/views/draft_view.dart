import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/draft_controller.dart';

class DraftView extends GetView<DraftController> {
  const DraftView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'DraftView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
