import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: "Haryt goşmak"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          imageFile.isEmpty
              ? SizedBox(
                  height: Get.size.height / 4,
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, shape: const RoundedRectangleBorder(borderRadius: borderRadius10)),
                      onPressed: () {
                        getImage();
                      },
                      child: const Text(
                        "Surat saýla",
                        style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 18),
                      ),
                    ),
                  ),
                )
              : imagesView(),
          CustomTextField(
            labelName: "Haryt ady",
            controller: nameEditingController,
            focusNode: focusNode,
            borderRadius: true,
            requestfocusNode: focusNode1,
            unFocus: true,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Kategoriýa saýla",
              style: TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: 20),
            ),
          ),
          categoriyalar(),
          CustomTextField(
            labelName: "Haryt bahasy TMT",
            isNumber: true,
            controller: priceEditingController,
            focusNode: focusNode2,
            borderRadius: true,
            requestfocusNode: focusNode1,
            unFocus: true,
          ),
          CustomTextField(
            labelName: "Beýany ",
            maxline: 5,
            borderRadius: true,
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
                imageFile.clear();
                selectedIndex = -1;
                descriptionEditingController.clear();
              },
              text: "agree".tr)
        ],
      ),
    );
  }

  Obx categoriyalar() {
    return Obx(() {
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
                    color: selectedIndex == index ? kPrimaryColor : Colors.white, borderRadius: borderRadius15, boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 3, spreadRadius: 3)]),
                child: Text(
                  homeController.categoryList[index]['name'],
                  style: TextStyle(color: selectedIndex == index ? Colors.white : Colors.black, fontFamily: selectedIndex == index ? gilroySemiBold : gilroyRegular, fontSize: 18),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget imagesView() {
    bool sizeValue = Get.size.width >= 800 ? true : false;

    return GridView.builder(
      shrinkWrap: true,
      itemCount: imageFile.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: borderRadius10,
              child: Image.file(
                File(imageFile[index].path),
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                  onPressed: () {
                    imageFile.removeAt(index);
                    setState(() {});
                  },
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
