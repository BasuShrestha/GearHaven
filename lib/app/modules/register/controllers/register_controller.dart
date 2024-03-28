import 'dart:convert';

// ignore: unused_import
import 'package:gearhaven/app/data/services/auth_services.dart';
import 'package:gearhaven/app/models/user.dart';
import 'package:gearhaven/app/routes/app_pages.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  AuthServices rs = AuthServices();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  List<User> allUsers = [];

  void register() {
    if (registerFormKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar(
          "Error",
          "Passwords don't match!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        try {
          isLoading.value = true;
          Map<String, dynamic> data = {
            "username":
                '${firstNameController.text} ${lastNameController.text}',
            "email": emailController.text,
            "password": passwordController.text,
            "location": locationController.text,
            "contact": contactController.text,
            "fcmToken": LocalStorage.getFcmToken(),
          };
          rs.register(data).then((value) {
            debugPrint(value.toString());
            Get.snackbar(
              "Success",
              value.toString(),
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: const Duration(seconds: 1),
            );
            isLoading.value = false;
            Get.offAllNamed(Routes.LOGIN);
          }).onError((error, stackTrace) {
            Get.snackbar(
              "Error",
              error.toString(),
              backgroundColor: Colors.red,
              colorText: Colors.white,
              duration: const Duration(seconds: 3),
            );
            isLoading.value = false;
          });
        } catch (e) {
          Get.snackbar(
            "Error",
            "Something went wrong!",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
          isLoading.value = false;
        }
      }
    }
  }

  Future<void> onRegister() async {
    if (registerFormKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar(
          "Error",
          "Passwords don't match!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      String url = '$baseUrl/register';
      Uri uri = Uri.parse(url);
      final response = await http.post(
        uri,
        body: jsonEncode(
          {
            "username":
                '${firstNameController.text} ${lastNameController.text}',
            "email": emailController.text,
            "password": passwordController.text,
            "location": locationController.text,
            "contact": contactController.text,
          },
        ),
        headers: {"Content-Type": "application/json"},
      );

      Map<String, dynamic> result = json.decode(response.body);
      if (response.statusCode == 200) {
        debugPrint(result.toString());
        Get.snackbar(
          "Success",
          result['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.back();
      } else if (response.statusCode == 400) {
        debugPrint(result.toString());
        Get.snackbar(
          "Error",
          result['errors'][0]['msg'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (response.statusCode == 409) {
        debugPrint(result.toString());
        Get.snackbar(
          "Error",
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        debugPrint("failed to load");
      }
    }
  }

  // Future<void> onRegister() async {
  //   if (registerFormKey.currentState!.validate()) {
  //     var data = {
  //       "userName": userNameController.text,
  //       "email": emailController.text,
  //       "password": passwordController.text,
  //       "location": locationController.text,
  //       "contact": contactController.text
  //     };
  //     debugPrint("Add user data $data");

  //     // var url = Uri.parse(registerApiURL + 'addUser');
  //     var url = Uri.parse(registerApiURL);

  //     try {
  //       final response = await http.post(url, body: data);
  //       // debugPrint(json.decode(response.body));

  //       // var result = json.decode(response.body);
  //       Map<String, dynamic> result = json.decode(response.body);
  //       if (response.statusCode == 200) {
  //         debugPrint(result['message']);
  //         Get.showSnackbar(
  //           GetSnackBar(
  //             message: result['message'],
  //             duration: const Duration(seconds: 1),
  //             backgroundColor: Colors.green,
  //           ),
  //         );
  //       } else {
  //         Get.showSnackbar(
  //           GetSnackBar(
  //             message: result['message'],
  //             duration: const Duration(seconds: 1),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //       }
  //     } catch (e) {
  //       debugPrint(e.toString());
  //       Get.showSnackbar(
  //         const GetSnackBar(
  //           message: "Something went wrong!",
  //           duration: Duration(seconds: 1),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
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
