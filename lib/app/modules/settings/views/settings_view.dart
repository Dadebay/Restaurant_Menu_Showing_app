import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menu_managament_app/app/modules/category/views/add_category.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/home/views/add_banner.dart';
import 'package:menu_managament_app/app/modules/settings/views/add_product.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/custom_app_bar.dart';
import 'package:menu_managament_app/contants/widgets.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  HomeController homeController = Get.put(HomeController());
  GetStorage storage = GetStorage();

  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: "settings"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => const AddCategoryView());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, shape: const RoundedRectangleBorder(borderRadius: borderRadius10)),
                  child: const Text(
                    "Kategoriýa goş",
                    style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 18),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, shape: const RoundedRectangleBorder(borderRadius: borderRadius10)),
                    onPressed: () {
                      if (homeController.categoryList.isEmpty) {
                        showSnackBar('errorTitle', "Kategoriya goşuň", Colors.red);
                      } else {
                        Get.to(() => const AddProduct());
                      }
                    },
                    child: const Text(
                      "Haryt goş",
                      style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 18),
                    )),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, shape: const RoundedRectangleBorder(borderRadius: borderRadius10)),
                  onPressed: () {
                    Get.to(() => const AddBannerView());
                  },
                  child: const Text(
                    "Reklama goş",
                    style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 18),
                  )),
            ],
          ),
        ));
  }
}
