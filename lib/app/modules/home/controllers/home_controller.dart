import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menu_managament_app/contants/widgets.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  RxList categoryList = [].obs;
  RxList bannerList = [].obs;
  RxInt bannerDotsIndex = 0.obs;
  RxList productsList = [].obs;
  RxBool agreeButton = false.obs;
  GetStorage storage = GetStorage();
  addCategory({required String name, required String image, required int productCount}) {
    var uuid = const Uuid();
    categoryList.add({'id': uuid.v1(), 'name': name, 'image': image, 'productCount': productCount, 'products': []});
    storage.write('categoryList', categoryList);
    showSnackBar("Goşuldy", "Kategoriýa goşuldy", Colors.green);
  }

  addProduct({required String productName, required List images, required String price, required String description, required String categoryID}) {
    String categoryName = "";
    List tryList = [];
    for (var element in images) {
      tryList.add(element.path);
    }
    var uuid = const Uuid();
    String id = uuid.v4();
    for (var element in categoryList) {
      if (element['id'] == categoryID) {
        categoryName = element['name'];
        element['productCount'] = int.parse(element['productCount'].toString()) + 1;
        element['products'].add({'id': id, 'name': productName, 'images': tryList, 'price': price, 'description': description, 'categoryID': categoryID, 'categoryName': categoryName});
      }
    }

    productsList.add({'id': id, 'name': productName, 'images': tryList, 'price': price, 'description': description, 'categoryID': categoryID, 'categoryName': categoryName});

    storage.write('categoryList', categoryList);
    storage.write('productsList', productsList);
    showSnackBar("Goşuldy", "Haryt goşuldy", Colors.green);
  }

  addBanner({required String name, required String image}) {
    var uuid = const Uuid();
    bannerList.add({'id': uuid.v1(), 'name': name, 'image': image});
    storage.write('bannerList', bannerList);

    showSnackBar("Goşuldy", "Reklama goşuldy", Colors.green);
  }

  deleteCategory(String id) {
    productsList.removeWhere((element) => element['categoryID'] == id);
    categoryList.removeWhere((element) => element['id'] == id);
    storage.write('categoryList', categoryList);
    storage.write('productsList', productsList);
    showSnackBar("Pozuldy", "Kategoriya pozuldy", Colors.red);
  }

  deleteBanner(String path) {
    bannerList.removeWhere((element) => element['image'] == path);
    storage.write('bannerList', bannerList);

    showSnackBar("Pozuldy", "Reklama pozuldy", Colors.red);
  }

  readProductsList() {
    List list = storage.read('productsList') ?? [].obs;
    productsList.addAll(list);
  }

  readBannerList() {
    List list = storage.read('bannerList') ?? [].obs;
    bannerList.addAll(list);
  }

  readCatgoryList() {
    List list = storage.read('categoryList') ?? [].obs;
    categoryList.addAll(list);
  }
}
