import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void loginErrorSnackbar({
    required BuildContext? context,
    SnackPosition? snackPosition,
    required String title,
    required String message,
    Duration? duration,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition ?? SnackPosition.TOP,
      backgroundColor: Colors.red.shade500,
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      icon: Icon(
        Icons.error_outline_rounded,
        size: 35,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  static void errorSnackbar({
    required BuildContext? context,
    SnackPosition? snackPosition,
    required String title,
    required String message,
    Duration? duration,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition ?? SnackPosition.TOP,
      backgroundColor: Colors.red.shade500,
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(2),
      icon: Icon(
        Icons.error_outline_rounded,
        size: 35,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      duration: duration ?? const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          'Dismiss',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  static void successSnackbar({
    required BuildContext? context,
    SnackPosition? snackPosition,
    required String title,
    required String message,
    Duration? duration,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition ?? SnackPosition.TOP,
      backgroundColor: Colors.green.shade500,
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      icon: Icon(
        Icons.check_circle_outline_outlined,
        size: 35,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      duration: duration ?? const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          'Dismiss',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  static void infoSnackbar({
    required BuildContext? context,
    SnackPosition? snackPosition,
    required String title,
    required String message,
    Duration? duration,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition ?? SnackPosition.TOP,
      backgroundColor: Colors.blueAccent,
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      icon: Icon(
        Icons.info_outline,
        size: 35,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      duration: duration ?? const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          'Dismiss',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
