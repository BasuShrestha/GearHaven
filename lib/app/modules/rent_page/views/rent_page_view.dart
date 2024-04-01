import 'package:flutter/cupertino.dart';
import 'package:gearhaven/app/components/rental_product_card.dart';
import 'package:gearhaven/app/modules/active_rentings/views/active_rentings_view.dart';
import 'package:gearhaven/app/modules/rental_product_description/views/rental_product_description_view.dart';
import 'package:gearhaven/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rent_page_controller.dart';

class RentPageView extends GetView<RentPageController> {
  const RentPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RentPageController());
    var wishlistController = Get.put(WishlistController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rentings'),
          backgroundColor: CustomColors.primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: TabBar(
              labelColor: CustomColors.accentColor,
              unselectedLabelColor: Colors.white,
              dividerHeight: 0,
              padding: const EdgeInsets.symmetric(vertical: 10),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
              indicator: BoxDecoration(
                color: CustomColors.accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              tabs: const [
                Tab(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                  child: Text(
                    "Rent",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.upload,
                    color: Colors.white,
                    size: 30,
                  ),
                  child: Text(
                    "Upload",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            GetBuilder<RentPageController>(
              builder: (context) => Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Obx(
                  () => Stack(
                    children: [
                      controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: CustomColors.accentColor,
                              ),
                            )
                          : controller.allProducts.isNotEmpty
                              ? GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.allProducts.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.75,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                  ),
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () =>
                                            const RentalProductDescriptionView(),
                                        arguments:
                                            controller.allProducts[index],
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        RentalProductCard(
                                          product:
                                              controller.allProducts[index],
                                          hideIcon: true,
                                          onIconPress: () {
                                            controller.onUpdateProduct(
                                              controller.allProducts[index],
                                            );
                                          },
                                        ),
                                        controller.allProducts[index]
                                                    .rentingStatus ==
                                                'Active'
                                            ? Positioned(
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: CustomColors
                                                        .accentColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    "On Rent",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox.shrink(),
                                        controller.allProducts[index]
                                                    .rentingStatus ==
                                                'Active'
                                            ? Positioned(
                                                right: 0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    var product = controller
                                                        .allProducts[index];
                                                    if (wishlistController
                                                        .isProductInWishlist(
                                                            product.productId ??
                                                                0)) {
                                                      wishlistController
                                                          .removeFromWishlist(
                                                              product.productId ??
                                                                  0);
                                                      wishlistController
                                                          .getWishlistForUser();
                                                      wishlistController
                                                          .update();
                                                      controller.update();
                                                    } else {
                                                      wishlistController
                                                          .addToWishlist(product
                                                                  .productId ??
                                                              0);
                                                      wishlistController
                                                          .getWishlistForUser();
                                                      wishlistController
                                                          .update();
                                                      controller.update();
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Obx(
                                                      () => Icon(
                                                        wishlistController.isProductInWishlist(controller
                                                                    .allProducts[
                                                                        index]
                                                                    .productId ??
                                                                0)
                                                            ? CupertinoIcons
                                                                .heart_fill
                                                            : CupertinoIcons
                                                                .heart,
                                                        color: CustomColors
                                                            .accentColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: Text("No Products to display..."),
                                ),
                    ],
                  ),
                ),
              ),
            ),
            GetBuilder<RentPageController>(
              builder: (context) => Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Obx(
                  () => Stack(
                    children: [
                      controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: CustomColors.accentColor,
                              ),
                            )
                          : controller.userProducts.isNotEmpty
                              ? GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.userProducts.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.75,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                  ),
                                  itemBuilder: (context, index) => Stack(
                                    children: [
                                      RentalProductCard(
                                        product: controller.userProducts[index],
                                        showDeleteIcon: true,
                                        onDeleteIconPress: () {
                                          controller.onDeleteProduct(
                                              controller.userProducts[index]);
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: CustomColors.accentColor,
                                        ),
                                        onIconPress: () {
                                          controller.onUpdateProduct(
                                              controller.userProducts[index]);
                                        },
                                      ),
                                      controller.userProducts[index]
                                                  .rentingStatus ==
                                              'Active'
                                          ? Positioned(
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color:
                                                      CustomColors.accentColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Rented",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Positioned(
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Available",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                )
                              : const Center(
                                  child: Text("No Products to display..."),
                                ),
                      Positioned(
                        bottom: 10,
                        right: 0,
                        child: Row(
                          children: [
                            ElevatedButton.icon(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  CustomColors.accentColor,
                                ),
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                                padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 10,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                controller.onAddProduct();
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 25,
                              ),
                              label: const Text(
                                "Add Product",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onHover: (value) {},
                              onTap: () {
                                Get.to(() => const ActiveRentingsView());
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: CustomColors.accentColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.local_shipping,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
