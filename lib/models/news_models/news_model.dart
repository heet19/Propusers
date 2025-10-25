class NewsListingModel {
  final bool success;
  final List<NewsTitle> titles;
  final List<NewsData> data;

  NewsListingModel({
    required this.success,
    required this.titles,
    required this.data,
  });

  factory NewsListingModel.fromJson(Map<String, dynamic> json) {
    return NewsListingModel(
      success: json['success'] ?? false,
      titles: (json['titles'] as List<dynamic>?)
          ?.map((e) => NewsTitle.fromJson(e))
          .toList() ??
          [],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NewsData.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'titles': titles.map((e) => e.toJson()).toList(),
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class NewsTitle {
  final int id;
  final String title;
  final String subtitle;
  final String page;
  final String section;

  NewsTitle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.page,
    required this.section,
  });

  factory NewsTitle.fromJson(Map<String, dynamic> json) {
    return NewsTitle(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      page: json['page'] ?? '',
      section: json['section'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'subtitle': subtitle,
    'page': page,
    'section': section,
  };
}

class NewsData {
  final int id;
  final String postTitle;
  final String postImg;
  final String? postImg2;
  final String? postVideo;
  final String postContent;
  final String createdAt;
  final int views;
  final int comments;
  final String? addedBy;
  final int savedNews;
  final String category;
  final String? categoryImg;
  final int isTrending;
  final String slug;
  final String location;

  NewsData({
    required this.id,
    required this.postTitle,
    required this.postImg,
    this.postImg2,
    this.postVideo,
    required this.postContent,
    required this.createdAt,
    required this.views,
    required this.comments,
    this.addedBy,
    required this.savedNews,
    required this.category,
    this.categoryImg,
    required this.isTrending,
    required this.slug,
    required this.location,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      id: json['id'] ?? 0,
      postTitle: json['post_title'] ?? '',
      postImg: json['post_img'] ?? '',
      postImg2: json['post_img2'],
      postVideo: json['post_video'],
      postContent: json['post_content'] ?? '',
      createdAt: json['created_at'] ?? '',
      views: json['views'] ?? 0,
      comments: json['comments'] ?? 0,
      addedBy: json['added_by'],
      savedNews: json['savednews'] ?? 0,
      category: json['category'] ?? '',
      categoryImg: json['category_img'],
      isTrending: json['is_trending'] ?? 0,
      slug: json['slug'] ?? '',
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'post_title': postTitle,
    'post_img': postImg,
    'post_img2': postImg2,
    'post_video': postVideo,
    'post_content': postContent,
    'created_at': createdAt,
    'views': views,
    'comments': comments,
    'added_by': addedBy,
    'savednews': savedNews,
    'category': category,
    'category_img': categoryImg,
    'is_trending': isTrending,
    'slug': slug,
    'location': location,
  };
}
