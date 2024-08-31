class NewsModel {
  String? title;
  String? description;
  String? url;
  String? image;
  String? publishedAt;
  String? content;
  String? sourceName;
  String? sourceUrl;
  String? sourceIconImage;
  String? author;
  String? category;

  NewsModel({
    this.title,
    this.description,
    this.url,
    this.image,
    this.publishedAt,
    this.content,
    this.sourceName,
    this.sourceUrl,
    this.sourceIconImage,
    this.author,
    this.category,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      image: json['image'],
      publishedAt: json['publishedAt'],
      content: json['content'],
      sourceName: json['source']['name'],
      sourceUrl: json['source']['url'],
      sourceIconImage: json['source']['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'image': image,
      'publishedAt': publishedAt,
      'content': content,
      'sourceName': sourceName,
      'sourceUrl': sourceUrl,
      'sourceIconImage': sourceIconImage,
      'author': author,
      'category': category,
    };
  }
}
