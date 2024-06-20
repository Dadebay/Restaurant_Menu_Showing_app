import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/custom_app_bar.dart';
import 'package:menu_managament_app/contants/widgets.dart';

class BannerProfilView extends StatelessWidget {
  BannerProfilView({super.key, required this.image});
  final File image;
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          backArrow: true,
          centerTitle: true,
          actionIcon: true,
          icon: IconButton(
              onPressed: () {
                customAlertDialog(
                    context: context,
                    title: "Pozmak",
                    subtitle: "Hakykatdanda siz reklamany pozmak isleýärsiňizmi ? ",
                    onYES: () {
                      homeController.deleteBanner(image.path);
                      Get.back();
                    });
              },
              icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(
                    CupertinoIcons.xmark_circle,
                    color: Colors.red,
                  ))),
          name: "Reklama "),
      body: Container(
        padding: const EdgeInsets.all(14.0),
        child: ClipRRect(
          borderRadius: borderRadius10,
          child: Image.file(
            image,
            width: Get.size.width / 1,
            height: Get.size.height / 4,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
