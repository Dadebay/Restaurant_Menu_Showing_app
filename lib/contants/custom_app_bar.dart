// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors, avoid_implementing_value_types

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/cartPage/controllers/cart_page_controller.dart';
import 'package:menu_managament_app/contants/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final bool backArrow;
  final bool? centerTitle;
  final Widget? icon;
  final bool actionIcon;
  final String name;

  CustomAppBar({required this.backArrow, required this.actionIcon, required this.name, this.icon, this.centerTitle, super.key});

  @override
  Widget get child => Text('ad');

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 1);
  CartPageController cartPageController = Get.put(CartPageController());
  @override
  Widget build(BuildContext context) {
    final double sizeWidth = MediaQuery.of(context).size.width;
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0.0,
      centerTitle: centerTitle,
      leadingWidth: centerTitle == true ? 40.0 : 0.0,
      leading: backArrow
          ? Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconButton(
                color: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(
                  IconlyLight.arrowLeftCircle,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  Get.back();
                  cartPageController.refreshCardList();
                },
              ),
            )
          : SizedBox.shrink(),
      actions: [if (actionIcon) Padding(padding: const EdgeInsets.only(right: 5), child: icon) else SizedBox.shrink()],
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Text(
        name.tr,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontFamily: gilroySemiBold,
          fontSize: sizeWidth > 800 ? 35 : 22,
        ),
      ),
    );
  }
}
