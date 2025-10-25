import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/blogs_models/blogs_model.dart';
import '../theme/theme.dart';
import '../widgets/app_bar.dart';

class BlogsDetailsScreen extends StatefulWidget {
  final BlogData blogs;

  const BlogsDetailsScreen({Key? key, required this.blogs}) : super(key: key);

  @override
  State<BlogsDetailsScreen> createState() => _BlogsDetailsScreenState();
}

class _BlogsDetailsScreenState extends State<BlogsDetailsScreen> {

  @override
  Widget build(BuildContext context) {

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
          title: "Blogs Details",
        ),

        body: Container(child: scrollingContainer(),)
    );
  }

  Widget scrollingContainer() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomImage(imageUrl: widget.blogs.postImg, fit: BoxFit.cover, width: double.infinity, height: 250,),
            SizedBox(height: 15),
            CustomText(widget.blogs.postTitle, align: TextAlign.justify, size: 20, overflow: TextOverflow.visible, weight: FontWeight.bold),
            Html(
              data: widget.blogs.postContent,
              style: {
                "p": Style(
                    fontSize: FontSize(16),
                    lineHeight: LineHeight(1.5),
                    textAlign: TextAlign.justify,
                    textOverflow: TextOverflow.visible
                ),
                "h3": Style(
                  fontSize: FontSize(18),
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.justify,
                  textOverflow: TextOverflow.visible,
                ),
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText("Views: ${widget.blogs.views.toString()}", size: 14, color: Colors.grey, overflow: TextOverflow.visible,),
                CustomText("Published: ${widget.blogs.createdAt.toString()}", size: 14, color: Colors.grey, overflow: TextOverflow.visible,),
              ],
            )
          ],
        ),
      ),
    );
  }
}


class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? height;

  const CustomText(
      this.text, {
        Key? key,
        this.color,
        this.size,
        this.weight,
        this.align,
        this.maxLines,
        this.overflow,
        this.letterSpacing,
        this.height,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: size ?? 14,
        fontWeight: weight ?? FontWeight.normal,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double borderRadius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Widget? errorWidget;

  const CustomImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius = 12.0,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.errorWidget,
  }) : super(key: key);

  bool get _isNetwork =>
      imageUrl != null &&
          (imageUrl!.startsWith('http://') || imageUrl!.startsWith('https://'));

  bool get _hasImage => imageUrl != null && imageUrl!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    //  If no image URL, return empty SizedBox
    if (!_hasImage) return const SizedBox.shrink();

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: _isNetwork
            ? Image.network(
          imageUrl!,
          height: height,
          width: width,
          fit: fit,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) =>
          errorWidget ?? const SizedBox.shrink(), // No fallback shown
        )
            : Image.asset(imageUrl!, height: height, width: width, fit: fit),
      ),
    );
  }
}

