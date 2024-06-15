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

class AddBannerView extends StatefulWidget {
  const AddBannerView({super.key});

  @override
  State<AddBannerView> createState() => _AddBannerViewState();
}

class _AddBannerViewState extends State<AddBannerView> {
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
      appBar: CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: "Add Banner"),
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
            labelName: "Banner Name",
            controller: nameEditingController,
            focusNode: focusNode,
            requestfocusNode: focusNode,
            unFocus: true,
          ),
          AgreeButton(
              onTap: () {
                homeController.addBanner(
                  name: nameEditingController.text,
                  image: imageFile!.path,
                );
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
