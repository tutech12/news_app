class Article {
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt; // Changed to DateTime for better handling
  final String? content;
  final String? sourceName; // Often needed from nested JSON

  Article({
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
    this.sourceName,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json['author'] as String? ?? '',
      title: json['title'] as String? ?? 'No Title', // Fallback for null
      description: json['description'] as String? ?? 'No Description',
      url: json['url'] as String? ?? '', // Fallback for null
      urlToImage: json['urlToImage'] as String? ??'assets/images/noimg.png',
      publishedAt: DateTime.parse(json['publishedAt'] as String? ?? DateTime.now().toIso8601String()),
      content: json['content'] as String? ?? '',
      sourceName: json['source'] is Map<String, dynamic>
          ? (json['source']['name'] as String?)
          : null,
    );
  }
}