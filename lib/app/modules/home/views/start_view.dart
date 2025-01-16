// lib/app/modules/start_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/appInfoPage/views/app_info_page_view.dart';
import 'package:menu_managament_app/app/modules/home/views/bottom_nav_bar.dart';
import 'package:menu_managament_app/app/modules/settings/views/settings_view.dart';
import 'package:menu_managament_app/contants/constants.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/back_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image.asset(
                        'assets/icons/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _buildButton('start_view1', () {
                          Get.to(() => const BottomNavBar());
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildButton('start_view2', () {
                          Get.to(() => SettingsView());
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildButton('start_view3', () {
                          Get.to(() => const AppInfoPageView());
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget _buildButton(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Ekran genişliğini kullan
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: borderRadius10,
          border: Border.all(color: Colors.white, width: 1),
          color: Colors.blue.shade900.withOpacity(.6), // Mavi rengi biraz daha koyulaştır
        ),
        child: Text(
          text.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 20),
        ),
      ),
    );
  }
}
