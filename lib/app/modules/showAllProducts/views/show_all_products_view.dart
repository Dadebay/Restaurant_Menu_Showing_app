import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:menu_managament_app/contants/cards/home_page_product_card.dart';
import 'package:menu_managament_app/contants/custom_app_bar.dart';

import '../controllers/show_all_products_controller.dart';

class ShowAllProductsView extends GetView<ShowAllProductsController> {
  const ShowAllProductsView({
    super.key,
    required this.name,
    required this.list,
  });
  final String name;
  final List list;
  @override
  Widget build(BuildContext context) {
    bool sizeValue = Get.size.width > 800 ? true : false;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: name),
        body: GridView.builder(
          itemCount: list.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: sizeValue ? 4 : 3, childAspectRatio: 3.3 / 4),
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
