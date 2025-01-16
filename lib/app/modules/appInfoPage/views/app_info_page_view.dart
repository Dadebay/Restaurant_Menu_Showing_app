import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/contants/constants.dart';

import '../controllers/app_info_page_controller.dart';

class AppInfoPageView extends GetView<AppInfoPageController> {
  const AppInfoPageView({super.key});
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
          'contactInformation'.tr,
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
      body: textPart(),
    );
  }

  Widget textPart() {
    bool sizeValue = Get.size.width >= 800 ? true : false;

    return Container(
      width: Get.size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: "contactInformation"),
          button(sizeValue, '+993-65-13-94-47', IconlyLight.call),
          button(sizeValue, '+993-62-25-33-26', IconlyLight.call),
        ],
      ),
    );
  }

  Padding button(bool sizeValue, String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: sizeValue ? 20 : 8,
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: Container(
          padding: EdgeInsets.all(sizeValue ? 15 : 10),
          margin: const EdgeInsets.only(right: 10),
          decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        label: Text(
          title,
          maxLines: 5,
          style: const TextStyle(color: Colors.black, fontFamily: gilroyBold, overflow: TextOverflow.ellipsis, fontSize: 22),
        ),
      ),
    );
  }
}
