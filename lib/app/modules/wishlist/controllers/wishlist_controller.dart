import 'package:flutter/material.dart';
import 'package:gearhaven/app/data/services/wishlist_services.dart';
import 'package:gearhaven/app/models/rental_product.dart';
import 'package:gearhaven/app/models/wishlist.dart';
import 'package:gearhaven/app/modules/rental_product_description/views/rental_product_description_view.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  WishlistService wishlistService = WishlistService();
  RxList<Wishlist> wishlist = RxList<Wishlist>();
  @override
  void onInit() {
    super.onInit();
    getWishlistForUser();
  }

  bool isProductInWishlist(int productId) {
    return wishlist.any((element) => element.productId == productId);
  }

  void getWishlistForUser() async {
    isLoading.value = true;
    try {
      int currentUserId = LocalStorage.getUserId() ?? 0;
      debugPrint("Current User Id: ${currentUserId.toString()}");
      List<Wishlist> fetchedProducts =
          await wishlistService.fetchWishlistByUserId(currentUserId);

      if (fetchedProducts.isNotEmpty) {
        wishlist.assignAll(fetchedProducts);
        debugPrint(fetchedProducts.length.toString());
        // Get.snackbar(
        //   'All wishlist fetched successfully',
        //   '',
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
        update();
      } else {
        // Get.snackbar(
        //   'Info',
        //   'No wishlist found',
        //   backgroundColor: Colors.blue,
        //   colorText: Colors.white,
        // );
        debugPrint("No wishlist items");
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

  Future<void> addToWishlist(int productId) async {
    isLoading.value = true;
    try {
      await wishlistService
          .addToWishlist(
              userId: LocalStorage.getUserId() ?? 0, productId: productId)
          .then((value) {
        Get.snackbar(
          'Success',
          value,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        getWishlistForUser();
        update();
        isLoading.value = false;
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 500),
        );
      });
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      debugPrint("Error in adding to wishlist: $e");
      rethrow;
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    isLoading.value = true;
    try {
      int wishlistId = wishlist
              .firstWhere((element) => element.productId == productId)
              .wishlistId ??
          0;
      await wishlistService
          .removeFromWishlist(wishlistId: wishlistId)
          .then((value) {
        Get.snackbar(
          'Success',
          value,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        wishlist.remove(
            wishlist.firstWhere((element) => element.wishlistId == wishlistId));
        getWishlistForUser();
        update();
        isLoading.value = false;
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 500),
        );
      });
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      debugPrint("Error in removal from wishlist: $e");
      rethrow;
    }
  }

  void onRemoveFromWishlist(Wishlist product) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Remove ${product.productName}',
          style: TextStyle(
            color: CustomColors.primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          "Are you sure you want to remove '${product.productName}' from your wishlist?",
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'No',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text(
              'Yes',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            ),
            onPressed: () async {
              removeFromWishlist(product.productId ?? 0);
              update();
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void navigateToDescription({required int productId}) async {
    RentalProduct product =
        await wishlistService.fetchRentalProductById(productId);
    Get.to(
      () => const RentalProductDescriptionView(),
      arguments: product,
    );
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
