import 'package:flutter/material.dart';
import 'package:gearhaven/app/data/services/renting_services.dart';
import 'package:gearhaven/app/models/renting.dart';
import 'package:gearhaven/app/modules/rent_page/controllers/rent_page_controller.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:get/get.dart';

class ActiveRentingsController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  RentingService rentingService = RentingService();

  RxList<Renting> allRentings = RxList<Renting>();

  RxList<Renting> activeRentings = RxList<Renting>();

  List<String> rentingStatuses = [
    "Active",
    "Completed",
  ];

  @override
  void onInit() {
    super.onInit();
    getRentingsForUser();
  }

  void getRentingsForUser() async {
    isLoading.value = true;
    try {
      int currentUserId = LocalStorage.getUserId() ?? 0;
      debugPrint("Current User Id: ${currentUserId.toString()}");
      List<Renting> fetchedRentings =
          await rentingService.fetchRentingsByOwnerId(currentUserId);

      if (fetchedRentings.isNotEmpty) {
        for (Renting r in fetchedRentings) {
          if (r.rentingStatus == 'Active') {
            activeRentings.add(r);
          }
        }
        // allRentings.assignAll(fetchedRentings);
        debugPrint(fetchedRentings.length.toString());
        Get.snackbar(
          'All orders fetched successfully',
          '',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        update();
      } else {
        Get.snackbar(
          'Info',
          'No orders found',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
        update();
      }
    } catch (e) {
      // Get.snackbar(
      //   'Error',
      //   e.toString(),
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void updateRentingStatus({
    required int rentingId,
    required productId,
    required productName,
    required String newStatus,
  }) async {
    debugPrint("New status in update order: $newStatus");
    debugPrint("User Id in update order: ${LocalStorage.getUserId()}");
    try {
      await rentingService
          .updateRentingStatus(
        rentingId: rentingId,
        productId: productId,
        productName: productName,
        status: newStatus,
        // buyerFcm: buyerFcm,
      )
          .then((value) {
        Get.snackbar(
          'Success',
          value,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        activeRentings.clear();
        getRentingsForUser();
        Get.find<RentPageController>().allProducts.clear();
        Get.find<RentPageController>().getAllRentalProducts();
        Get.find<RentPageController>().userProducts.clear();
        Get.find<RentPageController>().getRentalProductsForCurrentUser();
        Get.find<RentPageController>().update();
        update();
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 500),
        );
      });
    } catch (e) {
      Get.snackbar(
        "Exception in code",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 500),
      );
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
