import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/home/views/custom_text_field.dart';
import 'package:menu_managament_app/contants/buttons/agree_button_view.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/custom_app_bar.dart';
import 'package:menu_managament_app/contants/widgets.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({super.key});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  File? imageFile;

  final ImagePicker imgpicker = ImagePicker();
  final HomeController homeController = Get.put(HomeController());
  Future getImage() async {
    try {
      final XFile? pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        setState(() {});
      } else {
        showSnackBar("errorTitle", "Surat saýlamadyňyz", Colors.red);
      }
    } catch (e) {
      showSnackBar("errorTitle", "error", Colors.red);
    }
  }

  TextEditingController nameEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: "Kategoriýa goşmak"),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          imageFile == null
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
              : Stack(
                  children: [
                    ClipRRect(
                      borderRadius: borderRadius10,
                      child: Image.file(
                        imageFile!,
                        width: Get.size.width / 1,
                        height: Get.size.height / 4,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                          onPressed: () {
                            imageFile = null;
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
                ),
          CustomTextField(
            labelName: "Kategoriýa ady",
            controller: nameEditingController,
            focusNode: focusNode,
            borderRadius: true,
            requestfocusNode: focusNode,
            unFocus: true,
          ),
          AgreeButton(
              onTap: () {
                homeController.addCategory(name: nameEditingController.text, image: imageFile!.path, productCount: 0);
                File? testFile;

                nameEditingController.clear();
                imageFile = testFile;
                setState(() {});
              },
              text: "agree".tr)
        ],
      ),
    );
  }
}
