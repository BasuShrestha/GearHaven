// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:gearhaven/app/routes/app_pages.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:gearhaven/app/utils/localStorage.dart';
import 'package:get/get.dart' as gt;

class RemoteServices {
  final Dio json_dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 8000),
      receiveTimeout: const Duration(seconds: 8000),
      responseType: ResponseType.json,
      contentType: 'application/json',
    ),
  );

  final Dio multipart_dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 8000),
      receiveTimeout: const Duration(seconds: 8000),
      responseType: ResponseType.json,
      contentType: 'multipart/form-data',
    ),
  );

  RemoteServices() {
    json_dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["Accept"] = 'application/json';
          String? accessToken = LocalStorage.getAccessToken();
          options.headers["Authorization"] = 'Bearer $accessToken';
          return handler.next(options);
        },
        onError: ((error, handler) async {
          if (error.response?.statusCode == 401) {
            final newAccessToken = await refreshToken();
            if (newAccessToken != null) {
              json_dio.options.headers["Authorization"] =
                  'Bearer $newAccessToken';
              return handler
                  .resolve(await json_dio.fetch(error.requestOptions));
            }
          }
          return handler.next(error);
        }),
      ),
    );
    multipart_dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["Accept"] = 'mulipart/form-data';
          String? accessToken = LocalStorage.getAccessToken();
          options.headers["Authorization"] = 'Bearer $accessToken';
          return handler.next(options);
        },
        onError: ((error, handler) async {
          if (error.response?.statusCode == 401) {
            final newAccessToken = await refreshToken();
            if (newAccessToken != null) {
              json_dio.options.headers["Authorization"] =
                  'Bearer $newAccessToken';
              return handler
                  .resolve(await json_dio.fetch(error.requestOptions));
            }
          }
          return handler.next(error);
        }),
      ),
    );
    // json_dio.interceptors.add(
    //   LogInterceptor(
    //     request: true,
    //     requestBody: true,
    //     responseBody: true,
    //   ),
    // );
  }

  Future<String?> refreshToken() async {
    try {
      final refreshToken = LocalStorage.getRefreshToken();
      final response = await json_dio.post(
        '/refresh-token',
        data: {
          'refreshToken': refreshToken,
        },
      );
      final newAccessToken = response.data['accessToken'];
      LocalStorage.setAccessToken(newAccessToken);
      return newAccessToken;
    } catch (e) {
      LocalStorage.removeAll();
      gt.Get.offAllNamed(Routes.LOGIN);
    }
    return null;
  }

  // Future<String> uploadProduct({
  //   required String name,
  //   required int price,
  //   required int quantity,
  //   required String description,
  //   required String fileName,
  //   required Uint8List? imageBytes,
  //   required int category,
  //   required int size,
  //   required int condition,
  //   required int ownerId,
  // }) async {
  //   FormData formData = FormData.fromMap({
  //     "name": name,
  //     "price": price,
  //     "stockQuantity": quantity,
  //     "description": description,
  //     "image": imageBytes != null
  //         ? MultipartFile.fromBytes(imageBytes, filename: fileName)
  //         : null,
  //     "categoryId": category,
  //     "sizeId": size,
  //     "conditionId": condition,
  //     "ownerId": ownerId,
  //   });

  //   try {
  //     Response response =
  //         await multipart_dio.post('/products/sale', data: formData);
  //     if (response.data != null && response.data['message'] is String) {
  //       debugPrint(response.data);
  //       return response.data['message'];
  //     } else {
  //       debugPrint("Image upload failed with status: ${response.statusCode}");
  //       return response.data['message'];
  //     }
  //   } on DioException catch (err) {
  //     debugPrint("DioException caught: ${err.response?.data}");
  //     if (err.response?.statusCode == 500) {
  //       return Future.error('Internal Server Error');
  //     } else if (err.response?.statusCode == 400) {
  //       return Future.error('Error code 400');
  //     } else {
  //       return Future.error('Error in the code: ${err.message}');
  //     }
  //   } catch (e) {
  //     debugPrint("Exception caught: $e");
  //     return Future.error(e.toString());
  //   }
  // }

  // Future<String> updateProfile({
  //   required int userId,
  //   required String name,
  //   required String email,
  //   required String contact,
  //   required String location,
  //   required String fileName,
  //   Uint8List? imageBytes,
  // }) async {
  //   FormData formData = FormData.fromMap({
  //     "username": name,
  //     "email": email,
  //     "contact": contact,
  //     "location": location,
  //     "image": imageBytes != null
  //         ? MultipartFile.fromBytes(imageBytes, filename: fileName)
  //         : null,
  //   });

  //   try {
  //     String endpoint = '/update-profile/$userId';
  //     Response response = await multipart_dio.post(endpoint, data: formData);
  //     if (response.statusCode == 200) {
  //       var responseData = response.data;
  //       if (responseData is Map<String, dynamic> &&
  //           responseData.containsKey('message') &&
  //           responseData['message'] is String) {
  //         return responseData['message'];
  //       } else {
  //         throw Exception("Unexpected response format");
  //       }
  //     } else {
  //       // Handle non-200 responses
  //       return "Error: Server responded with status code ${response.statusCode}";
  //     }
  //   } on DioException catch (dioError) {
  //     if (dioError.response?.statusCode == 401) {
  //       return Future.error('401: ${dioError.response?.data['message']}');
  //     } else if (dioError.response?.statusCode == 400) {
  //       return Future.error('400: ${dioError.response?.data['message']}');
  //     } else if (dioError.response?.statusCode == 500) {
  //       return Future.error('Internal Server Error');
  //     } else {
  //       return Future.error('An error occurred: ${dioError.message}');
  //     }
  //   } catch (e) {
  //     // Handle any other types of errors
  //     return "Exception: $e";
  //   }
  // }
}
