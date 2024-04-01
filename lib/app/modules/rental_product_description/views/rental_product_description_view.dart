import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/components/customs/custom_button.dart';
import 'package:gearhaven/app/modules/rent_page/controllers/rent_page_controller.dart';
import 'package:gearhaven/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:gearhaven/app/views/views/rental_confirmation_view.dart';
import 'package:gearhaven/app/views/views/rental_terms_view.dart';
import 'package:get/get.dart';
import 'package:gearhaven/app/models/rental_product.dart';
import 'package:gearhaven/app/modules/rental_product_description/controllers/rental_product_description_controller.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:intl/intl.dart'; // For date formatting

class RentalProductDescriptionView
    extends GetView<RentalProductDescriptionController> {
  const RentalProductDescriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.arguments as RentalProduct;
    var controller = Get.put(RentalProductDescriptionController());
    var wishlistController = Get.put(WishlistController());

    final dateFormat = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.productName?.toUpperCase() ?? '',
          style: const TextStyle(
            color: CustomColors.primaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.backgroundColor,
      ),
      body: GetBuilder<RentalProductDescriptionController>(
        builder: (controller) => Container(
          color: CustomColors.backgroundColor,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'product+${product.productId}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        width: double.infinity,
                        height: Get.height * 0.30,
                        getProductImageUrl(product.productImage ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName?.toUpperCase() ?? '',
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          product.productDesc ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Rs ${product.ratePerDay} per day',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        product.categoryName == 'Boots' ||
                                product.categoryName == 'Jackets' ||
                                product.categoryName == 'Gloves' ||
                                product.categoryName == 'Trousers'
                            ? Text(
                                'Size: ${product.productsizeName}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            : const SizedBox.shrink(),
                        Text(
                          'Offered By: ${product.userName}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Location: ${product.userLocation}',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Contact: ${product.userContact}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            product.rentingStatus == 'Active'
                                ? Row(
                                    children: [
                                      Obx(
                                        () => Text(
                                          wishlistController
                                                  .isProductInWishlist(
                                                      product.productId ?? 0)
                                              ? "Added to wishlist"
                                              : "Add to wishlist",
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (wishlistController
                                              .isProductInWishlist(
                                                  product.productId ?? 0)) {
                                            wishlistController
                                                .removeFromWishlist(
                                                    product.productId ?? 0);
                                            wishlistController
                                                .getWishlistForUser();
                                            wishlistController.update();
                                            Get.put(RentPageController())
                                                .getAllRentalProducts();
                                            Get.put(RentPageController())
                                                .update();
                                            controller.update();
                                          } else {
                                            wishlistController.addToWishlist(
                                                product.productId ?? 0);
                                            wishlistController
                                                .getWishlistForUser();
                                            wishlistController.update();

                                            Get.put(RentPageController())
                                                .getAllRentalProducts();
                                            Get.put(RentPageController())
                                                .update();
                                            controller.update();
                                          }
                                        },
                                        child: Obx(
                                          () => Icon(
                                            wishlistController
                                                    .isProductInWishlist(
                                                        product.productId ?? 0)
                                                ? CupertinoIcons.heart_fill
                                                : CupertinoIcons.heart,
                                            color: CustomColors.accentColor,
                                            size: 30,
                                            weight: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    // Product image and details...
                    // Date selection and total amount wrapped in a card for better UI
                    Obx(
                      () {
                        if (controller.isDateSelectionVisible.value) {
                          return Card(
                            margin: const EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // From Date Picker
                                      _buildDateSelector(
                                        context,
                                        label: 'Rent From',
                                        date: controller.fromDate.value,
                                        onTap: () async {
                                          DateTime? selectedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate:
                                                controller.fromDate.value,
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100),
                                          );
                                          if (selectedDate != null) {
                                            controller
                                                .setFromDate(selectedDate);
                                          }
                                        },
                                      ),
                                      // To Date Picker
                                      _buildDateSelector(
                                        context,
                                        label: 'Rent To',
                                        date: controller.toDate.value,
                                        onTap: () async {
                                          DateTime? selectedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate:
                                                controller.toDate.value,
                                            firstDate:
                                                controller.fromDate.value,
                                            lastDate: DateTime(2100),
                                          );
                                          if (selectedDate != null) {
                                            controller.setToDate(selectedDate);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  // Total amount
                                  Text(
                                    'Total Amount: Rs ${controller.calculateTotalAmount(product.ratePerDay ?? 0)}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
              product.rentingStatus == 'Active'
                  ? Container(
                      padding: EdgeInsets.all(10),
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: CustomColors.accentColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outlined,
                                size: 25,
                                color: CustomColors.accentColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "This product has been rented already.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 35),
                            child: Text(
                              "Please add it to the wishlist to get notified when it becomes available again.",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 50,
              ),
              Obx(
                () => CustomButton(
                  isDisabled: product.rentingStatus == 'Active' ? true : false,
                  label: controller.isDateSelectionVisible.value
                      ? 'Proceed to Rent'
                      : 'Rent',
                  onPressed: () {
                    if (product.rentingStatus == 'Active') {
                      Get.snackbar(
                        'Info',
                        'This product is already rented.',
                        backgroundColor: Colors.blue,
                        duration: const Duration(
                          seconds: 1,
                        ),
                      );
                      return;
                    }
                    if (controller.isDateSelectionVisible.value) {
                      if (controller.calculateTotalAmount(product.ratePerDay!) >
                          0) {
                        Get.to(() => const RentalConfirmationView(),
                            arguments: product);
                      } else {
                        Get.snackbar(
                          'Bad',
                          'Select a valid duration',
                          backgroundColor: Colors.red,
                        );
                      }
                      // Navigate to confirmation page
                      // Add your navigation logic here
                    } else {
                      controller.toggleDateSelectionVisibility();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context,
      {required String label,
      required DateTime date,
      required VoidCallback onTap}) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.calendar_today, size: 20),
              const SizedBox(width: 10),
              Text(
                dateFormat.format(date),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
