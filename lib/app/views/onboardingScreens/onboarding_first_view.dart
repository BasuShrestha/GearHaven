import 'package:gearhaven/app/modules/onboarding_screen/controllers/onboarding_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OnboardingFirstView extends GetView {
  const OnboardingFirstView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/imgs/Screen1.png"),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  var controller = Get.find<OnboardingScreenController>();
                  controller.activePage.value = controller.pages.length;
                },
                child: const Row(
                  children: [
                    Text(
                      "Skip",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Icon(
                      CupertinoIcons.forward,
                      size: 23,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 250,
              left: 35,
              child: Center(
                child: Text(
                  "Welcome to GearHaven!\nYour adventure begins here",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 110,
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 70, vertical: 10)),
                    backgroundColor: MaterialStatePropertyAll(
                      Color(0xFFFFA500),
                    ),
                    shadowColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {},
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
