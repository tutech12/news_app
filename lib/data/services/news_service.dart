import 'dart:io';

import 'package:news_app_task/utils/formatters/formatter.dart';

import '../../features/news/models/news_response_model.dart';
import '../../utils/http/http_client.dart';
import '../app_exception.dart';

class NewsService{
    static Future<NewsResponse> fetchTopHeadlines() async {
      try{
        final response = await THttpHelper.get('https://newsapi.org/v2/top-headlines?country=us&apiKey=32416fad1fda4fa5b557a67707e3f19f')
        .timeout(const Duration(seconds: 10));

        // 3. Handle response
        return NewsResponse.fromJson(response);
      }on SocketException{
        throw InternetException('');
      }on RequestTimeOut{
        throw RequestTimeOut('');
      } on FormatException {
        throw InvalidDataException('Invalid API response format');
      } catch (e) {
        throw UnknownException('Failed to fetch headlines: ${e.toString()}');
      }
    }

    static Future<NewsResponse> fetchCategoryTopHeadlines(String category) async {
      try{
        final response = await THttpHelper.get('https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=32416fad1fda4fa5b557a67707e3f19f')
            .timeout(const Duration(seconds: 10));

        // 3. Handle response
        return NewsResponse.fromJson(response);
      }on SocketException{
        throw InternetException('');
      }on RequestTimeOut{
        throw RequestTimeOut('');
      } on FormatException {
        throw InvalidDataException('Invalid API response format');
      } catch (e) {
        throw UnknownException('Failed to fetch headlines: ${e.toString()}');
      }
    }

    static Future<NewsResponse> fetchCategoryTodayTopHeadlines({int page = 1,
      int pageSize = 20}) async {

      try{
        var now = DateTime.now();
        var date=TFormatter.formatDate(now);
        final response = await THttpHelper.get('https://newsapi.org/v2/top-headlines?from=$date&to=$date&sortBy=popularity&country=us&pageSize=$pageSize&page=$page&apiKey=32416fad1fda4fa5b557a67707e3f19f')
            .timeout(const Duration(seconds: 10));

        // 3. Handle response
        return NewsResponse.fromJson(response);
      }on SocketException{
        throw InternetException('');
      }on RequestTimeOut{
        throw RequestTimeOut('');
      } on FormatException {
        throw InvalidDataException('Invalid API response format');
      } catch (e) {
        throw UnknownException('Failed to fetch headlines: ${e.toString()}');
      }
    }
}

























// import 'dart:async';
// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:news_app_task/features/news/models/news_response_model.dart';
//
// import '../app_exception.dart';
//
// class NewsService extends GetConnect {
//
//   Future<NewsResponse> fetchTopHeadlines() async {
// try{
//
// }on SocketException{
//   throw InternetException('');
// }
//     // 1. Make HTTP request with timeout
//     final response = await get('https://newsapi.org/v2/top-headlines?country=us&apiKey=YOUR_KEY')
//         .timeout(const Duration(seconds: 10), onTimeout: () {
//       throw TimeoutException('Connection timed out');
//     });
//
//     // 3. Handle response
//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       return NewsResponse.fromJson(jsonData);
//     } else {
//       // Handle different error codes
//       final errorJson = jsonDecode(response.body);
//       throw NewsApiException(
//         code: response.statusCode,
//         message: errorJson['message'] ?? 'Unknown error',
//       );
//     }
//   } on SocketException {
//   throw NoInternetException('No internet connection');
// } on FormatException {
// throw InvalidDataException('Invalid API response format');
// } catch (e) {
// throw UnknownException('Failed to fetch headlines: ${e.toString()}');
// }
//
// }