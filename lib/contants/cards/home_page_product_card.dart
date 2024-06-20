import 'dart:io';

import 'package:flutter/cupertino.dart';
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
              images: list[index]['images'],
              description: list[index]['description'],
              price: list[index]['price'],
              categoryName: list[index]['categoryName'],
              productID: list[index]['id'] ?? "",
            ));
      },
      child: Container(
        width: sizeValue ? 200 : 150,
        decoration: BoxDecoration(color: Colors.white, borderRadius: sizeValue ? borderRadius20 : borderRadius15, boxShadow: [BoxShadow(color: Colors.grey.shade200, spreadRadius: 5, blurRadius: 5)]),
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
                    style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: sizeValue ? 22 : 18),
                  ),
                  Text(
                    "${list[index]['price']} TMT",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: kPrimaryColor, fontFamily: gilroyBold, fontSize: sizeValue ? 20 : 16),
                  ),
                ],
              ),
            ),
            AddToCardButton(
              productID: list[index]['id'] ?? "",
              productProfil: false,
              cartPage: false,
            ),
          ],
        ),
      ),
    );
  }
}

class CartCard extends StatelessWidget {
  final bool sizeValue;
  final int index;
  final List list;
  const CartCard({super.key, required this.sizeValue, required this.index, required this.list});

  @override
  Widget build(BuildContext context) {
    bool sizeValue = Get.size.width >= 800 ? true : false;

    return GestureDetector(
      onTap: () {
        Get.to(() => ProductProfilView(
              productName: list[index]['name'],
              images: list[index]['images'],
              description: list[index]['description'],
              price: list[index]['price'],
              categoryName: list[index]['categoryName'],
              productID: list[index]['id'] ?? "",
            ));
      },
      child: Container(
        width: Get.size.width,
        height: sizeValue ? 180 : 130,
        decoration: BoxDecoration(color: Colors.white, borderRadius: sizeValue ? borderRadius20 : borderRadius15, boxShadow: [BoxShadow(color: Colors.grey.shade200, spreadRadius: 5, blurRadius: 5)]),
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: borderRadius15,
                child: Image.file(
                  File(list[index]['images'][0]),
                  fit: BoxFit.cover,
                  width: Get.size.width,
                  height: Get.size.height,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      list[index]['name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: sizeValue ? 24 : 18),
                    ),
                    Text(
                      "${list[index]['price']} TMT",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: kPrimaryColor, fontFamily: gilroyBold, fontSize: sizeValue ? 24 : 18),
                    ),
                    Text(
                      list[index]['categoryName'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontFamily: gilroySemiBold, fontSize: sizeValue ? 22 : 16),
                    ),
                  ],
                ),
              ),
            ),
            AddToCardButton(
              productID: list[index]['id'],
              productProfil: false,
              cartPage: true,
            )
          ],
        ),
      ),
    );
  }
}
