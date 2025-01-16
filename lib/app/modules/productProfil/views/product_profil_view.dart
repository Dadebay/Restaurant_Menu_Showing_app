import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/contants/buttons/add_to_card_button.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/custom_app_bar.dart';
import 'package:menu_managament_app/contants/widgets.dart';

import '../controllers/product_profil_controller.dart';

class ProductProfilView extends GetView<ProductProfilController> {
  ProductProfilView({super.key, required this.productName, required this.productID, required this.images, required this.description, required this.price, required this.categoryName});
  final String productID;
  final String productName;
  final List images;
  final String description;
  final String price;
  final String categoryName;
  final GetStorage storage = GetStorage();
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    bool sizeValue = Get.size.width >= 800 ? true : false;

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/back_image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          CustomAppBar(
              backArrow: true,
              actionIcon: true,
              icon: IconButton(
                  onPressed: () {
                    customAlertDialog(
                        context: context,
                        title: "Pozmak",
                        subtitle: "Hakykatdanda siz haryt pozmak isleýärsiňizmi ?",
                        onYES: () {
                          homeController.productsList.removeWhere((element) => element['id'] == productID);
                          homeController.categoryList[homeController.categoryList.indexWhere((element) => element['name'] == categoryName)]['products']
                              .removeWhere((element) => element['id'] == productID);
                          homeController.categoryList[homeController.categoryList.indexWhere((element) => element['name'] == categoryName)]['productCount']--;
                          storage.write('categoryList', homeController.categoryList);
                          storage.write('productsList', homeController.productsList);
                          Get.back();
                          Get.back();
                          showSnackBar("Pozuldy", "Haryt pozuldy", Colors.red);
                        });
                  },
                  icon: const Icon(
                    IconlyLight.delete,
                    color: Colors.white,
                  )),
              name: productName,
              centerTitle: true),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  color: Colors.amber,
                  height: Get.size.height / 2.3,
                  child: CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index, count) {
                      return Image.file(
                        File(images[index]),
                        fit: BoxFit.cover,
                        height: Get.size.height,
                        width: Get.size.width,
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      autoPlay: true,
                      height: Get.size.height,
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                      autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              productName,
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: gilroyBold,
                                fontSize: sizeValue ? 28 : 25,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: Text(
                              "$price TMT",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: sizeValue ? 25 : 20),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          categoryName,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: gilroyMedium,
                            fontSize: sizeValue ? 24 : 20,
                          ),
                        ),
                      ),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        maxLines: 15,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: gilroyMedium,
                          fontSize: sizeValue ? 24 : 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AddToCardButton(
            productID: productID,
            productProfil: true,
            cartPage: false,
          ),
        ],
      ),
    ));
  }
}
