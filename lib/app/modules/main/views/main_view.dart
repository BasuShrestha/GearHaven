import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //var controller = Get.find<MainController>();
    Get.put(MainController());
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).colorScheme.primary,
        //   title: Text(
        //     "Switching themes",
        //     style: TextStyle(
        //       fontSize: 20,
        //       fontWeight: FontWeight.bold,
        //       color: Theme.of(context).colorScheme.tertiary,
        //     ),
        //   ),
        //   centerTitle: true,
        //   actions: [
        //     Padding(
        //       padding: EdgeInsets.only(right: 10),
        //       child: GestureDetector(
        //         child: Icon(
        //           CupertinoIcons.moon_fill,
        //           color: Theme.of(context).colorScheme.tertiary,
        //         ),
        //         onTap: () {
        //           controller.toggleTheme();
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        body: Obx(() => controller.pages[controller.currentPageIndex.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.shifting,
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            showUnselectedLabels: true,
            fixedColor: Theme.of(context).colorScheme.tertiary,
            backgroundColor: Theme.of(context).colorScheme.primary,
            unselectedFontSize: 15,
            iconSize: 35,
            selectedFontSize: 15,
            currentIndex: controller.currentPageIndex.value,
            onTap: (value) {
              controller.onDestinationSelected(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                activeIcon: Icon(Icons.shopping_bag),
                label: "Orders",
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sell_outlined),
                activeIcon: Icon(Icons.sell),
                label: "Sell",
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.handshake_outlined),
                activeIcon: Icon(Icons.handshake),
                label: "Rent",
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.person_2_outlined),
              //   activeIcon: Icon(Icons.person_2),
              //   label: "Profile",
              //   backgroundColor: Theme.of(context).colorScheme.primary,
              // ),
            ],
          ),
          // NavigationBar(
          //   height: 70,
          //   elevation: 0,
          //   indicatorColor: Colors.white,
          //   backgroundColor: Theme.of(context).colorScheme.primary,
          //   selectedIndex: controller.currentPageIndex.value,
          //   onDestinationSelected: (value) {
          //     controller.onDestinationSelected(value);
          //   },
          //   destinations: [
          //     NavigationDestination(
          //       icon: Icon(Icons.home_outlined),
          //       label: "Home",
          //     ),
          //     NavigationDestination(
          //       icon: Icon(Icons.shopping_bag_outlined),
          //       label: "Buy",
          //     ),
          //     NavigationDestination(
          //       icon: Icon(Icons.sell_outlined),
          //       label: "Sell",
          //     ),
          //     NavigationDestination(
          //       icon: Icon(Icons.handshake_outlined),
          //       label: "Rent",
          //     ),
          //     NavigationDestination(
          //       icon: Icon(Icons.person_2_outlined),
          //       label: "Profile",
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
