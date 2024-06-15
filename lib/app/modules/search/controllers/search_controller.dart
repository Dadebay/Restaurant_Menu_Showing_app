import 'package:get/get.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';

class SearchViewController extends GetxController {
  RxBool loadingData = false.obs;
  RxList searchResult = [].obs;

  HomeController homeController = Get.put(HomeController());
  onSearchTextChanged(String word) async {
    loadingData.value = true;
    searchResult.clear();
    List fullData = [];
    List<String> words = word.toLowerCase().trim().split(' ');
    fullData = homeController.productsList.where((p) {
      bool result = true;
      for (final word in words) {
        if (!p['name'].toLowerCase().contains(word)) {
          result = false;
        }
      }
      return result;
    }).toList();
    searchResult.value = fullData.toSet().toList();
    print(searchResult);
    print(searchResult);
    print(searchResult);
    loadingData.value = false;
  }
}
