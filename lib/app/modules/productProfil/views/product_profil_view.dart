import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:menu_managament_app/contants/buttons/add_to_card_button.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/custom_app_bar.dart';

import '../controllers/product_profil_controller.dart';

class ProductProfilView extends GetView<ProductProfilController> {
  const ProductProfilView({super.key, required this.productName, required this.productID, required this.iamges, required this.description, required this.price, required this.categoryName});
  final String productID;
  final String productName;
  final List iamges;
  final String description;
  final String price;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: AddToCardButton(
          productID: productID,
        ),
        appBar: CustomAppBar(backArrow: true, actionIcon: false, name: productName, centerTitle: true),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.h),
              color: Colors.red,
              height: Get.size.height / 2,
            ),
            Text(
              productName,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontFamily: gilroyBold,
                fontSize: 14.sp,
              ),
            ),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontFamily: gilroyMedium,
                fontSize: 12.sp,
              ),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              maxLines: 15,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
                fontFamily: gilroyMedium,
                fontSize: 12.sp,
              ),
            ),
          ],
        ));
  }
}
