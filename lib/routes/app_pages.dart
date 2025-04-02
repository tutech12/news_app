import 'package:get/get.dart';
import 'package:news_app_task/features/news/screens/home/widgets/home.dart';
import 'package:news_app_task/navigation_menu.dart';

import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
    GetPage(name: Routes.NAVIGATIONMENU, page: () => NavigationMenu()),
    // GetPage(name: Routes.CATEGORY, page: () => CategoryView()),
    // GetPage(name: Routes.ARTICLE, page: () => ArticleView()),
  ];
}