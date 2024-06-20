import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/views/banners.dart';
import 'package:menu_managament_app/contants/custom_list_view_widget.dart';
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
    return ListView(
      children: [
        Banners(),
        Obx(() {
          return ListView.builder(
            itemCount: homeController.categoryList.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return CustomListViewWidget(
                categoryID: homeController.categoryList[index]['id'],
                name: homeController.categoryList[index]['name'],
                productsList: homeController.categoryList[index]['products'],
              );
            },
          );
        })
      ],
    );
  }
}
