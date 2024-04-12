import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:gearhaven/app/components/customs/custom_button.dart';
import 'package:gearhaven/app/data/services/auth_services.dart';
import 'package:gearhaven/app/data/services/user_services.dart';
import 'package:gearhaven/app/models/user.dart';
import 'package:gearhaven/app/modules/main/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/routes/app_pages.dart';
import 'package:gearhaven/app/utils/colors.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePageController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  final String userName = "Arthur Morgan";
  final String userEmail = "arthurmorgan@gmail.com";
  final String userContact = "9812345678";
  final String userLocation = "Ranipauwa, Pokhara";
  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  Rx<User> currentUser = Get.find<MainController>().currentUser;

  UserServices userServices = UserServices();
  AuthServices authServices = AuthServices();

  ImagePicker picker = ImagePicker();
  XFile? profileImage;
  var selectedImagePath = ''.obs;
  var selectedImageBytes = Rx<Uint8List?>(null);

  @override
  void onInit() {
    super.onInit();
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = 'No Email';
    contactController.text = 'No Contact';
    locationController.text = 'No Location';

    fetchCurrentUser();
  }

  void fetchCurrentUser() async {
    var user = await userServices.getCurrentUser();
    if (user != null) {
      currentUser.value = user;
      firstNameController.text = user.userName?.split(' ')[0] ?? '';
      lastNameController.text = (user.userName?.split(' ').length ?? 0) > 1
          ? user.userName!.split(' ')[1]
          : '';
      emailController.text = user.userEmail ?? '';
      contactController.text = user.userContact ?? '';
      locationController.text = user.userLocation ?? '';
      update();
    }
  }

  void updateProfile() async {
    try {
      isLoading.value = true;
      await userServices
          .updateProfile(
        userId: currentUser.value.userId!,
        name: '${firstNameController.text} ${lastNameController.text}',
        email: emailController.text,
        contact: contactController.text,
        location: locationController.text,
        fileName: selectedImagePath.value,
        imageBytes: selectedImageBytes.value,
      )
          .then((value) {
        debugPrint(selectedImagePath.value);
        Get.snackbar(
          'Success',
          value,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 500),
        );
        Get.find<MainController>().getCurrentUser();
        Get.find<MainController>().update();
        update();
        isLoading.value = false;
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 500),
        );
        isLoading.value = false;
        debugPrint(error.toString());
        update();
      });
    } catch (e) {
      isLoading.value = false;
      update();
      debugPrint("Error in profile updation: $e");
      rethrow;
    }
  }

  void onlogOut() async {
    showCupertinoDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 15,
            ),
            width: 450,
            height: 100,
            child: Column(
              children: [
                Text(
                  "Are you sure you want to log out?",
                  style: TextStyle(
                    fontSize: 19,
                    color: CustomColors.primaryColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      width: 50,
                      height: 50,
                      labelStyle: TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                      ),
                      label: 'Yes',
                      onPressed: () async {
                        await authServices.logout();
                        LocalStorage.removeAll();
                        Get.toNamed(Routes.LOGIN);
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CustomButton(
                      width: 50,
                      height: 50,
                      labelStyle: TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                      ),
                      label: 'No',
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
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
