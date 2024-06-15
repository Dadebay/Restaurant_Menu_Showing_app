import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/productProfil/views/product_profil_view.dart';
import 'package:menu_managament_app/contants/buttons/add_to_card_button.dart';
import 'package:menu_managament_app/contants/constants.dart';

class HomePageProductCard extends StatelessWidget {
  final bool sizeValue;
  final int index;
  final List list;
  const HomePageProductCard({super.key, required this.sizeValue, required this.index, required this.list});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductProfilView(
              productName: list[index]['name'],
              iamges: list[index]['images'],
              description: list[index]['description'],
              price: list[index]['price'],
              categoryName: list[index]['categoryName'],
              productID: list[index]['id'] ?? "",
            ));
      },
      child: Container(
        width: Get.size.width / 3.8,
        decoration: BoxDecoration(color: Colors.white, borderRadius: sizeValue ? borderRadius40 : borderRadius15, boxShadow: [BoxShadow(color: Colors.grey.shade200, spreadRadius: 5, blurRadius: 5)]),
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: Get.size.width,
                child: ClipRRect(
                  borderRadius: borderRadius15,
                  child: Image.file(
                    File(list[index]['images'][0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list[index]['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 10.sp),
                  ),
                  Text(
                    "${list[index]['price']} TMT",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: kPrimaryColor, fontFamily: gilroySemiBold, fontSize: 9.sp),
                  ),
                ],
              ),
            ),
            AddToCardButton(
              productID: list[index]['id'] ?? "",
              productProfil: false,
            ),
          ],
        ),
      ),
    );
  }
}
