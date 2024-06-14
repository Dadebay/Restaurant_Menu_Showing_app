import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/home/views/custom_text_field.dart';
import 'package:menu_managament_app/contants/buttons/agree_button_view.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/custom_app_bar.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<XFile> imageFile = [];
  final storage = GetStorage();

  final ImagePicker imgpicker = ImagePicker();
  final HomeController homeController = Get.put(HomeController());
  Future getImage() async {
    final List<XFile> pickedFile = await imgpicker.pickMultiImage();
    imageFile = pickedFile;
    setState(() {});
  }

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  TextEditingController priceEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  int selectedIndex = -1; // Set an initial value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: "Add product"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          imageFile.isEmpty
              ? ElevatedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: const Text("get images"))
              : SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: imageFile.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(
                        File(imageFile[index].path),
                        width: 200,
                      );
                    },
                  ),
                ),
          CustomTextField(
            labelName: "Product Name",
            controller: nameEditingController,
            focusNode: focusNode,
            requestfocusNode: focusNode1,
            unFocus: true,
          ),
          Obx(() {
            return SizedBox(
              height: 70,
              child: ListView.builder(
                itemCount: homeController.categoryList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: selectedIndex == index ? Colors.red : Colors.white, borderRadius: borderRadius15, boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 3, spreadRadius: 3)]),
                      child: Text(homeController.categoryList[index]['name']),
                    ),
                  );
                },
              ),
            );
          }),
          CustomTextField(
            labelName: "Price",
            isNumber: true,
            controller: priceEditingController,
            focusNode: focusNode2,
            requestfocusNode: focusNode1,
            unFocus: true,
          ),
          CustomTextField(
            labelName: "Description ",
            maxline: 3,
            controller: descriptionEditingController,
            focusNode: focusNode1,
            requestfocusNode: focusNode2,
            unFocus: true,
          ),
          AgreeButton(
              onTap: () {
                setState(() {});

                homeController.addProduct(
                    productName: nameEditingController.text,
                    images: imageFile,
                    price: priceEditingController.text,
                    description: descriptionEditingController.text,
                    categoryID: homeController.categoryList[selectedIndex]['id']);

                nameEditingController.clear();
                priceEditingController.clear();
                descriptionEditingController.clear();
              },
              text: "Agree")
        ],
      ),
    );
  }
}
