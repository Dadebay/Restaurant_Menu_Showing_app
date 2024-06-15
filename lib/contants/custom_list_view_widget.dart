import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/contants/cards/home_page_product_card.dart';
import 'package:menu_managament_app/contants/widgets.dart';

class CustomListViewWidget extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());
  final String name;
  final List productsList;
  CustomListViewWidget({super.key, required this.name, required this.productsList});

  @override
  Widget build(BuildContext context) {
    bool sizeValue = Get.size.width > 800 ? true : false;
    return productsList.isEmpty
        ? const SizedBox.shrink()
        : Container(
            height: 370,
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                NameWidget(name: name, list: productsList),
                Expanded(
                  child: ListView.builder(
                    itemCount: productsList.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HomePageProductCard(
                        sizeValue: sizeValue,
                        index: index,
                        list: productsList,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
