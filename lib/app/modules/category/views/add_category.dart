import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/home/views/custom_text_field.dart';
import 'package:menu_managament_app/contants/buttons/agree_button_view.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/widgets.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({super.key});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  final HomeController _homeController = Get.find();
  final TextEditingController _nameEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _addCategory() {
    if (_nameEditingController.text.isEmpty) {
      showSnackBar('errorTitle'.tr, 'errorEmpty'.tr, Colors.red);
      return;
    }
    _homeController.addCategory(
      name: _nameEditingController.text,
      productCount: 0,
    );
    _nameEditingController.clear();
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
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
          'add_category'.tr,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              labelName: "category_name".tr,
              controller: _nameEditingController,
              focusNode: _focusNode,
              borderRadius: true,
              requestfocusNode: _focusNode,
              unFocus: true,
            ),
            AgreeButton(onTap: _addCategory, text: "agree".tr),
          ],
        ),
      ),
    );
  }
}
