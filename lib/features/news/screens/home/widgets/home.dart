import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_task/common/widgets/appbar/appbar.dart';
import 'package:news_app_task/features/news/controllers/news_controller.dart';
import 'package:news_app_task/features/news/screens/newsview/news_view_details.dart';
import 'package:news_app_task/utils/constants/colors.dart';
import 'package:news_app_task/utils/constants/sizes.dart';
import 'package:news_app_task/utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> category = [
    'general',
    'entertainment',
    'business',
    'health',
    'science',
    'sports',
    'technology'
  ];



  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NewsController>();

    return Scaffold(
      appBar: TAppBar(),
      body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text('Explore the world by one click',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    ),

                    // Carousel Slider
                    Obx(() {
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                        ),
                        items: controller.articlesG.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Center(
                                child: GestureDetector(
                                  onTap: () => Get.to(()=> NewsViewDetails(data: i)),
                                  child: BorderBox(
                                    width: THelperFunctions.screenWidth() / 1,
                                    height: 200,
                                    isImage: true,
                                    url: i.urlToImage ?? '',
                                    isBorder: false,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          i.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            backgroundColor:
                                            Colors.black.withOpacity(0.4),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    }),

                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Category Selector
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: category.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Obx(() {
                              final isSelected = controller.selectedCategoryIndex.value == index;
                              return GestureDetector(
                                onTap: () {
                                  controller.selectedCategoryIndex.value = index;
                                  controller.category.value = category[index];
                                  controller.fetchCategoryTopHeadlines();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: BorderBox(
                                    color: isSelected ? Colors.black : Colors.white,
                                    child: Center(
                                      child: Text(
                                        category[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                          color: isSelected ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    isBorder: false,
                                    width: TSizes.spaceBtwSections * 4,
                                    height: 0,
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwItems),
              ]
              ),
            ),



      Obx(() {
        if (controller.isLoading.value) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final alldata = controller.articles[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
                child: GestureDetector(
                  onTap: () => Get.to(() => NewsViewDetails(data: alldata)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
                    child: BorderBox(
                      color: TColors.grey.withOpacity(0.5),isBorder: false,
                      width: 0,
                      height: TSizes.spaceBtwSections * 5,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Row(
                          children: [
                            // Image
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BorderBox(isBorder: false,
                                width: TSizes.spaceBtwSections * 3.5,
                                height: TSizes.spaceBtwSections * 3.5,
                                isImage: true,
                                url: alldata.urlToImage ?? '',
                              ),
                            ),

                            // Title and details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    alldata.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(fontSize: 10.9),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: TSizes.spaceBtwItems),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '15 mins read',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),

                                        Text(
                                          'Today',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: controller.articles.length,
          ),
        );
      }),
       ]
        // News list

              // News List
              // Obx(() {
              //   if (controller.isLoading.value) {
              //     return const Center(child: CircularProgressIndicator());
              //   }
              //   return SizedBox(
              //     height: THelperFunctions.screenHeight(),
              //     width: double.infinity,
              //     child: ListView.builder(
              //       controller: controller.controller,
              //       shrinkWrap: true,
              //       itemCount: controller.articles.length,
              //       scrollDirection: Axis.vertical,
              //       itemBuilder: (_, index) {
              //         final alldata = controller.articles[index];
              //         return GestureDetector(
              //           onTap: () {
              //             Get.to(()=> NewsViewDetails(data: alldata,));
              //           },
              //           child: Padding(
              //             padding: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
              //             child: ,
              //           ),
              //         );
              //       },
              //     ),
              //   );
              // }),
      )
    );
  }
}

class BorderBox extends StatelessWidget {
  const BorderBox({
    super.key,
    required this.width,
    required this.height,
    this.child,
    this.isImage = false,
    this.isBorder = true,
    this.color = Colors.white,
    this.url = '',
  });

  final double width;
  final double height;
  final Widget? child;
  final bool isImage;
  final bool isBorder;
  final Color color;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.lg),
        color: color,
        border: isBorder ? Border.all(color: Colors.black) : null,
        image: isImage
            ? DecorationImage(
          image: url.startsWith('http')
              ? NetworkImage(url,) as ImageProvider
              : const AssetImage(
              'assets/images/noimg.png'),
          fit: BoxFit.fill,

        )
            : null,
      ),
      height: height,
      child: child,
    );
  }
}