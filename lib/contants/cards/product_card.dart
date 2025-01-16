import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/cartPage/controllers/cart_page_controller.dart';
import 'package:menu_managament_app/app/modules/productProfil/views/product_profil_view.dart';
import 'package:menu_managament_app/contants/constants.dart';

class HomePageProductCard extends StatefulWidget {
  const HomePageProductCard({
    super.key,
    required this.sizeValue,
    required this.index,
    required this.list,
  });

  final bool sizeValue;
  final int index;
  final List list;

  @override
  State<HomePageProductCard> createState() => _HomePageProductCardState();
}

class _HomePageProductCardState extends State<HomePageProductCard> {
  bool _addCart = false;
  final CartPageController _cartPageController = Get.find();

  @override
  void initState() {
    super.initState();
    _checkCartStatus();
  }

  void _checkCartStatus() {
    for (final element in _cartPageController.cartList) {
      if (element['id'] == widget.list[widget.index]['id']) {
        _addCart = true;
        break;
      }
    }
  }

  void _addToCart() {
    setState(() {
      _addCart = true;
    });
    _cartPageController.addCartList(productID: widget.list[widget.index]['id'], quantity: 1);
  }

  void _removeFromCart() {
    setState(() {
      _addCart = false;
    });
    _cartPageController.minusCard(productID: widget.list[widget.index]['id']);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.list[widget.index]['images']);
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductProfilView(
              productName: widget.list[widget.index]['name'],
              images: widget.list[widget.index]['images'],
              description: widget.list[widget.index]['description'],
              price: widget.list[widget.index]['price'],
              categoryName: widget.list[widget.index]['categoryName'],
              productID: widget.list[widget.index]['id'] ?? "",
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
                child: widget.list[widget.index]['images'].isNotEmpty
                    ? Image.file(
                        File(widget.list[widget.index]['images'][0]),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Text(
                    widget.list[widget.index]['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black87, fontFamily: gilroyBold, fontSize: 17.sp),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        '${widget.list[widget.index]['price']} TMT',
                        style: TextStyle(fontFamily: gilroySemiBold, color: Colors.black54, fontSize: 15.sp),
                      ),
                    ),
                    Obx(() {
                      _checkCartStatus();
                      return _addCart ? _removeCartButton() : _addToCartButton();
                    }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _addToCartButton() {
    bool sizeValue = Get.size.width >= 800 ? true : false;
    return GestureDetector(
      onTap: _addToCart,
      child: Container(
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: const BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
        child: Icon(CupertinoIcons.add, color: Colors.white, size: 20.sp),
      ),
    );
  }

  Widget _removeCartButton() {
    bool sizeValue = Get.size.width >= 800 ? true : false;
    return GestureDetector(
      onTap: _removeFromCart,
      child: Container(
          height: 30.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: const BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
          child: Icon(CupertinoIcons.cart_badge_minus, color: Colors.white, size: 20.sp)),
    );
  }
}
