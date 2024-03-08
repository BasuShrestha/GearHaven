import 'dart:convert';

import 'package:gearhaven/app/data/services/auth_services.dart';
import 'package:gearhaven/app/routes/app_pages.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:gearhaven/app/utils/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  //Repo repo = Repo(RemoteServices());

  AuthServices auth = AuthServices();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  OtpFieldController otpFieldController = OtpFieldController();
  TextEditingController otpEmailController = TextEditingController();
  TextEditingController otpNumberController = TextEditingController();
  //TextEditingController otpEmailController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    //repo;
    checkUserState();
  }

  void checkUserState() {
    isLoading.value = true;
    var accessToken = LocalStorage.getAccessToken();
    var refreshToken = LocalStorage.getRefreshToken();
    Future.delayed(const Duration(seconds: 2), () {
      debugPrint(accessToken);
      debugPrint(refreshToken);
      if (accessToken != null && refreshToken != null) {
        Get.offAllNamed(Routes.MAIN);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Please login again',
          backgroundColor: Colors.amber,
          colorText: Colors.white,
        );
      }
    });
  }

  // void showLoadingDialog(BuildContext context) {
  //   var screenSize = MediaQuery.of(context).size;
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false, // User must tap button to close dialog
  //     builder: (BuildContext context) {
  //       return Center(
  //         child: Container(
  //           width: screenSize.width * 0.3, // 30% of screen width
  //           height: screenSize.height * 0.3, // 30% of screen height
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<void> silentLogin() async {
  //   try {
  //     final refreshToken = LocalStorage.getRefreshToken();
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/refreshToken'),
  //       body: jsonEncode({'refreshToken': refreshToken}),
  //       headers: {'Content-Type': 'application/json'},
  //     );
  //   } catch (e) {}
  // }

  void validateLogin() {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      auth.login(data).then((value) {
        Get.snackbar(
          "Success",
          value.message ?? '',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
        LocalStorage.setAccessToken(value.accessToken ?? '');
        debugPrint(value.accessToken);
        LocalStorage.setRefreshToken(value.refreshToken ?? '');
        debugPrint(value.refreshToken);
        Get.offAllNamed(Routes.MAIN);
        isLoading.value = false;
      }).onError((error, stackTrace) {
        isLoading.value = false;
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      });
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Something went wrong!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void onLogin() async {
    if (loginFormKey.currentState!.validate()) {
      String url = '$baseUrl/login';
      Uri uri = Uri.parse(url);
      final response = await http.post(
        uri,
        body: jsonEncode(
          {
            "email": emailController.text,
            "password": passwordController.text,
          },
        ),
        headers: {"Content-Type": "application/json"},
      );

      Map<String, dynamic> result = jsonDecode(response.body);
      if (response.statusCode == 201) {
        debugPrint(result.toString());
        Get.snackbar(
          "Success",
          result['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
        LocalStorage.setAccessToken(result['accessToken']);
        debugPrint(result['accessToken']);
        LocalStorage.setRefreshToken(result['refreshToken']);
        debugPrint(result['refreshToken']);
        Get.offAllNamed(Routes.MAIN);
      } else if (response.statusCode == 401) {
        Get.snackbar(
          "Error",
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else if (response.statusCode == 500) {
        Get.snackbar(
          "Error",
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else if (response.statusCode == 400) {
        Get.snackbar(
          "Error",
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Error",
          "Something went wrong!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Please fill all the fields",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
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
