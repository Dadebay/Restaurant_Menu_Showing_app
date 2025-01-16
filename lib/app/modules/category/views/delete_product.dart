import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/widgets.dart';

class DeleteProductView extends StatefulWidget {
  const DeleteProductView({super.key});

  @override
  State<DeleteProductView> createState() => _DeleteProductViewState();
}

class _DeleteProductViewState extends State<DeleteProductView> {
  final HomeController _homeController = Get.find();
  final List<String> _selectedProductIds = [];

  void _deleteSelectedProducts() {
    if (_selectedProductIds.isEmpty) {
      showSnackBar('errorTitle'.tr, 'select_product'.tr, Colors.red);
      return;
    }

    for (var productID in _selectedProductIds) {
      for (var element in _homeController.categoryList) {
        if (element['products'].any((item) => item['id'] == productID)) {
          element['productCount'] = int.parse(element['productCount'].toString()) - 1;
          element['products'].removeWhere((item) => item['id'] == productID);
          _homeController.productsList.removeWhere((item) => item['id'] == productID);
          _homeController.storage.write('categoryList', _homeController.categoryList);
          _homeController.storage.write('productsList', _homeController.productsList);
          break;
        }
      }
    }
    showSnackBar("deleted".tr, "product_deleted".tr, Colors.red);

    setState(() {
      _selectedProductIds.clear();
    });
    Get.back();
  }

  void _toggleProductSelection(String productId) {
    setState(() {
      if (_selectedProductIds.contains(productId)) {
        _selectedProductIds.remove(productId);
      } else {
        _selectedProductIds.add(productId);
      }
    });
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
          'delete_product'.tr,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(
                () {
                  List allProducts = [];
                  for (var category in _homeController.categoryList) {
                    allProducts.addAll(category['products']);
                  }
                  if (allProducts.isEmpty) {
                    return Center(
                      child: Text("noProduct".tr),
                    );
                  }
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // İstediğiniz sütun sayısını ayarlayın
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: allProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = allProducts[index];
                      final isSelected = _selectedProductIds.contains(product['id']);
                      return GestureDetector(
                        onTap: () => _toggleProductSelection(product['id']),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: isSelected ? kPrimaryColor.withOpacity(0.4) : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: isSelected ? kPrimaryColor : Colors.grey.shade300)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: product['images'] != null && product['images'].isNotEmpty
                                    ? Image.file(
                                        File(product['images'][0]),
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.image_not_supported,
                                        size: 40,
                                      ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: gilroySemiBold, fontSize: 16, color: isSelected ? Colors.black : Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: _deleteSelectedProducts,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: const RoundedRectangleBorder(borderRadius: borderRadius10),
                ),
                child: Text("delete".tr, style: const TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
