import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/data/services/remote_services.dart';
import 'package:gearhaven/app/models/registration_response.dart';
import 'package:gearhaven/app/models/user_token.dart';
import 'package:get/get.dart' as gt;

class AuthServices extends RemoteServices {
  Future<UserToken> login(Map<String, dynamic> loginMap) async {
    try {
      final response = await json_dio.post('/login', data: loginMap);
      return userTokenFromJson(response.toString());
    } on DioException catch (err) {
      if (err.response?.statusCode == 404) {
        return Future.error(err.response?.data['message']);
      } else if (err.response?.statusCode == 401) {
        return Future.error(err.response?.data['message']);
      } else if (err.response?.statusCode == 400) {
        return Future.error(err.response?.data['errors'][0]['message']);
      } else if (err.response?.statusCode == 500) {
        return Future.error(err.response?.data['message']);
      } else {
        return Future.error(
            "Code: ${err.response!.statusCode} ${err.response!.data['message']}");
      }
    } catch (e) {
      gt.Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return Future.error(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      final response = await json_dio.post('/logout');
      if (response.statusCode == 200) {
        gt.Get.snackbar(
          "Success",
          "Logged out successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        gt.Get.snackbar(
          "Error",
          "Failed to log out",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      gt.Get.snackbar(
        "Error",
        e.response?.data['message'] ?? "Error during logout",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      gt.Get.snackbar(
        "Error",
        "An unexpected error occurred during logout: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<RegistrationResponse> register(Map<String, dynamic> register) async {
    try {
      final response = await json_dio.post('/register', data: register);
      return RegistrationResponse.fromJson(response.data);
    } on DioException catch (err) {
      if (err.response?.statusCode == 409) {
        return Future.error(err.response?.data['message']);
      } else if (err.response?.statusCode == 401) {
        return Future.error(err.response?.data['message']);
      } else if (err.response?.statusCode == 400) {
        return Future.error(err.response?.data['errors'][0]['message']);
      } else if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error!');
      } else {
        return Future.error("Error in the code");
      }
    } catch (e) {
      gt.Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return Future.error(e.toString());
    }
  }

  Future<String> verifyUserOTP(
    String email,
    String otp,
    String fullHash,
  ) async {
    try {
      final response = await json_dio.post(
        '/verifyOTP',
        data: {'email': email, 'OTP': otp, 'fullHashValue': fullHash},
      );
      return response.data['message'];
    } on DioException catch (err) {
      if (err.response?.statusCode == 400) {
        return Future.error(
            err.response?.data['message'] ?? 'The OTP is invalid');
      } else if (err.response?.statusCode == 401) {
        return Future.error(
            err.response?.data['message'] ?? 'The OTP is invalid or incorrect');
      } else if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('An error occurred: ${err.message}');
      }
    } catch (e) {
      return Future.error('An unexpected error occurred: $e');
    }
  }

  Future<String> resendUserOTP(String email, String userName) async {
    try {
      final response = await json_dio.post(
        '/resendOTP',
        data: {
          'email': email,
          'userName': userName,
        },
      );
      return response.data['message'];
    } on DioException catch (err) {
      if (err.response?.statusCode == 400) {
        return Future.error(
            err.response?.data['message'] ?? 'The OTP is invalid');
      } else if (err.response?.statusCode == 401) {
        return Future.error(
            err.response?.data['message'] ?? 'The OTP is invalid or incorrect');
      } else if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('An error occurred: ${err.message}');
      }
    } catch (e) {
      return Future.error('An unexpected error occurred: $e');
    }
  }

  Future<void> updateFcmToken(String oldFcmToken, String newFcmToken) async {
    try {
      final response = await json_dio.post(
        '/updateFcmToken/$oldFcmToken',
        data: {'newFcmToken': newFcmToken},
      );
      if (response.statusCode == 200) {
        gt.Get.snackbar(
          "Success",
          "FCM token updated successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        gt.Get.snackbar(
          "Error",
          "Failed to update FCM token",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      gt.Get.snackbar(
        "Error",
        e.response?.data['message'] ?? "Error updating FCM token",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      gt.Get.snackbar(
        "Error",
        "An unexpected error occurred: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
