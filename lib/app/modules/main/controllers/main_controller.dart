import 'package:gearhaven/app/data/services/user_services.dart';
import 'package:gearhaven/app/models/user.dart';
import 'package:gearhaven/app/modules/Orders_page/views/orders_page_view.dart';
import 'package:gearhaven/app/modules/home/views/home_view.dart';
import 'package:gearhaven/app/modules/rent_page/views/rent_page_view.dart';
import 'package:gearhaven/app/modules/sell_page/views/sell_page_view.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:gearhaven/app/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final count = 0.obs;
  UserServices userServices = UserServices();

  RxBool isDarkMode = false.obs;
  ThemeData appTheme = lightModeTheme;
  var currentPageIndex = 0.obs;

  Rx<User> currentUser = User().obs;

  final pages = const [
    HomeView(),
    OrdersPageView(),
    SellPageView(),
    RentPageView(),
    // ProfilePageView(),
  ];

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      await userServices.getCurrentUser().then((value) {
        currentUser.value = value;
        debugPrint(value.userId.toString());
        debugPrint(value.userName.toString());
        debugPrint(value.userEmail.toString());
        debugPrint(value.userContact.toString());
        debugPrint(value.userLocation.toString());
        LocalStorage.setUserId(value.userId ?? 0);
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 400),
        );
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error",
        "Failed to fetch user data: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    appTheme = isDarkMode.value ? darkModeTheme : lightModeTheme;
    update();
    // ThemeData theme = appTheme;
    // if (theme == lightModeTheme) {
    //   appTheme = darkModeTheme;
    // } else {
    //   appTheme = lightModeTheme;
    // }
  }

  void onDestinationSelected(int value) {
    currentPageIndex.value = value;
    update();
  }

  void increment() => count.value++;
}
