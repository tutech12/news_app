import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app_task/features/news/screens/trendy/widgets/topnews.dart';
import 'package:news_app_task/utils/constants/colors.dart';
import 'package:news_app_task/utils/constants/sizes.dart';
import 'package:news_app_task/utils/helpers/helper_functions.dart';

import 'features/news/screens/home/widgets/home.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
          height: TSizes.appBarHeight,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value=index ,
          backgroundColor: dark? TColors.black : Colors.white ,
          indicatorColor: dark?TColors.white.withOpacity(0.1):TColors.black.withOpacity(0.1),

          destinations: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: NavigationDestination(icon: Icon(Iconsax.home),label: 'Home',),
            ),
            NavigationDestination(
                icon: Icon(Icons.trending_up_sharp), label: 'Trendy')
          ])),
      
      body: Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex= 0.obs;
  final screens = [ HomeScreen(),TopNews()];
}
