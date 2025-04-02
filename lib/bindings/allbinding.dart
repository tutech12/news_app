import 'package:get/get.dart';
import 'package:news_app_task/features/news/controllers/news_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>NewsController());
  }
}