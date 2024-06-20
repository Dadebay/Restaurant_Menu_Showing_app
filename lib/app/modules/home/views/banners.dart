import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/contants/cards/banner_card.dart';
import 'package:menu_managament_app/contants/constants.dart';

class Banners extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  Banners({super.key});
  @override
  Widget build(BuildContext context) {
    bool sizeValue = Get.size.width >= 800 ? true : false;
    print(sizeValue);
    return homeController.bannerList.isEmpty
        ? const SizedBox.shrink()
        : Obx(() {
            return Column(
              children: [
                CarouselSlider.builder(
                  itemCount: homeController.bannerList.length,
                  itemBuilder: (context, index, count) {
                    return BannerCard(
                      image: homeController.bannerList[index]['image'],
                    );
                  },
                  options: CarouselOptions(
                    onPageChanged: (index, CarouselPageChangedReason a) {
                      homeController.bannerDotsIndex.value = index;
                    },
                    viewportFraction: 0.9,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: sizeValue ? 7 / 3 : 5 / 3,
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                    autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                  ),
                ),
                SizedBox(
                  height: sizeValue ? 40 : 20,
                  width: Get.size.width,
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.bannerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(() {
                          final isSelected = homeController.bannerDotsIndex.value == index;
                          final double dotSize = sizeValue ? 22 : 16;
                          final borderWidth = isSelected ? 3.0 : 1.0;
                          return AnimatedContainer(
                            margin: EdgeInsets.symmetric(horizontal: sizeValue ? 8 : 4),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                            height: isSelected ? dotSize : dotSize - 6,
                            width: isSelected ? dotSize - 1 : dotSize - 6,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.transparent : Colors.grey.shade400,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? kPrimaryColor : Colors.white,
                                width: borderWidth,
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                )
              ],
            );
          });
  }
}
