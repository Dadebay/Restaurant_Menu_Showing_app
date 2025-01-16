import 'dart:io';
import 'dart:math';

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

class AddBannerView extends StatefulWidget {
  const AddBannerView({super.key});

  @override
  State<AddBannerView> createState() => _AddBannerViewState();
}

class _AddBannerViewState extends State<AddBannerView> {
  File? imageFile;
  getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    print(((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i]);
  }

  final ImagePicker imgpicker = ImagePicker();
  final HomeController homeController = Get.put(HomeController());
  Future getImage() async {
    try {
      final XFile? pickedFile = await imgpicker.pickImage(source: ImageSource.gallery, maxHeight: 480, maxWidth: 640, imageQuality: 50);
      // final XFile? pickedFile = await imgpicker.pickImage(
      //   source: ImageSource.gallery,
      // );
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        getFileSizeString(bytes: imageFile!.lengthSync());

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
      appBar: CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: "Reklama goşmak "),
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
                        )),
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
            borderRadius: true,
            labelName: "Reklama ady",
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
              text: "agree".tr)
        ],
      ),
    );
  }
}
