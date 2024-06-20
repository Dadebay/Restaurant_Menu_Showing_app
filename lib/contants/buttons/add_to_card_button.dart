import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/cartPage/controllers/cart_page_controller.dart';
import 'package:menu_managament_app/contants/constants.dart';

class AddToCardButton extends StatefulWidget {
  const AddToCardButton({super.key, required this.productID, required this.productProfil, required this.cartPage});
  final String productID;
  final bool productProfil;
  final bool cartPage;
  @override
  State<AddToCardButton> createState() => _AddToCardButtonState();
}

class _AddToCardButtonState extends State<AddToCardButton> {
  bool addCart = false;
  int quantity = 0;
  CartPageController cartPageController = Get.put(CartPageController());
  dynamic changeCartCount2() {
    for (final element in cartPageController.cartList) {
      if (element['id'] == widget.productID) {
        addCart = true;
        quantity = element['quantity'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      changeCartCount2();

      return addCart
          ? widget.cartPage
              ? numberPartCartPage()
              : numberPart()
          : textPart();
    });
  }

  GestureDetector textPart() {
    bool sizeValue = Get.size.width >= 800 ? true : false;

    return GestureDetector(
      onTap: () {
        addCart = !addCart;
        quantity += 1;
        cartPageController.addCartList(productID: widget.productID, quantity: quantity);
        setState(() {});
      },
      child: Container(
          width: Get.size.width,
          height: widget.productProfil ? 50 : 40,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: widget.productProfil ? 20 : 8, left: widget.productProfil ? 10 : 8, right: widget.productProfil ? 10 : 8),
          padding: EdgeInsets.symmetric(vertical: sizeValue ? 0 : 5.h, horizontal: widget.productProfil ? 16.w : 8.w),
          decoration: BoxDecoration(color: kPrimaryColor, borderRadius: widget.productProfil ? borderRadius10 : borderRadius10),
          child: Text(
            "addCart".tr,
            style: TextStyle(
                color: Colors.black,
                fontFamily: gilroySemiBold,
                fontSize: widget.productProfil
                    ? 24
                    : sizeValue
                        ? 18
                        : 16),
          )),
    );
  }

  Container numberPartCartPage() {
    bool sizeValue = Get.size.width >= 800 ? true : false;

    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              quantity--;

              if (quantity == 0) {
                quantity = 0;
                addCart = false;
              }
              cartPageController.minusCard(productID: widget.productID);
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(color: kPrimaryColor, borderRadius: borderRadius10),
              child: const Icon(CupertinoIcons.minus, color: Colors.white, size: 28),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '$quantity',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: sizeValue ? 24 : 18),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              quantity++;
              cartPageController.plusCard(productID: widget.productID);
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(color: kPrimaryColor, borderRadius: borderRadius10),
              child: const Icon(CupertinoIcons.add, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }

  Container numberPart() {
    bool sizeValue = Get.size.width >= 800 ? true : false;

    return Container(
      margin: EdgeInsets.only(bottom: widget.productProfil ? 20 : 8, left: widget.productProfil ? 10 : 8, right: widget.productProfil ? 10 : 8),
      decoration: BoxDecoration(
        borderRadius: widget.productProfil ? borderRadius10 : BorderRadius.circular(0),
        color: Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                quantity--;
                if (quantity == 0) {
                  quantity = 0;
                  addCart = false;
                }
                cartPageController.minusCard(productID: widget.productID);
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: sizeValue ? 6 : 4, horizontal: 8),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: borderRadius10,
                ),
                child: Icon(CupertinoIcons.minus, color: Colors.white, size: widget.productProfil ? 36 : 28),
              ),
            ),
          ),
          Expanded(
            flex: widget.productProfil ? 8 : 3,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: gilroyBold,
                  fontSize: widget.productProfil
                      ? 25
                      : sizeValue
                          ? 24
                          : 20),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                quantity++;
                cartPageController.plusCard(productID: widget.productID);
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: sizeValue ? 6 : 4, horizontal: 8),
                decoration: const BoxDecoration(color: kPrimaryColor, borderRadius: borderRadius10),
                child: Icon(CupertinoIcons.add, color: Colors.white, size: widget.productProfil ? 36 : 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
