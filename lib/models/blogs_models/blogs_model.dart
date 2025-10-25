import 'dart:convert';

BlogsListingModel blogsListingModelFromJson(String str) =>
    BlogsListingModel.fromJson(json.decode(str));

String blogsListingModelToJson(BlogsListingModel data) =>
    json.encode(data.toJson());

class BlogsListingModel {
  bool success;
  List<BlogTitle> titles;
  List<BlogData> data;

  BlogsListingModel({
    required this.success,
    required this.titles,
    required this.data,
  });

  factory BlogsListingModel.fromJson(Map<String, dynamic> json) =>
      BlogsListingModel(
        success: json["success"] ?? false,
        titles: json["titles"] == null
            ? []
            : List<BlogTitle>.from(
            json["titles"].map((x) => BlogTitle.fromJson(x))),
        data: json["data"] == null
            ? []
            : List<BlogData>.from(
            json["data"].map((x) => BlogData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "titles": List<dynamic>.from(titles.map((x) => x.toJson())),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BlogTitle {
  int id;
  String title;
  String subtitle;
  String page;
  String section;

  BlogTitle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.page,
    required this.section,
  });

  factory BlogTitle.fromJson(Map<String, dynamic> json) => BlogTitle(
    id: json["id"] ?? 0,
    title: json["title"] ?? '',
    subtitle: json["subtitle"] ?? '',
    page: json["page"] ?? '',
    section: json["section"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "page": page,
    "section": section,
  };
}

class BlogData {
  int id;
  String postTitle;
  String postImg;
  String? postImg2;
  String? postVideo;
  String postContent;
  String createdAt;
  int views;
  int comments;
  int addedBy;
  int savedBlog;
  String category;
  String categoryImage;
  int isTrending;
  String slug;

  BlogData({
    required this.id,
    required this.postTitle,
    required this.postImg,
    this.postImg2,
    this.postVideo,
    required this.postContent,
    required this.createdAt,
    required this.views,
    required this.comments,
    required this.addedBy,
    required this.savedBlog,
    required this.category,
    required this.categoryImage,
    required this.isTrending,
    required this.slug,
  });

  factory BlogData.fromJson(Map<String, dynamic> json) => BlogData(
    id: json["id"] ?? 0,
    postTitle: json["post_title"] ?? '',
    postImg: json["post_img"] ?? '',
    postImg2: json["post_img2"],
    postVideo: json["post_video"],
    postContent: json["post_content"] ?? '',
    createdAt: json["created_at"] ?? '',
    views: json["views"] ?? 0,
    comments: json["comments"] ?? 0,
    addedBy: json["added_by"] ?? 0,
    savedBlog: json["savedBlog"] ?? 0,
    category: json["category"] ?? '',
    categoryImage: json["category_image"] ?? '',
    isTrending: json["is_trending"] ?? 0,
    slug: json["slug"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post_title": postTitle,
    "post_img": postImg,
    "post_img2": postImg2,
    "post_video": postVideo,
    "post_content": postContent,
    "created_at": createdAt,
    "views": views,
    "comments": comments,
    "added_by": addedBy,
    "savedBlog": savedBlog,
    "category": category,
    "category_image": categoryImage,
    "is_trending": isTrending,
    "slug": slug,
  };
}
