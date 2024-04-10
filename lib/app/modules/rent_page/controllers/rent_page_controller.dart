import 'dart:typed_data';

import 'package:gearhaven/app/components/customs/custom_button.dart';
import 'package:gearhaven/app/components/customs/custom_textfield.dart';
import 'package:gearhaven/app/data/services/product_services.dart';
import 'package:gearhaven/app/models/rental_product.dart';
import 'package:gearhaven/app/models/product_category.dart';
import 'package:gearhaven/app/models/product_condition.dart';
import 'package:gearhaven/app/models/product_size.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/modules/main/controllers/main_controller.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RentPageController extends GetxController {
  final count = 0.obs;

  var isLoading = false.obs;

  GlobalKey<FormState> uploadProductKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateProductKey = GlobalKey<FormState>();

  ProductServices productServices = ProductServices();
  RxList<RentalProduct> userProducts = RxList<RentalProduct>();
  RxList<RentalProduct> allProducts = RxList<RentalProduct>();
  List<ProductCategory> categories = [];
  List<ProductSize> sizes = [];
  List<ProductCondition> conditions = [];

  var selectedCategory = Rx<ProductCategory?>(null);
  var selectedSize = Rx<ProductSize?>(null);
  var selectedCondition = Rx<ProductCondition?>(null);

  final ImagePicker picker = ImagePicker();
  var selectedImagePath = ''.obs;
  var selectedImageBytes = Rx<Uint8List?>(null);

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getAllRentalProducts();
    getRentalProductsForCurrentUser();
    getAllCategories();
    getAllSizes();
  }

  void clearControllers() {
    nameController.clear();
    priceController.clear();
    quantityController.clear();
    descriptionController.clear();
    rateController.clear();

    selectedCategory.value = categories[0];
    selectedSize.value = sizes[0];
    selectedImagePath = ''.obs;
    selectedImageBytes.value = null;
  }

  void getAllRentalProducts() async {
    isLoading = true.obs;
    try {
      await productServices.fetchAllRentalProducts().then((value) {
        for (RentalProduct p in value) {
          if (p.userLocation ==
              Get.find<MainController>().currentUser.value.userLocation) {
            allProducts.add(p);
          }
        }
        //allProducts.value = value;
        // Get.snackbar(
        //   'Success',
        //   'Sales Products Fetched',
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        //   duration: Duration(seconds: 3),
        // );
        isLoading = false.obs;
        update();
      }).onError((error, stackTrace) {
        Get.snackbar(
          'Error',
          error.toString(),
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        isLoading = false.obs;
        update();
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 50),
      );
      isLoading = false.obs;
      update();
      debugPrint(e.toString());
    }
  }

  void getRentalProductsForCurrentUser() async {
    isLoading.value = true;
    try {
      int currentUserId = LocalStorage.getUserId() ?? 0;
      await productServices
          .fetchRentalProductsByOwnerId(currentUserId)
          .then((value) {
        List<RentalProduct> fetchedProducts = value;
        if (fetchedProducts.isNotEmpty) {
          userProducts.assignAll(fetchedProducts);

          // Get.snackbar(
          //   'Success',
          //   'Sale Products fetched successfully for the current user',
          //   backgroundColor: Colors.green,
          //   colorText: Colors.white,
          // );
        } else {
          Get.snackbar(
            'Info',
            'No rental products found for the current user',
            backgroundColor: Colors.blue,
            colorText: Colors.white,
          );
        }
      }).onError((error, stackTrace) {
        Get.snackbar(
          'Error',
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 500),
        );
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      debugPrint(e.toString());
    } finally {
      isLoading.value = false; // Use isLoading(false) to set it back
    }
  }

  void getAllCategories() async {
    try {
      categories = await productServices.getAllProductCategories();
      if (categories.isNotEmpty) {
        selectedCategory.value = categories.first;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getAllSizes() async {
    try {
      sizes = await productServices.getAllProductSizes();
      if (sizes.isNotEmpty) {
        selectedSize.value = sizes.first;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> uploadProduct() async {
    //final String fileName = path.basename(selectedImagePath.value);
    //debugPrint(fileName);
    isLoading.value = true;
    if (uploadProductKey.currentState!.validate()) {
      try {
        double? rateForDay = double.tryParse(rateController.text);
        int? stockQuantity = int.tryParse(quantityController.text);
        //int? userId = int.tryParse(LocalStorage.getUserId().toString());
        await productServices
            .uploadProduct(
          forRent: true,
          name: nameController.text,
          quantity: stockQuantity ?? 0,
          description: descriptionController.text,
          fileName: selectedImagePath.value,
          imageBytes: selectedImageBytes.value,
          category: selectedCategory.value?.categoryId ?? 0,
          size: selectedSize.value?.productsizeId ?? 0,
          ownerId: LocalStorage.getUserId() ?? 0,
          rateForDay: rateForDay,
        )
            .then((value) {
          Get.snackbar(
            'Success',
            value,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          getAllRentalProducts();
          getRentalProductsForCurrentUser();
          clearControllers();
          Get.find<RentPageController>().getRentalProductsForCurrentUser();
          Get.find<RentPageController>().update();
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
        debugPrint(userProducts.toString());
        update();
      } catch (e) {
        isLoading.value = false;
        update();
        debugPrint("Error in uploadProduct: $e");
        rethrow;
      }
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Missing values in the formfields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateRentalProduct(RentalProduct product) async {
    isLoading.value = true;
    if (updateProductKey.currentState!.validate()) {
      try {
        double? price = double.tryParse(priceController.text);
        double? ratePerDay = double.tryParse(rateController.text);
        int? stockQuantity = int.tryParse(quantityController.text);
        await productServices
            .updateRentalProduct(
          productId: product.productId ?? 0,
          name: nameController.text,
          price: price ?? 0,
          quantity: stockQuantity ?? 0,
          description: descriptionController.text,
          fileName: selectedImagePath.value,
          imageBytes: selectedImageBytes.value,
          category: selectedCategory.value?.categoryId ?? 0,
          size: selectedSize.value?.productsizeId ?? 0,
          condition: selectedCondition.value?.productconditionId ?? 8,
          ownerId: LocalStorage.getUserId() ?? 0,
          ratePerDay: ratePerDay,
        )
            .then((value) {
          Get.snackbar(
            'Success',
            value,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          getAllRentalProducts();
          getRentalProductsForCurrentUser();
          clearControllers();
          Get.find<RentPageController>().getRentalProductsForCurrentUser();
          Get.find<RentPageController>().update();
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
        debugPrint(userProducts.toString());
        update();
      } catch (e) {
        isLoading.value = false;
        update();
        debugPrint("Error in updateProduct: $e");
        rethrow;
      }
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Missing values in the formfields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void onAddProduct() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Add New Rental Product',
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Form(
            key: uploadProductKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextfield(
                  controller: nameController,
                  label: 'Name',
                  textInputAction: TextInputAction.next,
                  labelStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  textStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  cursorColor: CustomColors.primaryColor,
                  borderColor: CustomColors.primaryColor,
                  iconColor: CustomColors.primaryColor,
                ),
                CustomTextfield(
                  controller: quantityController,
                  label: 'Quantity',
                  textInputAction: TextInputAction.next,
                  keyboardType: const TextInputType.numberWithOptions(),
                  labelStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  textStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  cursorColor: CustomColors.primaryColor,
                  borderColor: CustomColors.primaryColor,
                  iconColor: CustomColors.primaryColor,
                ),
                CustomTextfield(
                  controller: descriptionController,
                  label: 'Description',
                  textInputAction: TextInputAction.next,
                  labelStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  textStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  cursorColor: CustomColors.primaryColor,
                  borderColor: CustomColors.primaryColor,
                  iconColor: CustomColors.primaryColor,
                ),
                CustomTextfield(
                  controller: rateController,
                  label: 'Rate per day',
                  textInputAction: TextInputAction.next,
                  keyboardType: const TextInputType.numberWithOptions(),
                  labelStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  textStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  cursorColor: CustomColors.primaryColor,
                  borderColor: CustomColors.primaryColor,
                  iconColor: CustomColors.primaryColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Product Category",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Obx(
                  () => DropdownButton<ProductCategory>(
                    value: selectedCategory.value,
                    onChanged: (ProductCategory? newValue) {
                      selectedCategory.value = newValue!;
                      update();
                    },
                    items: categories.map<DropdownMenuItem<ProductCategory>>(
                        (ProductCategory value) {
                      return DropdownMenuItem<ProductCategory>(
                        value: value,
                        child: Text(value.categoryName ?? ''),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Product Size",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Obx(
                  () => DropdownButton<ProductSize>(
                    value: selectedSize.value,
                    onChanged: (ProductSize? newValue) {
                      selectedSize.value = newValue!;
                      update();
                    },
                    items: sizes.map<DropdownMenuItem<ProductSize>>(
                        (ProductSize value) {
                      return DropdownMenuItem<ProductSize>(
                        value: value,
                        child: Text(value.productsizeName ?? ''),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => selectedImageBytes.value != null
                        ? Image.memory(
                            selectedImageBytes.value!,
                            width: 100,
                            height: 100,
                          )
                        : const Text(
                            "No image selected",
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    width: 100,
                    height: 50,
                    label: 'Pick Image',
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        selectedImagePath.value = image.name;
                        final Uint8List imageBytes = await image.readAsBytes();
                        selectedImageBytes.value = imageBytes;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              nameController.clear();
              priceController.clear();
              quantityController.clear();
              descriptionController.clear();
              Get.back();
              clearControllers();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () async {
              uploadProduct();
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void onUpdateProduct(RentalProduct product) {
    nameController.text = product.productName ?? '';
    priceController.text = product.productPrice.toString();
    quantityController.text = product.productstockQuantity.toString();
    descriptionController.text = product.productDesc ?? '';
    rateController.text = product.ratePerDay.toString();

    int selectedCategoryIndex = categories.indexWhere(
      (element) => element.categoryId == product.productcategoryId,
    );
    if (selectedCategoryIndex != -1) {
      selectedCategory.value = categories[selectedCategoryIndex];
    }

    int selectedConditionIndex = conditions.indexWhere(
      (element) => element.productconditionId == product.productconditionId,
    );
    if (selectedConditionIndex != -1) {
      selectedCondition.value = conditions[selectedConditionIndex];
    }

    int selectedSizeIndex = sizes.indexWhere(
      (element) => element.productsizeId == product.productsizeId,
    );
    if (selectedSizeIndex != -1) {
      selectedSize.value = sizes[selectedSizeIndex];
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Update ${product.productName}',
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Form(
            key: updateProductKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextfield(
                  controller: nameController,
                  label: 'Name',
                  textInputAction: TextInputAction.next,
                  labelStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  textStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  cursorColor: CustomColors.primaryColor,
                  borderColor: CustomColors.primaryColor,
                  iconColor: CustomColors.primaryColor,
                ),
                CustomTextfield(
                  controller: quantityController,
                  label: 'Quantity',
                  textInputAction: TextInputAction.next,
                  keyboardType: const TextInputType.numberWithOptions(),
                  labelStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  textStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  cursorColor: CustomColors.primaryColor,
                  borderColor: CustomColors.primaryColor,
                  iconColor: CustomColors.primaryColor,
                ),
                CustomTextfield(
                  controller: descriptionController,
                  label: 'Description',
                  textInputAction: TextInputAction.next,
                  labelStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  textStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  cursorColor: CustomColors.primaryColor,
                  borderColor: CustomColors.primaryColor,
                  iconColor: CustomColors.primaryColor,
                ),
                CustomTextfield(
                  controller: rateController,
                  label: 'Rate per day',
                  textInputAction: TextInputAction.next,
                  keyboardType: const TextInputType.numberWithOptions(),
                  labelStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  textStyle: const TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                  ),
                  cursorColor: CustomColors.primaryColor,
                  borderColor: CustomColors.primaryColor,
                  iconColor: CustomColors.primaryColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Product Category",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Obx(
                  () => DropdownButton<ProductCategory>(
                    value: selectedCategory.value,
                    onChanged: (ProductCategory? newValue) {
                      selectedCategory.value = newValue!;
                      update();
                    },
                    items: categories.map<DropdownMenuItem<ProductCategory>>(
                        (ProductCategory value) {
                      return DropdownMenuItem<ProductCategory>(
                        value: value,
                        child: Text(value.categoryName ?? ''),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Product Size",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Obx(
                  () => DropdownButton<ProductSize>(
                    value: selectedSize.value,
                    onChanged: (ProductSize? newValue) {
                      selectedSize.value = newValue!;
                      update(); // Make sure to call update to refresh the UI
                    },
                    items: sizes.map<DropdownMenuItem<ProductSize>>(
                        (ProductSize value) {
                      return DropdownMenuItem<ProductSize>(
                        value: value,
                        child: Text(value.productsizeName ?? ''),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => selectedImageBytes.value != null
                        ? Image.memory(
                            selectedImageBytes.value!,
                            width: 100,
                            height: 100,
                          )
                        : Image.network(
                            getProductImageUrl(
                              product.productImage,
                            ),
                            width: 100,
                            height: 100,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    width: 100,
                    height: 50,
                    label: 'Pick Image',
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        selectedImagePath.value = image.name;
                        final Uint8List imageBytes = await image.readAsBytes();
                        selectedImageBytes.value = imageBytes;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Get.back();
              clearControllers();
            },
          ),
          TextButton(
            child: const Text('Update'),
            onPressed: () async {
              updateRentalProduct(product);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Future<void> deleteProduct(RentalProduct product) async {
    isLoading.value = true;
    try {
      await productServices
          .deleteProduct(
        productId: product.productId ?? 0,
      )
          .then((value) {
        Get.snackbar(
          'Success',
          value,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        getAllRentalProducts();
        getRentalProductsForCurrentUser();
        clearControllers();
        Get.find<RentPageController>().getRentalProductsForCurrentUser();
        Get.find<RentPageController>().update();
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
      debugPrint(userProducts.toString());
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      debugPrint("Error in updateProduct: $e");
      rethrow;
    }
  }

  void onDeleteProduct(RentalProduct product) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Delete ${product.productName}',
          style: TextStyle(
            color: CustomColors.primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          "Are you sure you want to delete '${product.productName}' from your listings?",
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
              deleteProduct(product);
              Get.back();
            },
          ),
        ],
      ),
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
