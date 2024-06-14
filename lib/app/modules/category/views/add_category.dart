import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/home/views/custom_text_field.dart';
import 'package:menu_managament_app/contants/buttons/agree_button_view.dart';
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
        showSnackBar("Error", "No image is selected", Colors.red);
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking image.");
    }
  }

  TextEditingController nameEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: "Add Category"),
      body: ListView(
        children: [
          imageFile == null
              ? ElevatedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: const Text("get image"))
              : Image.file(
                  imageFile!,
                  width: 200,
                  height: 200,
                ),
          CustomTextField(
            labelName: "Category Name",
            controller: nameEditingController,
            focusNode: focusNode,
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
              text: "Agree")
        ],
      ),
    );
  }
}
