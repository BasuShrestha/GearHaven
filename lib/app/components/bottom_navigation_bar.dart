import 'package:gearhaven/app/utils/assets.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 75,
      backgroundColor: Theme.of(context).colorScheme.background,
      selectedIndex: 0,
      destinations: [
        NavigationDestination(
          icon: Assets.homeIcon,
          label: "Home",
        ),
        NavigationDestination(
          icon: Assets.buyIcon,
          label: "Buy",
        ),
        NavigationDestination(
          icon: Assets.sellIcon,
          label: "Sell",
        ),
        NavigationDestination(
          icon: Assets.rentIcon,
          label: "Rent",
        ),
        NavigationDestination(
          icon: Assets.profileIcon,
          label: "Profile",
        ),
      ],
    );
  }
}
