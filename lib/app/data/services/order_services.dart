import 'package:dio/dio.dart';
import 'package:gearhaven/app/data/services/remote_services.dart';
import 'package:gearhaven/app/models/cart_item.dart';

class OrderService extends RemoteServices {
  OrderService() : super();

  Future<String> createOrder({
    required int userId,
    required List<CartItem> cartItems,
  }) async {
    List<Map<String, dynamic>> cartItemsData = cartItems.map((item) {
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

    FormData formData = FormData.fromMap({
      "userId": userId,
      "cart": cartItemsData,
    });

    try {
      String endPoint = '/create-order';
      Response response = await json_dio.post(endPoint, data: formData);
      if (response.statusCode == 201) {
        var responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('message') &&
            responseData['message'] is String) {
          return responseData['message'];
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        return "Error: Server responded with status code ${response.statusCode}";
      }
    } on DioException catch (dioError) {
      return "DioException: ${dioError.message}";
    } catch (e) {
      return "Exception: $e";
    }
  }
}
