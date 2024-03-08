import 'package:gearhaven/app/utils/localStorage.dart';
import 'package:gearhaven/app/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await LocalStorage.init();
  runApp(
    GetMaterialApp(
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
  );
}
