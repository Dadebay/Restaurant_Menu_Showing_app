import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/widgets.dart';

class DeleteCategoryView extends StatefulWidget {
  const DeleteCategoryView({super.key});

  @override
  State<DeleteCategoryView> createState() => _DeleteCategoryViewState();
}

class _DeleteCategoryViewState extends State<DeleteCategoryView> {
  final HomeController _homeController = Get.find();
  int _selectedIndex = -1;

  void _deleteCategory() {
    if (_selectedIndex == -1) {
      showSnackBar('errorTitle'.tr, 'select_category'.tr, Colors.red);
      return;
    }

    _homeController.deleteCategory(_homeController.categoryList[_selectedIndex]['id']);
    setState(() {
      _selectedIndex = -1;
    });
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            color: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              IconlyLight.arrowLeftCircle,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'delete_category'.tr,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: gilroySemiBold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "select_category".tr,
                style: const TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 20),
              ),
            ),
            _categories(),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                    onPressed: _deleteCategory,
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, shape: const RoundedRectangleBorder(borderRadius: borderRadius10)),
                    child: Text("delete".tr, style: const TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 18)))),
          ],
        ),
      ),
    );
  }

  Obx _categories() {
    return Obx(() {
      return SizedBox(
        height: 70,
        child: ListView.builder(
          itemCount: _homeController.categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: _selectedIndex == index ? kPrimaryColor : Colors.white, borderRadius: borderRadius15, boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 3, spreadRadius: 3)]),
                child: Text(
                  _homeController.categoryList[index]['name'],
                  style: TextStyle(color: _selectedIndex == index ? Colors.white : Colors.black, fontFamily: _selectedIndex == index ? gilroySemiBold : gilroyRegular, fontSize: 18),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
