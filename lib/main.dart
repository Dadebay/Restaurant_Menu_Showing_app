import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/home/views/bottom_nav_bar.dart';
import 'package:menu_managament_app/app/modules/home/views/home_view.dart';
import 'package:menu_managament_app/contants/constants.dart';
import 'package:menu_managament_app/contants/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = GetStorage();
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    homeController.readCatgoryList();
    homeController.readProductsList();
    homeController.readBannerList();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: appName,
              theme: ThemeData(
                brightness: Brightness.light,
                fontFamily: gilroyRegular,
                colorSchemeSeed: kPrimaryColor,
                useMaterial3: true,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.dark),
                  titleTextStyle: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
                  elevation: 0,
                ),
                bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent.withOpacity(0)),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              fallbackLocale: const Locale('tm'),
              locale: storage.read('langCode') != null ? Locale(storage.read('langCode')) : const Locale('tm'),
              translations: MyTranslations(),
              defaultTransition: Transition.circularReveal,
              home: const BottomNavBar());
        });
  }
}
