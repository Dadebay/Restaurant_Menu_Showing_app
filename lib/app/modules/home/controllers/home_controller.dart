import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_managament_app/contants/widgets.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  RxList categoryList = [].obs;
  RxList productsList = [].obs;
  RxBool agreeButton = false.obs;
  GetStorage storage = GetStorage();
  addCategory({required String name, required String image, required int productCount}) {
    var uuid = const Uuid();
    categoryList.add({'id': uuid.v1(), 'name': name, 'image': image, 'productCount': productCount, 'products': []});
    storage.write('categoryList', categoryList);
    print(categoryList);
    showSnackBar("Success", "Category Addeed", Colors.green);
  }

  addProduct({required String productName, required List images, required String price, required String description, required String categoryID}) {
    String categoryName = "";
    for (var element in categoryList) {
      if (element['id'] == categoryID) {
        categoryName = element['name'];
        element['productCount'] = int.parse(element['productCount'].toString()) + 1;
      }
    }
    List tryList = [];
    for (var element in images) {
      tryList.add(element.path);
    }
    var uuid = const Uuid();

    print(categoryName);
    print(categoryList);
    productsList.add({
      'id': uuid.v4(),
      'name': productName,
      'images': tryList,
      'price': price,
      'description': description,
      'categoryID': categoryID,
      'categoryName': categoryName,
    });
    print(productsList);
    storage.write('categoryList', categoryList);
    storage.write('productsList', productsList);
    showSnackBar("Success", "Added products", Colors.green);
  }

  readProductsList() {
    List list = storage.read('productsList') ?? [].obs;
    productsList.addAll(list);
  }

  readCatgoryList() {
    List list = storage.read('categoryList') ?? [].obs;
    categoryList.addAll(list);
  }
}
