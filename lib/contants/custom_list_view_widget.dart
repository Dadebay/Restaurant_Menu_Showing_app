import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/contants/cards/product_card.dart';

class CustomGridViewWidget extends StatelessWidget {
  final String categoryID;
  final List productsList;
  const CustomGridViewWidget({super.key, required this.categoryID, required this.productsList});

  @override
  Widget build(BuildContext context) {
    bool sizeValue = Get.size.width >= 800 ? true : false;
    return productsList.isEmpty
        ? const SizedBox.shrink()
        : GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: sizeValue ? 4 : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8, // Adjust for your card proportions
            ),
            itemCount: productsList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return HomePageProductCard(
                sizeValue: sizeValue,
                index: index,
                list: productsList,
              );
            },
          );
  }
}
