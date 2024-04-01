import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gearhaven/app/data/services/renting_services.dart';
import 'package:gearhaven/app/models/rental_product.dart';
import 'package:gearhaven/app/models/wishlist.dart';
import 'package:gearhaven/app/modules/rent_page/controllers/rent_page_controller.dart';
import 'package:gearhaven/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:gearhaven/app/views/views/rental_payment_confirmation_view.dart';
import 'package:get/get.dart';

class RentalProductDescriptionController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  final Rx<DateTime> fromDate = DateTime.now().obs;
  final Rx<DateTime> toDate = DateTime.now().add(Duration(days: 1)).obs;
  final RxBool isDateSelectionVisible = false.obs;

  RentingService rentingService = RentingService();

  void toggleDateSelectionVisibility() {
    isDateSelectionVisible.value = !isDateSelectionVisible.value;
  }

  void setFromDate(DateTime date) {
    fromDate.value = date;
    if (toDate.value.isBefore(date)) {
      toDate.value = date.add(Duration(days: 1));
    }
  }

  void setToDate(DateTime date) {
    toDate.value = date;
  }

  double calculateTotalAmount(double ratePerDay) {
    return ratePerDay * toDate.value.difference(fromDate.value).inDays;
  }

  void resetDates() {
    fromDate.value = DateTime.now();
    toDate.value = DateTime.now().add(Duration(days: 1));
    isDateSelectionVisible.value = false;
  }

  void makePayment({
    required productId,
    required ownerId,
    required fromDate,
    required toDate,
    required amountPaid,
    required otherData,
    required productName,
    required ownerFCM,
    RentalProduct? product,
  }) async {
    try {
      isLoading.value = true;
      await rentingService
          .makeRentalPayment(
        productId: productId,
        ownerId: ownerId,
        renterId: LocalStorage.getUserId() ?? 0,
        fromDate: fromDate,
        toDate: toDate,
        paymentStatus: 'Paid',
        rentingStatus: 'Active',
        transactionType: 'rental',
        amountPaid: amountPaid,
        otherData: otherData,
        productName: productName,
        ownerFcmToken: ownerFCM,
      )
          .then((value) async {
        Get.snackbar(
          'Success',
          value,
          colorText: Colors.white,
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 60),
        );

        await Get.to(() => const RentalPaymentConfirmationView(), arguments: {
          'product': product,
          'fromDate': fromDate,
          'toDate': toDate,
          'paymentId': jsonDecode(otherData)['idx'],
          'amountPaid': amountPaid,
        });
        resetDates();
        Get.find<RentPageController>().allProducts.clear();
        Get.find<RentPageController>().getAllRentalProducts();
        Get.find<RentPageController>().userProducts.clear();
        Get.find<RentPageController>().getRentalProductsForCurrentUser();
        Get.find<RentPageController>().update();
        Get.find<WishlistController>()
            .wishlist
            .remove(Get.find<WishlistController>().wishlist.firstWhere(
                  (element) => element.productId == productId,
                ));
        Get.find<WishlistController>().getWishlistForUser();
        Get.find<WishlistController>().update();
        isLoading.value = false;

        update();
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Exception",
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 60),
        );
        debugPrint(error.toString());
        debugPrint(stackTrace.toString());
        isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 60),
      );
      debugPrint(e.toString());
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
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
