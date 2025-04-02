import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_task/bindings/allbinding.dart';
import 'package:news_app_task/routes/app_pages.dart';
import 'package:news_app_task/routes/app_routes.dart';
import 'package:news_app_task/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      title: 'News App',
      initialRoute: Routes.NAVIGATIONMENU,
      getPages: AppPages.pages,
      initialBinding: Binding(),
    );
  }
}
