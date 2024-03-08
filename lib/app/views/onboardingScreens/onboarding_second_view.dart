import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OnboardingSecondView extends GetView {
  const OnboardingSecondView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OnboardingSecondView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OnboardingSecondView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
