import 'package:gearhaven/app/components/customs/custom_button.dart';
import 'package:gearhaven/app/models/product.dart';
import 'package:gearhaven/app/modules/cart/controllers/cart_controller.dart';
import 'package:gearhaven/app/modules/product_description/controllers/product_description_controller.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProductDescriptionView extends GetView<ProductDescriptionController> {
  const ProductDescriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.arguments as Product;
    var cartController = Get.find<CartController>();
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
      body: Container(
        color: CustomColors.backgroundColor,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'product+${product.productId}',
                  child: Image.network(
                    width: double.infinity,
                    height: Get.height * 0.4,
                    getProductImageUrl(product.productImage ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName?.toUpperCase() ?? '',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        product.productDesc ?? '',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Rs ${product.productPrice}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Seller: ${product.userName}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      product.categoryName == 'Boots' ||
                              product.categoryName == 'Jackets' ||
                              product.categoryName == 'Gloves' ||
                              product.categoryName == 'Trousers'
                          ? Text(
                              'Size: ${product.productsizeName}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      Text(
                        'Condition: ${product.productconditionName}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Category: ${product.categoryName}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Stock Quantity: ${product.productstockQuantity}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (controller.quantity > 1) {
                      controller.quantity--;
                    }
                  },
                  icon: Icon(
                    Icons.remove,
                    size: 20,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.quantity.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if ((product.productstockQuantity!) >
                        controller.quantity.value) {
                      controller.quantity++;
                    }
                  },
                  icon: Icon(
                    Icons.add,
                    size: 20,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: Get.width * 0.4,
                  label: 'Add to Cart',
                  onPressed: () {
                    cartController.addProductToCart(
                      product: product,
                      quantity: controller.quantity.value,
                    );
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomButton(
                  width: Get.width * 0.4,
                  label: 'Buy Now',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
