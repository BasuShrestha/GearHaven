import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gearhaven/app/modules/Orders_page/controllers/orders_page_controller.dart';
import 'package:gearhaven/app/routes/app_pages.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:get/get.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint("Title: ${message.notification?.title}");
  debugPrint("Body: ${message.notification?.body}");
  debugPrint("Payload: ${message.data}");
  Get.toNamed(Routes.ORDERS_DELIVERY, arguments: message);
}

Future<void> handleMessage(RemoteMessage message) async {
  debugPrint("Title: ${message.notification?.title}");
  debugPrint("Body: ${message.notification?.body}");
  debugPrint("Payload: ${message.data}");
  Get.find<OrdersPageController>()
      .getOrderedProductsForUser(LocalStorage.getUserId() ?? 0);
  Get.find<OrdersPageController>().update();
  Get.toNamed(Routes.ORDERS_PAGE);
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // navigatorKey.currentState
    //     ?.pushNamed(Routes.ORDERS_DELIVERY, arguments: message);
    // Get.toNamed(Routes.ORDERS_DELIVERY, arguments: message);
    if (message.data['messageType'] == 'deliveryStatus') {
      Get.find<OrdersPageController>()
          .getOrderedProductsForUser(LocalStorage.getUserId() ?? 0);
      Get.find<OrdersPageController>().update();
      Get.toNamed(Routes.ORDERS_PAGE);
    } else {
      Get.toNamed(Routes.MAIN);
    }
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) {
        return;
      } else {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher',
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }

  Future initLocalNotifications(int userId) async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (notificationResponse) {
        final payload = notificationResponse.payload;
        final message = RemoteMessage.fromMap(jsonDecode(payload!));
        handleMessage(message);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
    Get.find<OrdersPageController>().getOrderedProductsForUser(userId);
    Get.find<OrdersPageController>().update();
  }

  Future<void> initNotifications(int currentUserId) async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    debugPrint("Token $fCMToken");
    LocalStorage.setFcmToken(fCMToken ?? 'No Token');
    initPushNotifications();
    initLocalNotifications(currentUserId);
    Get.put(OrdersPageController()).getOrderedProductsForUser(currentUserId);
  }
}
// f0q1fwW0TYWV4w0Clopa52:APA91bFiATnHR3i5bDEcEfTImGqM2EbRSCNsDmkWmOweO5-UYZ2FpUXmWeTg21R7v_-Yx15_fj2q-KjULKc0M83HBusHB6E-O5Z70C4q_2BdQq6gvlpM_klw5sF9wS2BCqSc7r0IU8PO