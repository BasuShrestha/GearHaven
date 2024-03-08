import 'dart:convert';

import 'package:gearhaven/app/data/services/order_services.dart';
import 'package:gearhaven/app/models/cart_item.dart';
import 'package:gearhaven/app/models/product.dart';
import 'package:gearhaven/app/routes/app_pages.dart';
import 'package:gearhaven/app/utils/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final count = 0.obs;
  List<CartItem> cart = [];

  OrderService orderService = OrderService();
  var createdOrderId = 0.obs;

  RxList<CartItem> selectedCartItems = RxList<CartItem>();

  void updateSelectedItem(int index, bool isSelected) {
    CartItem item = cart[index];
    item.isSelected = isSelected;

    if (isSelected) {
      if (!selectedCartItems.contains(item)) {
        selectedCartItems.add(item);
      }
    } else {
      selectedCartItems.remove(item);
    }
    updateTotal();
    update();
  }

  // void updateSelectedItem(int index, bool isSelected) {
  //   CartItem item = cart[index];
  //   if (isSelected) {
  //     if (!selectedCartItems.contains(item)) {
  //       selectedCartItems.add(item);
  //     }
  //   } else {
  //     selectedCartItems.remove(item);
  //   }
  //   update();
  // }

  var total = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getLocalCart();
    updateTotal();
  }

  void updateTotal() {
    total.value = 0;
    selectedCartItems.forEach(
      (element) {
        total.value =
            total.value + element.product.productPrice! * element.quantity;
      },
    );
  }

  void increaseQuantity(int index) {
    cart[index].quantity++;
    setLocalCart();
    updateTotal();
    update();
  }

  void getLocalCart() {
    var localCart = jsonDecode(LocalStorage.getCart() ?? '[]') as List<dynamic>;
    this.cart = localCart
        .map(
          (e) => CartItem(
            product: Product.fromJson(e['product']),
            quantity: e['quantity'],
          ),
        )
        .toList();
    updateTotal();
  }

  void setLocalCart() {
    LocalStorage.setCart(
      jsonEncode(
        cart
            .map((e) => {'product': e.product.toJson(), 'quantity': e.quantity})
            .toList(),
      ),
    );
  }

  void decreaseQuantity(int index) {
    if (cart[index].quantity <= 1) {
      Get.showSnackbar(
        const GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Quantity can\'t be less than 1',
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    cart[index].quantity--;
    setLocalCart();
    updateTotal();
    update();
  }

  void addProductToCart({required Product product, int? quantity}) {
    if (cart.any((element) => element.product.productId == product.productId)) {
      Get.showSnackbar(
        const GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Product already in cart!',
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    cart.add(CartItem(product: product, quantity: quantity ?? 1));
    Get.showSnackbar(
      const GetSnackBar(
        backgroundColor: Colors.green,
        message: 'Product added successfully!',
        duration: Duration(seconds: 3),
      ),
    );
    updateTotal();
    setLocalCart();
    update();
  }

  void removeProductFromCart(int index) {
    cart.removeAt(index);
    setLocalCart();
    updateTotal();
    update();
  }

  void createOrder() async {
    try {
      int userId = await LocalStorage.getUserId() ??
          0; // Assuming getUserId is async and has a fallback
      if (userId == 0) {
        // Handle the case where no user ID is found
        Get.snackbar(
          'User ID Error',
          'No user ID found',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      } else {
        debugPrint(userId.toString());
      }

      List<Map<String, dynamic>> cartItemsData = selectedCartItems.map((item) {
        return {
          "product": {
            "product_id": item.product.productId,
            "product_name": item.product.productName,
            "product_price": item.product.productPrice,
            "productstock_quantity": item.product.productstockQuantity,
            "product_desc": item.product.productDesc,
            "product_image": item.product.productImage,
            "productcategory_id": item.product.productcategoryId,
            "productsize_id": item.product.productsizeId,
            "productcondition_id": item.product.productconditionId,
            "productowner_id": item.product.productownerId,
            "for_rent": item.product.forRent,
            "user_name": item.product.userName,
            "category_name": item.product.categoryName,
            "productcondition_name": item.product.productconditionName,
            "productsize_name": item.product.productsizeName,
          },
          "isSelected": item.isSelected,
          "quantity": item.quantity,
        };
      }).toList();

      await orderService
          .createOrder(
        userId: await LocalStorage.getUserId() ?? 0,
        cartItems: cartItemsData,
      )
          .then((value) {
        createdOrderId.value = value.orderId ?? 0;
        Get.snackbar(
          'Error in code',
          value.message ?? 'Order created',
          colorText: Colors.white,
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 60),
        );
        debugPrint(value.orderId.toString());
        Get.toNamed(Routes.MAIN);
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 400),
        );
      });
    } catch (e) {
      Get.snackbar(
        'Error in code',
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 60),
      );
    }
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

  // void updateTotal() {
  //   total.value = 0;
  //   cart.forEach(
  //     (element) {
  //       total.value =
  //           total.value + element.product.productPrice! * element.quantity;
  //     },
  //   );
  // }

// CartItem(
//   quantity: 2,
//   product: Product(
//     productId: 1,
//     categoryName: 'Jacket',
//     forRent: 0,
//     productDesc: 'Nice Jacket',
//     productImage: null,
//     productName: 'Cart Jacket',
//     productPrice: 2000,
//     productcategoryId: 1,
//     productconditionId: 2,
//     productconditionName: 'Used',
//     productownerId: 1,
//     productsizeId: 1,
//     productsizeName: 'Medium',
//     productstockQuantity: 15,
//     userName: 'Some User',
//   ),
// ),
// CartItem(
//   quantity: 1,
//   product: Product(
//     productId: 1,
//     categoryName: 'Jacket',
//     forRent: 0,
//     productDesc: 'Nice Jacket',
//     productImage: null,
//     productName: 'Cart Jacket',
//     productPrice: 2000,
//     productcategoryId: 1,
//     productconditionId: 2,
//     productconditionName: 'Used',
//     productownerId: 1,
//     productsizeId: 1,
//     productsizeName: 'Medium',
//     productstockQuantity: 15,
//     userName: 'Some User',
//   ),
// ),
