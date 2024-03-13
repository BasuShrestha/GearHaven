import 'package:dio/dio.dart';
import 'package:gearhaven/app/data/services/remote_services.dart';
import 'package:gearhaven/app/models/order_response.dart';

class OrderService extends RemoteServices {
  OrderService() : super();

  Future<OrderResponse> createOrder({
    required int userId,
    required double orderTotal,
    required List cartItems,
  }) async {
    try {
      String endPoint = '/create-order';

      Response response = await json_dio.post(
        endPoint,
        data: {
          "userId": userId,
          "orderTotal": orderTotal,
          "cart": cartItems,
        },
      );
      if (response.statusCode == 201) {
        return OrderResponse.fromJson(response.data);
      } else {
        throw Exception(
            "Error: Server responded with status code ${response.statusCode}");
      }
    } on DioException catch (dioError) {
      throw Exception("DioException: ${dioError.message}");
    } catch (e) {
      throw Exception("Exception: $e");
    }
  }

  Future<String> cancelOrder(int orderId) async {
    try {
      String endPoint = '/order/cancel/$orderId';
      Response response = await json_dio.put(endPoint);
      if (response.statusCode == 200) {
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

  Future<String> payForOrder(int orderId) async {
    try {
      String endPoint = '/order/pay/$orderId';
      Response response = await json_dio.put(endPoint);
      if (response.statusCode == 200) {
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

  Future<String> makePayment({
    required int userId,
    required int orderId,
    required double amountPaid,
    required String otherData,
  }) async {
    try {
      String endPoint = '/make-payment';
      Response response = await json_dio.post(
        endPoint,
        data: {
          "userId": userId,
          "orderId": orderId,
          "amountPaid": amountPaid,
          "otherData": otherData,
        },
      );
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
      if (dioError.response?.statusCode == 409) {
        return Future.error('409 Error: ${dioError.response?.data['message']}');
      } else if (dioError.response?.statusCode == 401) {
        return Future.error('401 Error: ${dioError.response?.data['message']}');
      } else if (dioError.response?.statusCode == 400) {
        return Future.error('400 Error: ${dioError.response?.data['message']}');
      } else if (dioError.response?.statusCode == 500) {
        return Future.error('500 Error: ${dioError.response?.data['message']}');
      } else {
        return Future.error("Error in the code");
      }
    } catch (e) {
      return "Exception: $e";
    }
  }
}
