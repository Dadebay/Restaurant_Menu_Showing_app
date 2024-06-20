import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/contants/cards/category_card.dart';
import 'package:menu_managament_app/contants/parallax_widget.dart';
import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  CategoryView({super.key});
  HomeController homeController = Get.put(HomeController());
  CategoryController categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    bool sizeValue = Get.size.width >= 800 ? true : false;
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
        return CategoryCard(
          index: index,
        );
      },
    );
  }
}
