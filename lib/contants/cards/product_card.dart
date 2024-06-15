import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/showAllProducts/views/show_all_products_view.dart';
import 'package:menu_managament_app/contants/constants.dart';

class ProductCard extends StatelessWidget {
  final int index;
  HomeController homeController = Get.put(HomeController());

  ProductCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ShowAllProductsView(name: homeController.productsList[index]['name'], list: homeController.productsList));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(50), topLeft: Radius.circular(50)),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 7, blurRadius: 7)]),
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: Get.size.width,
                height: Get.size.height,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(50)),
                  child: Image.file(
                    File(homeController.productsList[index]['images'][0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
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
