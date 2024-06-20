import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/contants/cards/home_page_product_card.dart';
import 'package:menu_managament_app/contants/custom_app_bar.dart';
import 'package:menu_managament_app/contants/widgets.dart';

import '../controllers/search_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController controller = TextEditingController();
  final HomeController homeController = Get.put(HomeController());
  final SearchViewController searchController = Get.put(SearchViewController());
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool sizeValue = Get.size.width >= 800 ? true : false;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(backArrow: true, centerTitle: true, actionIcon: false, name: "search".tr),
        body: Column(
          children: [
            searchWidget(),
            Expanded(
              child: Obx(() {
                return searchController.loadingData.value == true
                    ? spinKit()
                    : searchController.searchResult.isEmpty && controller.text.isNotEmpty
                        ? emptyData()
                        : GridView.builder(
                            itemCount: searchController.searchResult.isEmpty ? homeController.productsList.length : searchController.searchResult.length,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: sizeValue ? 3 : 2, childAspectRatio: 3 / 4.25),
                            itemBuilder: (context, index) {
                              return HomePageProductCard(
                                sizeValue: sizeValue,
                                index: index,
                                list: searchController.searchResult.isEmpty ? homeController.productsList : searchController.searchResult,
                              );
                            },
                          );
              }),
            )
          ],
        ));
  }

  Padding searchWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: const Icon(
            IconlyLight.search,
            color: Colors.black,
          ),
          title: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'search'.tr, border: InputBorder.none),
            onChanged: (String value) {
              searchController.onSearchTextChanged(value);
            },
          ),
          contentPadding: EdgeInsets.only(left: 15.w),
          trailing: IconButton(
            icon: const Icon(CupertinoIcons.xmark_circle),
            onPressed: () {
              controller.clear();
              searchController.onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }
}
