import 'package:gearhaven/app/views/onboardingScreens/onboarding_first_view.dart';
import 'package:gearhaven/app/views/onboardingScreens/onboarding_second_view.dart';
import 'package:gearhaven/app/views/onboardingScreens/onboarding_third_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreenController extends GetxController {
  final count = 0.obs;

  // controls the pages in the onboarding screens
  final PageController onboardingPageController = PageController();
  var activePage = 0.obs;

  final pages = [
    const OnboardingFirstView(),
    const OnboardingSecondView(),
    const OnboardingThirdView(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  void increment() => count.value++;
}
