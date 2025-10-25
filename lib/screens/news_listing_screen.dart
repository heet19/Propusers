import 'package:flutter/material.dart';
import 'package:propusers/screens/news_details_screen.dart';
import 'package:propusers/services/remote_service.dart';

import '../models/news_models/news_model.dart';
import '../theme/theme.dart';
import '../widgets/app_bar.dart';

class NewsListingScreen extends StatefulWidget {
  const NewsListingScreen({Key? key}) : super(key: key);


  @override
  State<NewsListingScreen> createState() => _NewsListingScreenState();
}

class _NewsListingScreenState extends State<NewsListingScreen> {
  NewsListingModel? newsListing;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }


  Future<void> _loadNews() async {
    final result = await RemoteService.fetchNewsListing();
    setState(() {
      newsListing = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (newsListing == null || newsListing!.data.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No news available")),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.primary,
        leadingWidth: 50,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Icon(Icons.arrow_back),
          ),
        ),
        title: "News",
      ),

      body:  ListView.builder(
        itemCount: newsListing!.data.length,
        itemBuilder: (context, index) {
          final news = newsListing!.data[index];
          return NewsCard(
            imageUrl: news.postImg,
            title: news.postTitle,
            description: removeHtmlTags(news.postContent),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NewsDetailsScreen( news: news ),),),
          );
        },
      ),
    );
  }
}


// Optional HTML cleaner
String removeHtmlTags(String htmlText) {
  final regex = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
  return htmlText.replaceAll(regex, '');
}

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const NewsCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Content section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    "Read More",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
