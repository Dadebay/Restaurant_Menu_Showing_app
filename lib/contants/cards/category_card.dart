import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/showAllProducts/views/show_all_products_view.dart';
import 'package:menu_managament_app/contants/constants.dart';

class CategoryCard extends StatelessWidget {
  final int index;
  HomeController homeController = Get.put(HomeController());

  CategoryCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ShowAllProductsView(
              categoryID: homeController.categoryList[index]['id'],
              name: homeController.categoryList[index]['name'],
              list: homeController.categoryList[index]['products'],
            ));
      },
      child: Container(
        width: Get.size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(50), topLeft: Radius.circular(50)),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 7, blurRadius: 7)]),
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(50)),
                child: Image.file(
                  width: Get.size.width,
                  File(homeController.categoryList[index]['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homeController.categoryList[index]['name'],
                    style: const TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 20),
                  ),
                  Text(
                    "Nahar sany : ${homeController.categoryList[index]['productCount']}",
                    style: const TextStyle(color: Colors.grey, fontFamily: gilroyMedium, fontSize: 16),
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
