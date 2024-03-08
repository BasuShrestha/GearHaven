import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OnboardingThirdView extends GetView {
  const OnboardingThirdView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OnboardingThirdView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OnboardingThirdView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
