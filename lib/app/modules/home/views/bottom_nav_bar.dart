// // ignore_for_file: file_names, must_be_immutable, always_use_package_imports, avoid_void_async, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/appInfoPage/views/app_info_page_view.dart';
import 'package:menu_managament_app/app/modules/cartPage/views/cart_page_view.dart';
import 'package:menu_managament_app/app/modules/category/controllers/category_controller.dart';
import 'package:menu_managament_app/app/modules/category/views/category_view.dart';
import 'package:menu_managament_app/app/modules/search/views/search_view.dart';
import 'package:menu_managament_app/app/modules/settings/views/settings_view.dart';
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
  List pages = [const HomeView(), CategoryView(), const CartPageView(), const AppInfoPageView()];
  List names = ['home', 'category', 'order', 'appInfo'];
  CategoryController categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        backArrow: false,
        actionIcon: true,
        icon: Row(
          children: selectedIndex == 1
              ? [
                  Obx(() {
                    return IconButton(
                        onPressed: () {
                          categoryController.changeList.toggle();
                        },
                        icon: categoryController.changeList.value ? const Icon(IconlyLight.document) : const Icon(IconlyLight.category));
                  }),
                ]
              : [
                  IconButton(onPressed: () => Get.to(() => const SearchView()), icon: const Icon(IconlyLight.search)),
                  IconButton(onPressed: () => Get.to(() => SettingsView()), icon: const Icon(IconlyLight.setting))
                ],
        ),
        name: names[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 22,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: kPrimaryColor,
        useLegacyColorScheme: true,
        selectedLabelStyle: const TextStyle(fontFamily: gilroySemiBold, fontSize: 13),
        unselectedLabelStyle: const TextStyle(fontFamily: gilroyMedium, fontSize: 12),
        currentIndex: selectedIndex,
        onTap: (index) async => setState(() => selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.home),
            activeIcon: const Icon(IconlyBold.home),
            label: 'home'.tr,
            tooltip: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.category),
            activeIcon: const Icon(IconlyBold.category),
            label: 'category'.tr,
            tooltip: 'category'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.buy),
            activeIcon: const Icon(IconlyBold.buy),
            label: 'order'.tr,
            tooltip: 'order'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.infoSquare),
            activeIcon: const Icon(IconlyBold.infoSquare),
            label: 'appInfo'.tr,
            tooltip: 'appInfo'.tr,
          ),
        ],
      ),
      body: Center(
        child: pages[selectedIndex],
      ),
    );
  }
}
