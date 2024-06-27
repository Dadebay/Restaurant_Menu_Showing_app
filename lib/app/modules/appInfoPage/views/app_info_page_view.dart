import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/contants/constants.dart';

import '../controllers/app_info_page_controller.dart';

class AppInfoPageView extends GetView<AppInfoPageController> {
  const AppInfoPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textPart(),
      ],
    );
  }

  Widget textPart() {
    bool sizeValue = Get.size.width >= 800 ? true : false;

    return Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            button(sizeValue, '+993-65-14-82-14', IconlyLight.call),
            button(sizeValue, 'Gökdepe toý mekany we dynç alyş merkezi Köçe magtymguly şaýoly', FontAwesomeIcons.instagram),
            button(sizeValue, 'Gökdepe toý mekany we dynç alyş merkezi Köçe magtymguly şaýoly', IconlyLight.location),
            button(sizeValue, '@Gökdepe toý mekany we dync alyş merkezi', FontAwesomeIcons.tiktok),
          ],
        ),
      ),
    );
  }

  Padding button(bool sizeValue, String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizeValue ? 15 : 8),
      child: TextButton.icon(
        onPressed: () {},
        icon: Container(
          padding: EdgeInsets.all(sizeValue ? 15 : 10),
          margin: const EdgeInsets.only(right: 10),
          decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
        label: Text(
          title,
          maxLines: 5,
          style: TextStyle(color: Colors.black, fontFamily: gilroyMedium, overflow: TextOverflow.ellipsis, fontSize: sizeValue ? 22 : 18),
        ),
      ),
    );
  }
}
