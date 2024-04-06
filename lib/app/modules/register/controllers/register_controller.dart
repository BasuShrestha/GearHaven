// ignore: unused_import
import 'package:gearhaven/app/data/services/auth_services.dart';
import 'package:gearhaven/app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/routes/app_pages.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:gearhaven/app/views/views/email_verification_view.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var fullHashValue = '';
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

  void register() async {
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
          await rs.register(data).then((value) {
            debugPrint(value.toString());
            Get.snackbar(
              "Success",
              value.toString(),
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: const Duration(seconds: 1),
            );
            fullHashValue = value.fullHash ?? '';
            Get.to(() => const EmailVerificationView());
            isLoading.value = false;
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

  Future<void> verifyEnteredOTP(String email, String otp) async {
    try {
      isLoading(true);
      await rs.verifyUserOTP(email, otp, fullHashValue).then((value) {
        Get.snackbar(
          'Success',
          value,
          backgroundColor: Colors.green,
          duration: const Duration(
            seconds: 1,
          ),
        );
        Get.offAllNamed(Routes.LOGIN);
      }).onError((error, stackTrace) {
        Get.snackbar(
          'Success',
          error.toString(),
          backgroundColor: Colors.red,
          duration: const Duration(
            seconds: 3,
          ),
        );
      });
    } catch (e) {
      Get.snackbar(
        'Success',
        e.toString(),
        backgroundColor: Colors.red,
        duration: const Duration(
          seconds: 3,
        ),
      );
    }
  }

  Future<void> resendUserOTP(String email, String userName) async {
    try {
      isLoading(true);
      await rs.resendUserOTP(email, userName).then((value) {
        Get.snackbar(
          'Success',
          value,
          backgroundColor: Colors.green,
          duration: const Duration(
            seconds: 1,
          ),
        );
      }).onError((error, stackTrace) {
        Get.snackbar(
          'Error',
          error.toString(),
          backgroundColor: Colors.red,
          duration: const Duration(
            seconds: 3,
          ),
        );
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        duration: const Duration(
          seconds: 3,
        ),
      );
    }
  }

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
