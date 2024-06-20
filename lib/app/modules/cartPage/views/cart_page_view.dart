import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:menu_managament_app/contants/cards/home_page_product_card.dart';
import 'package:menu_managament_app/contants/widgets.dart';

import '../controllers/cart_page_controller.dart';

class CartPageView extends GetView<CartPageController> {
  CartPageView({super.key});
  CartPageController cartPageController = Get.put(CartPageController());
  @override
  Widget build(BuildContext context) {
    bool sizeValue = Get.size.width >= 800 ? true : false;

    return Obx(() {
      return cartPageController.cartList.isEmpty
          ? emptyCart()
          : ListView.builder(
              itemCount: cartPageController.cartList.length,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return CartCard(
                  sizeValue: sizeValue,
                  index: index,
                  list: cartPageController.cartList,
                );
              },
            );
    });
  }
}
