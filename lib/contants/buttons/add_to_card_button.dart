import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/cartPage/controllers/cart_page_controller.dart';
import 'package:menu_managament_app/contants/constants.dart';

class AddToCardButton extends StatefulWidget {
  const AddToCardButton({super.key, required this.productID});
  final String productID;
  @override
  State<AddToCardButton> createState() => _AddToCardButtonState();
}

class _AddToCardButtonState extends State<AddToCardButton> {
  bool addCart = false;
  CartPageController cartPageController = Get.put(CartPageController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addCart = !addCart;
        setState(() {});
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
          decoration: const BoxDecoration(color: kPrimaryColor, borderRadius: borderRadius30),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add To Card",
                style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 10.sp),
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
}
