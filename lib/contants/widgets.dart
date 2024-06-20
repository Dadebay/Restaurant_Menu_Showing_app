import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:menu_managament_app/app/modules/showAllProducts/views/show_all_products_view.dart';
import 'package:menu_managament_app/contants/constants.dart';

SnackbarController showSnackBar(String title, String subtitle, Color color) {
  if (SnackbarController.isSnackbarBeingShown) {
    SnackbarController.cancelAllSnackbars();
  }
  return Get.snackbar(
    title,
    subtitle,
    snackStyle: SnackStyle.floating,
    titleText: title == ''
        ? const SizedBox.shrink()
        : Text(
            title.tr,
            style: const TextStyle(fontFamily: gilroySemiBold, fontSize: 18, color: Colors.white),
          ),
    messageText: Text(
      subtitle.tr,
      style: const TextStyle(fontFamily: gilroyRegular, fontSize: 16, color: Colors.white),
    ),
    snackPosition: SnackPosition.top,
    backgroundColor: color,
    borderRadius: 20.0,
    duration: const Duration(milliseconds: 800),
    margin: const EdgeInsets.all(8),
  );
}

GestureDetector NameWidget({required String name, required String categoryID, required List list}) {
  bool sizeValue = Get.size.width >= 800 ? true : false;

  return GestureDetector(
    onTap: () {
      Get.to(() => ShowAllProductsView(
            categoryID: categoryID,
            name: name,
            list: list,
          ));
    },
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontFamily: gilroyBold, fontSize: sizeValue ? 26 : 22),
          ),
          const Icon(IconlyLight.arrowRightCircle)
        ],
      ),
    ),
  );
}

customAlertDialog({required BuildContext context, required String title, required String subtitle, required Function() onYES}) {
  // Set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      "no".tr,
      style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 20),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
      onPressed: onYES,
      child: Text(
        "yes".tr,
        style: const TextStyle(color: Colors.grey, fontFamily: gilroyRegular, fontSize: 20),
      ));

  AlertDialog alert = AlertDialog(
    title: Text(
      title.tr,
      style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 22),
    ),
    content: Text(
      subtitle.tr,
      style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18),
    ),
    actions: [cancelButton, continueButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Center spinKit() {
  return Center(
    child: Lottie.asset(loadingLottie, width: 70.w, height: 70.h),
  );
}

Center errorData() {
  return const Center(
    child: Text("Error data"),
  );
}

Center emptyData() {
  return Center(
      child: Text(
    "noProduct".tr,
    style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 18.sp),
  ));
}

dynamic emptyCart() {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/lottie/emptyCART.json', fit: BoxFit.cover, animate: true, width: 400, height: 400),
        Text(
          'cartEmpty'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
        ),
        Text(
          'cartEmptySubtitle'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 20),
        ),
        const SizedBox(
          height: 125,
        )
      ],
    ),
  );
}
