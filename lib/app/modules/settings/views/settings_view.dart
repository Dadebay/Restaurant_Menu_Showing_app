import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menu_managament_app/app/modules/category/views/add_category.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/home/views/add_banner.dart';
import 'package:menu_managament_app/app/modules/settings/views/add_product.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  HomeController homeController = Get.put(HomeController());
  GetStorage storage = GetStorage();

  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SettingsView'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const AddCategoryView());
                },
                child: const Text("Add category")),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const AddProduct());
                },
                child: const Text("Add products")),
            ElevatedButton(
                onPressed: () {
                  homeController.productsList.clear();
                  storage.write('productsList', homeController.productsList);
                },
                child: const Text("Clear products")),
            ElevatedButton(
                onPressed: () {
                  homeController.categoryList.clear();
                  storage.write('categoryList', homeController.categoryList);

                  // Get.to(() => const AddProduct());
                },
                child: const Text("Clear categoryList")),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const AddBannerView());
                },
                child: const Text("Add banner")),
          ],
        ));
  }
}
