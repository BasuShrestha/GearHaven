import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gearhaven/app/components/customs/custom_snackbar.dart';
import 'package:gearhaven/app/data/services/auth_services.dart';
import 'package:gearhaven/app/routes/app_pages.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';

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

  String? deviceFCM = LocalStorage.getFcmToken() ?? 'No Token';

  dynamic fcmToken = '';

  @override
  void onInit() async {
    super.onInit();
    checkUserState();
    fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint('Device FCM in login: $deviceFCM');
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
        // Get.snackbar(
        //   'Error',
        //   'Please login again',
        //   backgroundColor: Colors.amber,
        //   colorText: Colors.white,
        // );
      }
    });
  }

  void validateLogin() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        debugPrint("Storage FCM: $deviceFCM");
        debugPrint("Firebase FCM: $deviceFCM");
        Map<String, dynamic> data = {
          'email': emailController.text,
          'password': passwordController.text,
          'fcmToken': fcmToken,
        };
        await auth.login(data).then((value) {
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
          debugPrint(value.user?.fcmToken ?? 'No fcm Token');
          LocalStorage.setUserId(value.user?.userId ?? 0);
          debugPrint(value.user?.userId.toString() ?? 'No user Id');
          Get.offAllNamed(Routes.MAIN);
          isLoading.value = false;
        }).onError((error, stackTrace) {
          isLoading.value = false;
          debugPrint(error.toString());
          CustomSnackbar.loginErrorSnackbar(
            context: Get.context,
            title: 'Incorrect Password',
            message: error.toString(),
          );
        });
      } catch (e) {
        isLoading.value = false;
        Get.snackbar(
          "Error",
          "Something went wrong!",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Fill all the fields!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  // void onLogin() async {
  //   if (loginFormKey.currentState!.validate()) {
  //     String url = '$baseUrl/login';
  //     Uri uri = Uri.parse(url);
  //     final response = await http.post(
  //       uri,
  //       body: jsonEncode(
  //         {
  //           "email": emailController.text,
  //           "password": passwordController.text,
  //         },
  //       ),
  //       headers: {"Content-Type": "application/json"},
  //     );

  //     Map<String, dynamic> result = jsonDecode(response.body);
  //     if (response.statusCode == 201) {
  //       debugPrint(result.toString());
  //       Get.snackbar(
  //         "Success",
  //         result['message'],
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white,
  //         duration: const Duration(seconds: 1),
  //       );
  //       LocalStorage.setAccessToken(result['accessToken']);
  //       debugPrint(result['accessToken']);
  //       LocalStorage.setRefreshToken(result['refreshToken']);
  //       debugPrint(result['refreshToken']);
  //       Get.offAllNamed(Routes.MAIN);
  //     } else if (response.statusCode == 401) {
  //       Get.snackbar(
  //         "Error",
  //         result['message'],
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         duration: const Duration(seconds: 2),
  //       );
  //     } else if (response.statusCode == 500) {
  //       Get.snackbar(
  //         "Error",
  //         result['message'],
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         duration: const Duration(seconds: 2),
  //       );
  //     } else if (response.statusCode == 400) {
  //       Get.snackbar(
  //         "Error",
  //         result['message'],
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         duration: const Duration(seconds: 2),
  //       );
  //     } else {
  //       Get.snackbar(
  //         "Error",
  //         "Something went wrong!",
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         duration: const Duration(seconds: 2),
  //       );
  //     }
  //   } else {
  //     Get.snackbar(
  //       "Error",
  //       "Please fill all the fields",
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       duration: const Duration(seconds: 2),
  //     );
  //   }
  // }

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
