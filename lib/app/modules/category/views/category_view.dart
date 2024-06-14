import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/showAllProducts/views/show_all_products_view.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/parallax_widget.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  CategoryView({super.key});
  HomeController homeController = Get.put(HomeController());
  CategoryController categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    bool sizeValue = Get.size.width > 800 ? true : false;
    return Obx(() {
      return categoryController.changeList.value ? const Parallax() : gridPage(sizeValue);
    });
  }

  GridView gridPage(bool sizeValue) {
    return GridView.builder(
      itemCount: homeController.categoryList.length,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: sizeValue ? 3 : 2),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(() => const ShowAllProductsView());
          },
          child: Container(
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
                        style: TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 12.sp),
                      ),
                      Text(
                        homeController.categoryList[index]['productCount'].toString(),
                        style: TextStyle(color: Colors.grey, fontFamily: gilroySemiBold, fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
