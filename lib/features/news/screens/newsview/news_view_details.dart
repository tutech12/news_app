import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app_task/features/news/models/article_model.dart';
import 'package:news_app_task/features/news/screens/home/widgets/home.dart';
import 'package:news_app_task/utils/constants/sizes.dart';
import 'package:news_app_task/utils/device/device_utility.dart';


class NewsViewDetails extends StatelessWidget {
  const NewsViewDetails({super.key, required this.data});

  final Article data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () => Get.back(),
        child: BorderBox(
          width: TSizes.spaceBtwSections*1.3,
          height: TSizes.spaceBtwSections*1.3,

          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Icon(size: 22,
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(data.urlToImage!), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                  child: Text(
                data.title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white, backgroundColor: Colors.black45),
              )),
              Row(
                children: [
                  CircleAvatar(),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(data.author!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                  Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Iconsax.share,
                    color: Colors.white,
                  ),
                  // BorderBox(width: THelperFunctions.screenWidth()/1, height: 5)
                ],
              ),
              Divider(
                color: Colors.white,
                thickness: 5,
              ),
        Container(
          color: Colors.black45,
          child: SingleChildScrollView(  // Optional: If text is long
            child: Text(
              data.description!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateColor.transparent,
                      side: WidgetStateBorderSide.resolveWith(
                          (states) => BorderSide.none),
                      padding: WidgetStateProperty.all(
                          EdgeInsets.all(TSizes.spaceBtwItems))),
                  onPressed: () async{
                   TDeviceUtils.launchUrl(data.url);
                  },
                  child: Text("Click For More"))
            ],
          ),
        ),
      ),
    );
  }
}
