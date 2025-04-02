import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_task/utils/constants/colors.dart';
import 'package:news_app_task/utils/constants/sizes.dart';
import 'package:news_app_task/utils/device/device_utility.dart';
import 'package:iconsax/iconsax.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({super.key, this.showBackArrow = false,  this.istitle=true});

  final bool showBackArrow;
  final bool istitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Iconsax.arrow_left))
            : null,
        title: istitle?Container(
          padding: EdgeInsets.all(TSizes.spaceBtwItems),
          width: TDeviceUtils.getAppBarHeight() * 4.9,
          decoration: BoxDecoration(
            color: TColors.grey,
              borderRadius: BorderRadius.circular(TSizes.lg),
              ),
          child: Row(
            children: [
              Text(
                'Search News',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(width: TSizes.spaceBtwSections*4,),
              Expanded(child: Icon(Iconsax.search_normal))
            ],
          ),
          height: TDeviceUtils.getAppBarHeight(),
        ):null,
        actions: [
          Icon(Iconsax.notification)
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
