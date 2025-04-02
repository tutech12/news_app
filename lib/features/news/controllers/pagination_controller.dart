import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaginationController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RxBool isLoadingMoreTop = false.obs;
  final RxBool isLoadingMoreBottom = false.obs;
  final RxDouble currentScrollOffset = 0.0.obs;
  final RxList<String> messages = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with some data
    messages.addAll(List.generate(20, (index) => 'Message $index'));
    _setupScrollListener();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          loadMoreTop();
        } else {
          loadMoreBottom();
        }
      }
    });
  }

  Future<void> loadMoreTop() async {
    if (isLoadingMoreTop.value) return;
    currentScrollOffset.value = scrollController.position.maxScrollExtent;
    isLoadingMoreTop.value = true;

    await Future.delayed(const Duration(seconds: 1));
    final newMessages = List.generate(10, (index) => 'New Message Top $index');

    messages.insertAll(0, newMessages);
    isLoadingMoreTop.value = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(
          scrollController.position.maxScrollExtent - currentScrollOffset.value);
    });
  }

  Future<void> loadMoreBottom() async {
    if (isLoadingMoreBottom.value) return;
    isLoadingMoreBottom.value = true;

    await Future.delayed(const Duration(seconds: 1));
    final newMessages = List.generate(10, (index) => 'New Message Bottom $index');

    messages.addAll(newMessages);
    isLoadingMoreBottom.value = false;
  }
}