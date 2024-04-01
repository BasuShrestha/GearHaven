import 'package:flutter/material.dart';
import 'package:gearhaven/app/components/wishlist_card.dart';
import 'package:gearhaven/app/models/wishlist.dart';
import 'package:gearhaven/app/utils/colors.dart';

import 'package:get/get.dart';

import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(WishlistController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Wishlist',
          style: TextStyle(
            color: CustomColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: CustomColors.backgroundColor,
        centerTitle: true,
      ),
      body: GetBuilder<WishlistController>(
        builder: (controller) => Container(
          color: CustomColors.backgroundColor,
          height: Get.height,
          padding: const EdgeInsets.all(16.0),
          child: controller.wishlist.isEmpty
              ? const Center(
                  child: Text(
                    'No items in the wishlist...',
                    style: TextStyle(
                      fontSize: 22,
                      color: CustomColors.primaryColor,
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.wishlist.length,
                  itemBuilder: (context, index) {
                    Wishlist wishlistItem = controller.wishlist[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.navigateToDescription(
                                  productId: wishlistItem.productId ?? 0);
                            },
                            child: SizedBox(
                              height: 120,
                              child: WishlistCard(
                                product: wishlistItem,
                                onDeleteIconPress: () {
                                  controller.onRemoveFromWishlist(wishlistItem);
                                },
                              ),
                            ),
                          ),
                          wishlistItem.rentingStatus == 'Active'
                              ? Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: CustomColors.accentColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Rented",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                )
                              : Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Available",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
