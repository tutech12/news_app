import 'article_model.dart';

class NewsResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    // Handle cases where 'articles' might be missing or null
    final rawArticles = json['articles'] as List<dynamic>? ?? [];

    return NewsResponse(
      status: json['status'] as String? ?? 'error', // Fallback value
      totalResults: (json['totalResults'] as int?) ?? 0, // Fallback to 0
      articles: rawArticles.map((articleJson) {
        try {
          return Article.fromJson(articleJson as Map<String, dynamic>);
        } catch (e) {
          // Return a default article if parsing fails
          return Article(
            title: 'Invalid Article',
            url: '',
            publishedAt: DateTime.now(),
          );
        }
      }).toList(),
    );
  }
}
