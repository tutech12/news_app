import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_task/features/news/screens/newsview/news_view_details.dart';
import 'package:news_app_task/utils/constants/sizes.dart';
import 'package:news_app_task/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../controllers/news_controller.dart';
import '../../../models/article_model.dart';
import '../../home/widgets/home.dart';

class TopNews extends StatelessWidget {
  TopNews({super.key});
  final controller = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 10),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: TSizes.lg),
              child: Text(
                'Top reads of the day',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),

            // News List
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification &&
                      scrollNotification.metrics.pixels ==
                          scrollNotification.metrics.maxScrollExtent) {
                    if (!controller.isLoadingMore.value &&
                        controller.currentPage.value < controller.totalPages.value) {
                      controller.loadMoreArticles();
                    }
                  }
                  return false;
                },
                child: Obx(() {
                  if (controller.isLoading.value && controller.currentPage.value == 1) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.error.value.isNotEmpty) {
                    return Center(
                      child: Text(
                        controller.error.value,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }

                  if (controller.articlesT.isEmpty) {
                    return Center(
                      child: Text(
                        'No articles found',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await controller.fetchCategoryTodayTopHeadlines();
                    },
                    child: ListView.separated(
                      controller: controller.scrollController,
                      itemCount: controller.articlesT.length + (controller.isLoadingMore.value ? 1 : 0),
                      physics: const AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
                      itemBuilder: (_, index) {
                        if (index >= controller.articlesT.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final article = controller.articlesT[index];
                        return _NewsItem(article: article);
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsItem extends StatelessWidget {
  final Article article;

  const _NewsItem({required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => NewsViewDetails(data: article)),
      child: BorderBox(
        color: TColors.grey.withOpacity(0.5),
        isBorder: false,
        width: 0,
        height: TSizes.spaceBtwSections * 5,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.sm),
          child: Row(
            children: [
              // Image
              Padding(
                padding: const EdgeInsets.all(TSizes.sm),
                child: BorderBox(
                  isBorder: false,
                  width: TSizes.spaceBtwSections * 3.5,
                  height: TSizes.spaceBtwSections * 3.5,
                  isImage: true,
                  url: article.urlToImage ?? '',
                ),
              ),

              // Title and details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      article.title ?? 'No title',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 10.9),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Row(
                      children: [
                        Text(
                          '15 mins read',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const Spacer(),
                        Text(
                          'Today',
                          style: Theme.of(context).textTheme.labelMedium,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}