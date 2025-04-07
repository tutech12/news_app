import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/news_service.dart';
import '../models/article_model.dart';

class NewsController extends GetxController {
  var articles = <Article>[].obs;
  var articlesG = <Article>[].obs;
  var articlesT = <Article>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;
  var category = 'general'.obs;
  var selectedCategoryIndex = 0.obs;
  final ScrollController scrollController = ScrollController();
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final int pageSize = 4;
  final RxBool isLoadingMore = false.obs;

  @override
  void onInit() {
    selectedCategoryIndex.value = 0;
    fetchTopHeadlines();
    fetchCategoryTopHeadlines();
    fetchCategoryTodayTopHeadlines();
    _setupScrollListener();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreArticles();
      }
    });
  }

  Future<void> fetchTopHeadlines() async {
    try {
      isLoading.value = true;
      final news = await NewsService.fetchTopHeadlines();
      articlesG.assignAll(news.articles);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategoryTopHeadlines() async {
    try {
      isLoading.value = true;
      final news = await NewsService.fetchCategoryTopHeadlines(category.value);
      articles.assignAll(news.articles);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategoryTodayTopHeadlines() async {
    try {
      isLoading.value = true;
      currentPage.value = 1;
      final news = await NewsService.fetchCategoryTodayTopHeadlines(
        page: currentPage.value,
        pageSize: pageSize,
      );
      articlesT.assignAll(news.articles);
      totalPages.value = (news.totalResults / pageSize).ceil();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreArticles() async {
    if (isLoadingMore.value || currentPage.value >= totalPages.value) return;

    try {
      isLoadingMore.value = true;
      currentPage.value++;

      final news = await NewsService.fetchCategoryTodayTopHeadlines(
        page: currentPage.value,
        pageSize: pageSize,
      );

      articlesT.addAll(news.articles);
    } catch (e) {
      error.value = e.toString();
      currentPage.value--;
    } finally {
      isLoadingMore.value = false;
    }
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    category.refresh();
  }


}