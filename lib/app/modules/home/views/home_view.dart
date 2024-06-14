import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/contants/cards/home_page_product_card.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/widgets.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    bool sizeValue = Get.size.width > 800 ? true : false;
    return Obx(() {
      return SizedBox(
        height: 350,
        child: Column(
          children: [
            NameWidget(name: homeController.categoryList[0]['name']),
            Expanded(
              child: ListView.builder(
                itemCount: homeController.productsList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return HomePageProductCard(
                    sizeValue: sizeValue,
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
