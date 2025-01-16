import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/productProfil/views/product_profil_view.dart';
import 'package:menu_managament_app/contants/buttons/add_to_card_button.dart';
import 'package:menu_managament_app/contants/constants.dart';

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
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 7,
              blurRadius: 7,
            )
          ],
          borderRadius: sizeValue ? borderRadius30 : borderRadius25,
        ),
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: borderRadius25,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 20),
                      child: Text(
                        list[index]['name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: sizeValue ? 26 : 22),
                      ),
                    ),
                    Text(
                      "${list[index]['price']} TMT",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: kPrimaryColor, fontFamily: gilroyMedium, fontSize: sizeValue ? 26 : 18),
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
