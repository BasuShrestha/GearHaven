import 'package:gearhaven/app/components/product_card.dart';
import 'package:gearhaven/app/models/product.dart';
import 'package:gearhaven/app/modules/cart/controllers/cart_controller.dart';
import 'package:gearhaven/app/routes/app_pages.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
        centerTitle: true,
        //backgroundColor: CustomColors.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchView(),
              );
            },
            icon: const Icon(Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.CART);
              },
              child: Stack(
                children: [
                  const Icon(
                    CupertinoIcons.cart,
                    size: 35,
                    color: CustomColors.accentColor,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Obx(
                        () => Center(
                          child: Text(
                            cartController.cart.length.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.only(right: 10),
          //   child: Icon(
          //     Icons.notifications,
          //     size: 30,
          //     color: CustomColors.accentColor,
          //   ),
          // ),
        ],
        backgroundColor: CustomColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: GetBuilder<HomeController>(
        builder: (context) => Container(
          padding: const EdgeInsets.all(10),
          color: CustomColors.backgroundColor,
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
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.PRODUCT_DESCRIPTION,
                              arguments: controller.products[index],
                            );
                            debugPrint(controller.products[index].productId
                                .toString());
                          },
                          child: SizedBox(
                            width: 200,
                            child: ProductCard(
                              product: controller.products[index],
                              onIconPress: () {
                                Get.find<CartController>().addProductToCart(
                                  product: controller.products[index],
                                  quantity: 1,
                                );
                              },
                            ),
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

HomeController controller = Get.find();

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: const Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> suggestions = [];
    suggestions = controller.products
        .where((element) =>
            element.productName?.toLowerCase().contains(query.toLowerCase()) ??
            false)
        .toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: suggestions.length,
      itemBuilder: (context, index) => SizedBox(
        height: 100,
        child: SearchResultCard(product: suggestions[index]),
      ),
    );
  }
}

class SearchResultCard extends StatelessWidget {
  final Product product;
  const SearchResultCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.PRODUCT_DESCRIPTION,
          arguments: product,
        );
        debugPrint(product.productId.toString());
      },
      child: Container(
        height: 75,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.network(
              getProductImageUrl(product.productImage),
              width: 75,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              product.productName ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            // Spacer(),
            // LocalStorage.getAccessRole() == 'admin'
            //     ? IconButton(
            //         onPressed: () {
            //           showDialog(
            //               context: context,
            //               builder: (context) => DeleteProductDialog(
            //                     productId: product.productId ?? '',
            //                   ));
            //         },
            //         icon: Icon(
            //           Icons.delete,
            //           color: Colors.red,
            //         ),
            //       )
            //     : SizedBox()
          ],
        ),
      ),
    );
  }
}
