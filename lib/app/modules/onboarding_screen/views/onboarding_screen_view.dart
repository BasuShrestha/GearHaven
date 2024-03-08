import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/onboarding_screen_controller.dart';

class OnboardingScreenView extends GetView<OnboardingScreenController> {
  const OnboardingScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller.onboardingPageController,
        itemCount: controller.pages.length,
        onPageChanged: (int page) {
          controller.activePage.value = page;
        },
        itemBuilder: (BuildContext context, int index) {
          return controller.pages[index];
        },
      ),
    );
  }
}
