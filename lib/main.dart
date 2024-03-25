import 'package:gearhaven/app/data/services/firebase_api.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:gearhaven/app/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gearhaven/firebase_options.dart';

import 'app/routes/app_pages.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalStorage.init();
  int userId = LocalStorage.getUserId() ?? 0;
  await FirebaseApi().initNotifications(userId);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    KhaltiScope(
      publicKey: "test_public_key_79b4da0051e24e1e8a2054b2b64aaa79",
      builder: (context, navigatorKey) => GetMaterialApp(
        navigatorKey: navigatorKey,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ne', 'NP'),
        ],
        localizationsDelegates: const [
          KhaltiLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        title: "GearHaven",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        defaultTransition: Transition.cupertino,
        theme: lightModeTheme,
        darkTheme: darkModeTheme,
        // home: Builder(
        //   builder: (context) {
        //     final controller = Get.put(MainController());
        //     ever(
        //       controller.isDarkMode,
        //       (callback) {
        //         var theme =
        //             controller.isDarkMode.value ? darkModeTheme : lightModeTheme;
        //         Get.changeTheme(theme);
        //       },
        //     );
        //     return const Text('');
        //   },
        // ),
      ),
    ),
  );
}
