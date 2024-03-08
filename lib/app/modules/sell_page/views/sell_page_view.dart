import 'package:gearhaven/app/components/product_card.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sell_page_controller.dart';

class SellPageView extends GetView<SellPageController> {
  const SellPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SellPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Current Listings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.primaryColor,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: CustomColors.accentColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                CupertinoIcons.add,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<SellPageController>(
        builder: (context) => Container(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: CustomColors.accentColor,
                    ),
                  )
                : controller.products.isNotEmpty
                    ? GridView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) => SizedBox(
                          width: 200,
                          child: ProductCard(
                            showDeleteIcon: true,
                            onDeleteIconPress: () {
                              controller
                                  .onDeleteProduct(controller.products[index]);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: CustomColors.accentColor,
                            ),
                            onIconPress: () {
                              controller
                                  .onUpdateProduct(controller.products[index]);
                            },
                            product: controller.products[index],
                          ),
                        ),
                      )
                    : const Center(
                        child: Text("No Products to display..."),
                      ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: CustomColors.primaryColor,
        onPressed: () {
          controller.onAddProduct();
        },
        label: const Row(
          children: [
            Icon(
              Icons.add,
              size: 23,
            ),
            Text(
              "Add Product",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
