import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/cartPage/controllers/cart_page_controller.dart';
import 'package:menu_managament_app/contants/constants.dart';

class AddToCardButton extends StatefulWidget {
  const AddToCardButton({super.key, required this.productID, required this.productProfil});
  final String productID;
  final bool productProfil;
  @override
  State<AddToCardButton> createState() => _AddToCardButtonState();
}

class _AddToCardButtonState extends State<AddToCardButton> {
  bool addCart = false;
  int quantity = 0;
  CartPageController cartPageController = Get.put(CartPageController());
  dynamic changeCartCount2() {
    print(cartPageController.cartList);
    for (final element in cartPageController.cartList) {
      if (element['id'] == widget.productID) {
        addCart = true;
        quantity = element['quantity'];
      }
    }
    print(cartPageController.cartList);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      changeCartCount2();

      return addCart ? numberPart() : textPart();
    });
  }

  GestureDetector textPart() {
    return GestureDetector(
      onTap: () {
        addCart = !addCart;
        quantity += 1;
        cartPageController.addCartList(productID: widget.productID, quantity: quantity);
        setState(() {});
      },
      child: Container(
          width: Get.size.width,
          margin: EdgeInsets.only(bottom: widget.productProfil ? 20 : 8, left: widget.productProfil ? 0 : 8, right: widget.productProfil ? 0 : 8),
          padding: EdgeInsets.symmetric(vertical: widget.productProfil ? 10.h : 5.h, horizontal: widget.productProfil ? 16.w : 8.w),
          decoration: BoxDecoration(color: kPrimaryColor, borderRadius: widget.productProfil ? borderRadius30 : borderRadius10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add To Card",
                style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: widget.productProfil ? 10.sp : 8.sp),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  IconlyLight.buy,
                  color: Colors.black,
                  size: 12.sp,
                ),
              )
            ],
          )),
    );
  }

  Container numberPart() {
    return Container(
      margin: EdgeInsets.only(bottom: widget.productProfil ? 20 : 8, left: widget.productProfil ? 0 : 8, right: widget.productProfil ? 0 : 8),
      decoration: BoxDecoration(
        borderRadius: widget.productProfil ? borderRadius10 : BorderRadius.circular(0),
        color: Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                quantity--;
                if (quantity == 0) {
                  quantity = 1;
                  addCart = false;
                }
                cartPageController.minusCard(productID: widget.productID);
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: borderRadius10,
                ),
                child: Icon(CupertinoIcons.minus, color: Colors.white, size: widget.productProfil ? 28 : 28),
              ),
            ),
          ),
          Expanded(
            flex: widget.productProfil ? 8 : 2,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 12.sp),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                quantity++;
                cartPageController.plusCard(productID: widget.productID);
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                decoration: const BoxDecoration(color: kPrimaryColor, borderRadius: borderRadius10),
                child: Icon(CupertinoIcons.add, color: Colors.white, size: widget.productProfil ? 28 : 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
