import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/app_info_page_controller.dart';

class AppInfoPageView extends GetView<AppInfoPageController> {
  const AppInfoPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppInfoPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AppInfoPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
