import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class BannerCard extends StatelessWidget {
  final String image;

  const BannerCard({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: borderRadius30,
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 8,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius30,
          child: SizedBox(
            width: Get.size.width,
            child: Image.file(
              File(image),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
