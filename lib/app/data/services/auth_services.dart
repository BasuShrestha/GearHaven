import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/data/services/remote_services.dart';
import 'package:gearhaven/app/models/user_token.dart';
import 'package:get/get.dart' as gt;

class AuthServices extends RemoteServices {
  Future<UserToken> login(Map<String, dynamic> loginMap) async {
    try {
      final response = await json_dio.post('/login', data: loginMap);
      return userTokenFromJson(response.toString());
    } on DioException catch (err) {
      if (err.response?.statusCode == 404) {
        return Future.error('Email not found');
      } else if (err.response?.statusCode == 401) {
        return Future.error(err.response?.data['message']);
      } else if (err.response?.statusCode == 400) {
        return Future.error(err.response?.data['errors'][0]['msg']);
      } else if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error!');
      } else {
        return Future.error("The else block");
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

  Future<String> register(Map<String, dynamic> register) async {
    try {
      final response = await json_dio.post('/register', data: register);
      return response.data['message'];
    } on DioException catch (err) {
      if (err.response?.statusCode == 409) {
        return Future.error(err.response?.data['message']);
      } else if (err.response?.statusCode == 401) {
        return Future.error(err.response?.data['message']);
      } else if (err.response?.statusCode == 400) {
        return Future.error(err.response?.data['errors'][0]['msg']);
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
}
