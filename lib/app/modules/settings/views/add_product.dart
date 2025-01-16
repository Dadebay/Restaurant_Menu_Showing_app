import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/home/views/custom_text_field.dart';
import 'package:menu_managament_app/contants/buttons/agree_button_view.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/widgets.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<XFile> _imageFiles = [];
  final ImagePicker _imgpicker = ImagePicker();
  final HomeController _homeController = Get.find();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController = TextEditingController();
  final TextEditingController _priceEditingController = TextEditingController();
  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeDescription = FocusNode();
  final FocusNode _focusNodePrice = FocusNode();
  int _selectedIndex = -1;

  Future<void> _getImage() async {
    final List<XFile> pickedFiles = await _imgpicker.pickMultiImage(
      imageQuality: 50,
      maxHeight: 480,
      maxWidth: 640,
    );
    setState(() {
      _imageFiles = pickedFiles;
    });
  }

  void _removeImage(int index) {
    if (_imageFiles.isNotEmpty && index >= 0 && index < _imageFiles.length) {
      setState(() {
        _imageFiles.removeAt(index);
      });
    }
  }

  void _addProduct() {
    if (_imageFiles.isEmpty) {
      showSnackBar("errorTitle".tr, "select_image".tr, Colors.red);
      return;
    }
    if (_nameEditingController.text.isEmpty) {
      showSnackBar('errorTitle'.tr, 'errorEmpty'.tr, Colors.red);
      return;
    }
    if (_priceEditingController.text.isEmpty) {
      showSnackBar('errorTitle'.tr, 'errorEmpty'.tr, Colors.red);
      return;
    }
    if (_selectedIndex == -1) {
      showSnackBar('errorTitle'.tr, 'select_category'.tr, Colors.red);
      return;
    }
    setState(() {});
    _homeController.addProduct(
      productName: _nameEditingController.text,
      images: _imageFiles,
      price: _priceEditingController.text,
      description: '',
      categoryID: _homeController.categoryList[_selectedIndex]['id'],
    );

    _nameEditingController.clear();
    _priceEditingController.clear();
    _imageFiles.clear();
    _selectedIndex = -1;
    _descriptionEditingController.clear();
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _descriptionEditingController.dispose();
    _priceEditingController.dispose();
    _focusNodeName.dispose();
    _focusNodeDescription.dispose();
    _focusNodePrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'add_product'.tr,
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
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  _imageFiles.isEmpty
                      ? SizedBox(
                          height: Get.size.height / 4,
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, shape: const RoundedRectangleBorder(borderRadius: borderRadius10)),
                              onPressed: _getImage,
                              child: Text(
                                "select_image".tr,
                                style: const TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      : _imagesView(),
                  CustomTextField(
                    labelName: "product_name".tr,
                    controller: _nameEditingController,
                    focusNode: _focusNodeName,
                    borderRadius: true,
                    requestfocusNode: _focusNodeDescription,
                    unFocus: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "select_category".tr,
                      style: const TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 20),
                    ),
                  ),
                  _categories(),
                  CustomTextField(
                    labelName: "product_price".tr,
                    isNumber: true,
                    controller: _priceEditingController,
                    focusNode: _focusNodePrice,
                    borderRadius: true,
                    requestfocusNode: _focusNodeDescription,
                    unFocus: true,
                  ),
                  AgreeButton(
                    onTap: _addProduct,
                    text: "agree".tr,
                  )
                ],
              ),
            ),
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

  Widget _imagesView() {
    bool sizeValue = Get.size.width >= 800 ? true : false;

    return GridView.builder(
      shrinkWrap: true,
      itemCount: _imageFiles.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: borderRadius10,
              child: Image.file(
                File(_imageFiles[index].path),
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                  onPressed: () => _removeImage(index),
                  icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(
                        CupertinoIcons.xmark_circle,
                        color: Colors.red,
                      ))),
            ),
          ],
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: sizeValue ? 5 : 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
    );
  }
}
