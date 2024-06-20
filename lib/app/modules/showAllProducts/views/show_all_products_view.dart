import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/contants/cards/home_page_product_card.dart';
import 'package:menu_managament_app/contants/custom_app_bar.dart';
import 'package:menu_managament_app/contants/widgets.dart';

import '../controllers/show_all_products_controller.dart';

class ShowAllProductsView extends GetView<ShowAllProductsController> {
  ShowAllProductsView({
    super.key,
    required this.categoryID,
    required this.name,
    required this.list,
  });
  final String name;
  final List list;
  final String categoryID;
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    bool sizeValue = Get.size.width >= 800 ? true : false;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            backArrow: true,
            centerTitle: true,
            actionIcon: true,
            icon: IconButton(
                onPressed: () {
                  customAlertDialog(
                      context: context,
                      title: "Pozmak",
                      subtitle: "Hakykatdanda siz Kategoriyany pozmak isleýärsiňizmi ? ",
                      onYES: () {
                        homeController.deleteCategory(categoryID);
                        Get.back();
                      });
                },
                icon: const Icon(
                  IconlyLight.delete,
                  color: Colors.black,
                )),
            name: name == "" ? "Kategoriyalar" : name),
        body: GridView.builder(
          itemCount: list.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: sizeValue ? 3 : 2, childAspectRatio: 3 / 4.2),
          itemBuilder: (context, index) {
            return HomePageProductCard(
              sizeValue: sizeValue,
              index: index,
              list: list,
            );
          },
        ));
  }
}
