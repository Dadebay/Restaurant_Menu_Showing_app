import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/contants/cards/home_page_product_card.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/widgets.dart';

import '../controllers/cart_page_controller.dart';

class CartPageView extends GetView<CartPageController> {
  CartPageView({super.key});
  CartPageController cartPageController = Get.put(CartPageController());

  @override
  Widget build(BuildContext context) {
    bool sizeValue = Get.size.width >= 800 ? true : false;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              return cartPageController.cartList.isEmpty
                  ? emptyCart()
                  : ListView.builder(
                      itemCount: cartPageController.cartList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CartCard(
                          sizeValue: sizeValue,
                          index: index,
                          list: cartPageController.cartList,
                        );
                      },
                    );
            }),
          ),
          Obx(() {
            double sumPrice = 0.0;
            for (var element in cartPageController.cartList) {
              sumPrice += double.parse(element['price'].toString()) * element['quantity'];
            }
            sumPrice = sumPrice * (1 + 10 / 100);

            return cartPageController.cartList.isEmpty
                ? const SizedBox.shrink()
                : Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    width: Get.size.width,
                    decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.white, width: 1), borderRadius: borderRadius10),
                    child: Wrap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'service_for'.tr,
                              style: const TextStyle(fontFamily: gilroySemiBold, color: Colors.black, fontSize: 20),
                            ),
                            const Text("10%", style: TextStyle(fontFamily: gilroySemiBold, color: Colors.black, fontSize: 20)),
                          ],
                        ),
                        Container(
                          height: 1,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          color: Colors.black,
                          width: Get.size.width,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${'sum'.tr} : ',
                              style: const TextStyle(fontFamily: gilroySemiBold, color: Colors.black, fontSize: 20),
                            ),
                            Text("${sumPrice.toStringAsFixed(1)} TMT ", style: const TextStyle(fontFamily: gilroySemiBold, color: Colors.black, fontSize: 20)),
                          ],
                        ),
                      ],
                    ));
          }),
          Obx(() {
            return cartPageController.cartList.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        cartPageController.isOrderAdded.value = !cartPageController.isOrderAdded.value;
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: cartPageController.isOrderAdded.value ? Colors.green : Colors.black,
                          borderRadius: borderRadius10,
                        ),
                        child: Text(
                          cartPageController.isOrderAdded.value ? 'order_status_wait'.tr : 'order'.tr, // Anahtar eklendi
                          style: const TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 20),
                        ),
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}
