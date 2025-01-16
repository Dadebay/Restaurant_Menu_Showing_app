import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/contants/widgets.dart';

class CartPageController extends GetxController {
  RxList cartList = [].obs;
  final RxBool isOrderAdded = false.obs;

  addCartList({required String productID, required int quantity}) {
    HomeController homeController = Get.put(HomeController());
    for (var element in homeController.productsList) {
      if (element['id'].toString() == productID) {
        cartList.add({
          'id': element['id'],
          'name': element['name'],
          'quantity': quantity,
          'images': element['images'],
          'price': element['price'],
          'description': element['description'],
          'categoryID': element['categoryID'],
          'categoryName': element['categoryName'],
        });
      }
    }
    showSnackBar("product_added", "addedSubtitle", Colors.green);
  }

  refreshCardList() {
    cartList.refresh();
  }

  minusCard({required String productID}) {
    bool value = false;
    for (var element in cartList) {
      if (element['id'] == productID) {
        if (element['quantity'] - 1 == 0) {
          value = true;
          element['quantity'] = element['quantity'] - 1;
        } else {
          element['quantity'] = element['quantity'] - 1;
        }
      }
    }
    if (value) {
      cartList.removeWhere((element) => element['quantity'] == 0);
    }

    cartList.refresh();
    if (cartList.isEmpty) {
      isOrderAdded.value = false;
    }
  }

  plusCard({required String productID}) {
    for (var element in cartList) {
      if (element['id'] == productID) {
        element['quantity'] = element['quantity'] + 1;
      }
    }
    cartList.refresh();
  }
}
