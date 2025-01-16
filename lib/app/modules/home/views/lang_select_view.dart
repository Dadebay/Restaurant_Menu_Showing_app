// lib/app/modules/lang_select_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/home/views/start_view.dart';
import 'package:menu_managament_app/contants/constants.dart';

class LangSelectView extends GetView<HomeController> {
  const LangSelectView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image/back_image.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Dil saýlaň".tr,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 40),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLanguageButton(
                  languageCode: 'tm',
                  imagePath: 'assets/image/tm.png',
                  text: 'TÜRKMEN',
                ),
                _buildLanguageButton(
                  languageCode: 'ru',
                  imagePath: 'assets/image/ru.png',
                  text: 'РУССКИЙ',
                ),
                _buildLanguageButton(
                  languageCode: 'en',
                  imagePath: 'assets/image/uk.png',
                  text: 'ENGLISH',
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildLanguageButton({required String languageCode, required String imagePath, required String text}) {
    return Expanded(
      child: InkWell(
          onTap: () {
            changeLanguage(languageCode);
            Get.to(() => const StartView());
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(borderRadius: borderRadius15, color: Colors.black, border: Border.all(color: Colors.white.withOpacity(.3), width: 1)),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image.asset(
                  imagePath,
                  height: 70,
                  width: 70,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )),
    );
  }

  void changeLanguage(String langCode) {
    var locale = Locale(langCode);
    Get.updateLocale(locale);
  }
}
