import 'package:get/get.dart';

import '../controllers/app_info_page_controller.dart';

class AppInfoPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppInfoPageController>(
      () => AppInfoPageController(),
    );
  }
}
