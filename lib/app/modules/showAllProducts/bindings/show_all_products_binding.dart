import 'package:get/get.dart';

import '../controllers/show_all_products_controller.dart';

class ShowAllProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowAllProductsController>(
      () => ShowAllProductsController(),
    );
  }
}
