// lib/app/modules/settings/views/settings_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menu_managament_app/app/modules/category/views/add_category.dart';
import 'package:menu_managament_app/app/modules/category/views/delete_Category.dart';
import 'package:menu_managament_app/app/modules/category/views/delete_product.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/settings/views/add_product.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/widgets.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  HomeController homeController = Get.put(HomeController());
  GetStorage storage = GetStorage();

  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            color: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              IconlyLight.arrowLeftCircle,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'settings'.tr,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: gilroySemiBold,
            fontSize: 22,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _buildButton(
                text: 'add_category'.tr,
                onTap: () {
                  Get.to(() => const AddCategoryView());
                },
              ),
            ),
            _buildButton(
              text: 'add_product'.tr,
              onTap: () {
                if (homeController.categoryList.isEmpty) {
                  showSnackBar('errorTitle'.tr, "add_category_first".tr, Colors.red);
                } else {
                  Get.to(() => const AddProduct());
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _buildButton(
                text: 'delete_category'.tr,
                onTap: () {
                  if (homeController.categoryList.isEmpty) {
                    showSnackBar('errorTitle'.tr, "add_category_first".tr, Colors.red);
                  } else {
                    Get.to(() => const DeleteCategoryView());
                  }
                },
              ),
            ),
            _buildButton(
              text: 'delete_product'.tr,
              onTap: () {
                if (homeController.categoryList.isEmpty) {
                  showSnackBar('errorTitle'.tr, "add_category_first".tr, Colors.red);
                } else {
                  Get.to(() => const DeleteProductView());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onTap}) {
    return Container(
        width: Get.size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: borderRadius10,
                color: kPrimaryColor,
                border: Border.all(color: Colors.white.withOpacity(.4), width: 1),
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 22),
              ),
            )));
  }
}
