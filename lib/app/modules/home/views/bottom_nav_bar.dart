// // ignore_for_file: file_names, must_be_immutable, always_use_package_imports, avoid_void_async, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/cartPage/controllers/cart_page_controller.dart';
import 'package:menu_managament_app/app/modules/cartPage/views/cart_page_view.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/custom_app_bar.dart';

import 'home_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  List pages = [
    const HomeView(),
    CartPageView(),
  ];
  List names = [
    'home',
    'order',
  ];
  CartPageController cartPageController = Get.put(CartPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/back_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            selectedIndex == 0
                ? const SizedBox.shrink()
                : CustomAppBar(
                    backArrow: false,
                    centerTitle: true,
                    actionIcon: true,
                    name: "${names[selectedIndex]}".tr,
                  ),
            Expanded(
              child: Center(
                child: pages[selectedIndex],
              ),
            ),
            bottomNavBar(),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar bottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      iconSize: 22,
      elevation: selectedIndex == 2 ? 0 : 1,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.white70,
      selectedItemColor: Colors.white,
      useLegacyColorScheme: true,
      selectedLabelStyle: const TextStyle(fontFamily: gilroySemiBold, color: Colors.white, fontSize: 13),
      unselectedLabelStyle: const TextStyle(fontFamily: gilroyMedium, color: Colors.white70, fontSize: 12),
      currentIndex: selectedIndex,
      onTap: (index) async => setState(() => selectedIndex = index),
      items: [
        BottomNavigationBarItem(
          icon: const Icon(
            IconlyLight.home,
            color: Colors.white70,
          ),
          activeIcon: const Icon(IconlyBold.home, color: Colors.white),
          label: 'home'.tr,
          tooltip: 'home'.tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(IconlyLight.buy, color: Colors.white70),
          activeIcon: const Icon(IconlyBold.buy, color: Colors.white),
          label: 'order'.tr,
          tooltip: 'order'.tr,
        ),
      ],
    );
  }
}
