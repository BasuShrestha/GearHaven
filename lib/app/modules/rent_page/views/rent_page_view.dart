import 'package:gearhaven/app/components/product_card.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rent_page_controller.dart';

class RentPageView extends GetView<RentPageController> {
  const RentPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RentPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rentings'),
        backgroundColor: CustomColors.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: GetBuilder<RentPageController>(
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
                        physics: const NeverScrollableScrollPhysics(),
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
                            hideIcon: true,
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
    );
  }
}
