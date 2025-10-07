import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:propusers/models/about_us_models/about_us_model.dart';
import 'package:propusers/services/remote_service.dart';
import '../theme/theme.dart';
import '../widgets/app_bar.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  AboutUsModel? aboutUs;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    aboutUs = await RemoteService().getAboutUs();
    if (aboutUs != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.primary,
        leadingWidth: 50,
        leading: GestureDetector(
          onTap: () {
            print("Back Icon Clicked..");
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Icon(Icons.arrow_back),
          ),
        ),
        title: "About Us",
      ),

      body: isLoaded
          ? Column(children: [scrollingContainer()])
          : Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }

  Widget scrollingContainer() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            aboutUsSection(),
            missionSection(),
            visionSection(),
            propreneurSection()
          ],
        ),
      ),
    );
  }

  Widget titleDescriptionSection(title, description, {Color backgroundColor = Colors.white}) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(title),
            Container(height: 3, width: 90, color: AppColors.primary),
            SizedBox(height: 10),
            DescriptionText(description),
          ],
        ),
      ),
    );
  }

  Widget aboutUsSection() {
    return Container(
      color: Color(0xFFFDF3D8),
      child: Column(
        children: [
          PinterestGrid(images: aboutUs?.about?.images ?? [], borderStyle: BorderStyleType.bottom, borderRadius: 30,),
          titleDescriptionSection(aboutUs?.about?.title ?? "Title", aboutUs?.about?.description ?? "", backgroundColor: Color(0xFFFDF3D8)),
        ],
      ),
    );
  }

  Widget missionSection() {
    return Container(
      color: AppColors.background,
      child: Column(children: [
        Padding(padding: EdgeInsets.all(20), child: PinterestGrid(images: aboutUs?.ourMission?.images ?? [], borderStyle: BorderStyleType.all, borderRadius: 10,)),
        titleDescriptionSection(aboutUs?.ourMission?.title ?? "Title", aboutUs?.ourMission?.description ?? "", backgroundColor: AppColors.background),
      ],),
    );
  }

  Widget visionSection() {
    return Stack(
      children: [
        // Background image (fills entire background)
        Positioned.fill(child: PinterestGrid(images: aboutUs?.ourVision?.images ?? [], fit: BoxFit.cover, borderStyle: BorderStyleType.all, borderRadius: 0),),
        // Content that determines the height
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: titleDescriptionSection(aboutUs?.ourVision?.title ?? "Title", aboutUs?.ourVision?.description ?? "", backgroundColor: AppColors.background,),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ],
    );
  }

  Widget propreneurSection() {
    // Convert proprenuers to list of image URLs
    List<Proprenuer> proprenuers = aboutUs?.topProprenuer?.proprenuers ?? [];

    return Container(
      color: Color(0xFFFDF3D8),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + subtitle
          titleDescriptionSection(
            aboutUs?.titles?.first.title ?? "Title",
            aboutUs?.titles?.first.subtitle ?? "",
            backgroundColor: Color(0xFFFDF3D8),
          ),
          const SizedBox(height: 10),
          // Grid of images
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: proprenuers.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return proprenuerCard(proprenuers[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget proprenuerCard(Proprenuer proprenuer) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              proprenuer.imageUrl ?? "",
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 150,
                color: Colors.grey[300],
                child: Icon(Icons.person, size: 50, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              proprenuer.name ?? "Name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 5),
          // Role
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "Proprenuer",
              style: TextStyle(
                color: Colors.orange[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}

class TitleText extends StatelessWidget {
  final String title;

  const TitleText(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Split the title into words
    List<String> words = title.split(' ');
    if (words.isEmpty) words = ["Title"];

    return RichText(
      text: TextSpan(
        children: [
          // First word in primary color
          TextSpan(
            text: words.first + " ",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          // Remaining words in accent
          TextSpan(
            text: words.skip(1).join(' '),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  final String description;

  const DescriptionText(this.description, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: description,
      style: {
        "p": Style(fontSize: FontSize(16), lineHeight: LineHeight(1.5)),
        "h3": Style(
          fontSize: FontSize(18),
          fontWeight: FontWeight.bold,
          margin: Margins.symmetric(vertical: 10),
          textAlign: TextAlign.justify,
        ),
      },
    );
  }
}

enum BorderStyleType { all, top, bottom, none }

class PinterestGrid extends StatelessWidget {
  final List<String> images;
  final double spacing;

  // Custom styling
  final double borderRadius;
  final double singleImageHeight;
  final BoxFit fit;
  final EdgeInsetsGeometry? margin;
  final bool showShadow;
  final BorderStyleType borderStyle;

  const PinterestGrid({
    Key? key,
    required this.images,
    this.spacing = 8,
    this.borderRadius = 15,
    this.singleImageHeight = 200,
    this.fit = BoxFit.cover,
    this.margin,
    this.showShadow = false,
    this.borderStyle = BorderStyleType.all,
  }) : super(key: key);

  BorderRadius _getBorderRadius() {
    switch (borderStyle) {
      case BorderStyleType.all:
        return BorderRadius.circular(borderRadius);
      case BorderStyleType.top:
        return BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        );
      case BorderStyleType.bottom:
        return BorderRadius.only(
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        );
      case BorderStyleType.none:
        return BorderRadius.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    // Single image styling
    if (images.length == 1) {
      Widget imageWidget = ClipRRect(
        borderRadius: _getBorderRadius(),
        child: Image.network(
          images.first,
          fit: fit,
          width: double.infinity,
          height: singleImageHeight,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: progress.expectedTotalBytes != null
                    ? progress.cumulativeBytesLoaded /
                    (progress.expectedTotalBytes ?? 1)
                    : null,
                color: AppColors.primary,
              ),
            );
          },
        ),
      );

      // Wrap with Card if shadow is needed
      if (showShadow) {
        return Card(
          elevation: 5,
          margin: margin ?? const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: _getBorderRadius(),
          ),
          child: imageWidget,
        );
      }
      return imageWidget;
    }

  // Multiple images → Pinterest grid
  return MasonryGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      itemCount: images.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: _getBorderRadius(),
          child: Image.network(
            images[index],
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: progress.expectedTotalBytes != null
                      ? progress.cumulativeBytesLoaded /
                      (progress.expectedTotalBytes ?? 1)
                      : null,
                  color: AppColors.primary,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
