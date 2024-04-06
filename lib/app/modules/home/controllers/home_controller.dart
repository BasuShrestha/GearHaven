import 'package:gearhaven/app/data/services/product_services.dart';
import 'package:gearhaven/app/models/product.dart';
import 'package:gearhaven/app/models/product_category.dart';
import 'package:gearhaven/app/models/product_condition.dart';
import 'package:gearhaven/app/models/product_size.dart';
import 'package:gearhaven/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  ProductServices productServices = ProductServices();
  RxList<Product> products = RxList<Product>();

  RxList<ProductCategory> categories = RxList<ProductCategory>();
  RxList<ProductCondition> conditions = RxList<ProductCondition>();
  RxList<ProductSize> sizes = RxList<ProductSize>();

  var selectedCategory = Rxn<ProductCategory>();
  var selectedSize = Rxn<ProductSize>();
  var selectedCondition = Rxn<ProductCondition>();
  var priceMin = Rxn<double>();
  var priceMax = Rxn<double>();

  @override
  void onInit() {
    super.onInit();
    getProducts();
    getAllCategories();
    getAllConditions();
    getAllSizes();
    Get.put(CartController());
  }

  void getAllCategories() async {
    try {
      categories.value = await productServices.getAllProductCategories();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getAllSizes() async {
    try {
      sizes.value = await productServices.getAllProductSizes();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getAllConditions() async {
    try {
      conditions.value = await productServices.getAllProductConditions();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getProducts() async {
    isLoading(true);
    try {
      var fetchedProducts = await productServices.fetchAllSalesProducts();
      products.value = fetchedProducts;
      isLoading(false);
      update();
    } catch (e) {
      isLoading(false);
      update();
      debugPrint(e.toString());
    }
  }

  void showFilterDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Filter Products',
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Category Dropdown
              const Text(
                "Product Category",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Obx(
                () => DropdownButton<ProductCategory?>(
                  hint: Text('Select a category'),
                  value: selectedCategory.value,
                  onChanged: (newValue) {
                    selectedCategory.value = newValue;
                    update();
                  },
                  items: [
                        DropdownMenuItem<ProductCategory?>(
                          value: null,
                          child: Text('Select a category'),
                        )
                      ] +
                      categories.map((value) {
                        return DropdownMenuItem<ProductCategory?>(
                          value: value,
                          child: Text(value.categoryName ?? ''),
                        );
                      }).toList(),
                ),
              ),
              const Text(
                "Product Size",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              // Size Dropdown
              Obx(
                () => DropdownButton<ProductSize?>(
                  hint: Text('Select a size'),
                  value: selectedSize.value,
                  onChanged: (newValue) {
                    selectedSize.value = newValue;
                    update();
                  },
                  items: [
                        DropdownMenuItem<ProductSize?>(
                          value: null,
                          child: Text('Select a size'),
                        )
                      ] +
                      sizes.map((value) {
                        return DropdownMenuItem<ProductSize?>(
                          value: value,
                          child: Text(value.productsizeName ?? ''),
                        );
                      }).toList(),
                ),
              ),
              const Text(
                "Product Condition",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              // Condition Dropdown
              Obx(
                () => DropdownButton<ProductCondition?>(
                  hint: Text('Select a condition'),
                  value: selectedCondition.value,
                  onChanged: (newValue) {
                    selectedCondition.value = newValue;
                    update();
                  },
                  items: [
                        DropdownMenuItem<ProductCondition?>(
                          value: null,
                          child: Text('Select a condition'),
                        )
                      ] +
                      conditions.map((value) {
                        return DropdownMenuItem<ProductCondition?>(
                          value: value,
                          child: Text(value.productconditionName ?? ''),
                        );
                      }).toList(),
                ),
              ),
              // Price Range TextFields
              TextField(
                decoration: InputDecoration(labelText: 'Minimum Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) => priceMin.value = double.tryParse(value),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Maximum Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) => priceMax.value = double.tryParse(value),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Apply Filters'),
            onPressed: () {
              getFilteredProducts(
                categoryId: selectedCategory.value?.categoryId,
                conditionId: selectedCondition.value?.productconditionId,
                sizeId: selectedSize.value?.productsizeId,
                priceMin: priceMin.value,
                priceMax: priceMax.value,
              );
              Get.back(); // Close the dialog
            },
          ),
          TextButton(
            child: Text('Reset'),
            onPressed: () {
              // Reset the selected filter parameters
              selectedCategory.value = null;
              selectedCondition.value = null;
              selectedSize.value = null;
              priceMin.value = null;
              priceMax.value = null;
              getFilteredProducts();
              update(); // Trigger a rebuild to update the UI
              Get.back();
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(), // Close the dialog
          ),
        ],
      ),
    );
  }

  void getFilteredProducts(
      {int? categoryId,
      int? conditionId,
      int? sizeId,
      double? priceMin,
      double? priceMax}) async {
    isLoading(true);
    try {
      var filteredProducts = await productServices.fetchFilteredSaleProducts(
        categoryId: categoryId,
        conditionId: conditionId,
        sizeId: sizeId,
        priceMin: priceMin,
        priceMax: priceMax,
      );
      products.value = filteredProducts;
      isLoading(false);
      update();
    } catch (e) {
      isLoading(false);
      update();
      debugPrint(e.toString());
    }
  }
}
