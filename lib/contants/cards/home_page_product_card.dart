import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/productProfil/views/product_profil_view.dart';
import 'package:menu_managament_app/contants/constants.dart';

class HomePageProductCard extends StatelessWidget {
  final bool sizeValue;
  final int index;
  HomeController homeController = Get.put(HomeController());

  HomePageProductCard({super.key, required this.sizeValue, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductProfilView(
              productName: homeController.productsList[index]['name'],
              iamges: homeController.productsList[index]['images'],
              description: homeController.productsList[index]['description'],
              price: homeController.productsList[index]['price'],
              categoryName: homeController.productsList[index]['categoryName'],
              productID: homeController.productsList[index]['id'] ?? "",
            ));
      },
      child: Container(
        width: Get.size.width / 4,
        decoration: BoxDecoration(color: Colors.white, borderRadius: sizeValue ? borderRadius40 : borderRadius20, boxShadow: [BoxShadow(color: Colors.grey.shade200, spreadRadius: 5, blurRadius: 5)]),
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: borderRadius20,
                child: Image.file(
                  File(homeController.productsList[index]['images'][0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homeController.productsList[index]['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 10.sp),
                  ),
                  Text(
                    "${homeController.productsList[index]['categoryName']}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontFamily: gilroyMedium, fontSize: 8.sp),
                  ),
                  Text(
                    "${homeController.productsList[index]['price']} TMT",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 9.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
