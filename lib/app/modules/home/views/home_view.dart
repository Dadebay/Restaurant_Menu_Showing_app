import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/custom_list_view_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final HomeController _homeController = Get.find();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _initializeTabController();
    _homeController.categoryList.listen((categories) {
      _updateTabController(categories.length);
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _updateTabController(int length) {
    if (_tabController == null || _tabController!.length != length) {
      _initializeTabController(length: length);
    }
  }

  void _initializeTabController({int? length}) {
    _tabController?.dispose();
    _tabController = TabController(
      length: length ?? _homeController.categoryList.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (_homeController.categoryList.isEmpty) {
          return const SizedBox.shrink();
        } else {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/back_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  height: kToolbarHeight,
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.white,
                    dividerHeight: 0.0,
                    indicatorColor: Colors.transparent,
                    labelStyle: TextStyle(fontFamily: gilroySemiBold, color: Colors.white, fontSize: 18.sp),
                    tabAlignment: TabAlignment.start,
                    tabs: List.generate(
                      _homeController.categoryList.length,
                      (index) => Tab(
                        text: _homeController.categoryList[index]['name'].toString().toUpperCase(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: List.generate(
                        _homeController.categoryList.length,
                        (index) => CustomGridViewWidget(
                              categoryID: _homeController.categoryList[index]['id'],
                              productsList: _homeController.categoryList[index]['products'],
                            )),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
