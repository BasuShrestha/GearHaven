import 'dart:typed_data';

import 'package:gearhaven/app/data/services/user_services.dart';
import 'package:gearhaven/app/models/user.dart';
import 'package:gearhaven/app/modules/main/controllers/main_controller.dart';
import 'package:flutter/material.dart';
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

  ImagePicker picker = ImagePicker();
  XFile? profileImage;
  var selectedImagePath = ''.obs;
  var selectedImageBytes = Rx<Uint8List?>(null);

  @override
  void onInit() {
    super.onInit();
    firstNameController.text = currentUser.value.userName!.split(' ')[0];
    lastNameController.text = currentUser.value.userName!.split(' ')[1];
    emailController.text = currentUser.value.userEmail ?? 'No Email';
    contactController.text = currentUser.value.userContact ?? 'No Contact';
    locationController.text = currentUser.value.userLocation ?? 'No Location';
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
