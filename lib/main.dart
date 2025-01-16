import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menu_managament_app/app/modules/home/controllers/home_controller.dart';
import 'package:menu_managament_app/app/modules/home/views/lang_select_view.dart';
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
                fontFamily: gilroyRegular,
                colorSchemeSeed: kPrimaryColor,
                useMaterial3: true,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.black,
                  systemOverlayStyle:
                      SystemUiOverlayStyle(statusBarColor: Colors.black, systemNavigationBarColor: Colors.black, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.light),
                  titleTextStyle: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
                  elevation: 0,
                ),
              ),
              fallbackLocale: const Locale('tm'),
              locale: storage.read('langCode') != null ? Locale(storage.read('langCode')) : const Locale('tm'),
              translations: MyTranslations(),
              defaultTransition: Transition.circularReveal,
              home: const LangSelectView());
        });
  }
}
