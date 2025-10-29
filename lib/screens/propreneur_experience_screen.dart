import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:propusers/models/propreneur_experience_models/propreneur_experience_model.dart';

import '../services/remote_service.dart';
import '../theme/theme.dart';
import '../widgets/app_bar.dart';

class PropreneurExperienceScreen extends StatefulWidget {
  @override
  State<PropreneurExperienceScreen> createState() =>
      _PropreneurExperienceScreenState();
}

class _PropreneurExperienceScreenState extends State<PropreneurExperienceScreen> {
  PropreneurExperienceModel? propreneurExperience;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    propreneurExperience = await RemoteService().getPropreneurExperience();
    if (propreneurExperience != null) {
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
        title: "Propreneur Experience",
      ),

      body: isLoaded
          ? Container(color: AppColors.background, child: scrollingContainer())
          : Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }

  Widget scrollingContainer() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            firstContainer(),
            SizedBox(height: 20),
            secondContainer(),
            SizedBox(height: 20),
            thirdContainer(),
            SizedBox(height: 20),
            fourthColumn(),
            SizedBox(height: 20),
            fifthColumn(),
            SizedBox(height: 20),
            sixthListColumn(),
            SizedBox(height: 20),
            seventhFAQs(),
          ],
        ),
      ),
    );
  }

  Widget firstContainer() {
    return Column(
      children: [
        CustomText(
          propreneurExperience?.data.first.title ?? "",
          size: 30,
          weight: FontWeight.bold,
          color: Colors.black,
          overflow: TextOverflow.visible,
        ),
        SizedBox(height: 10),
        CustomText(
          propreneurExperience?.data.first.subtitle ?? "",
          size: 14,
          color: Colors.black,
          overflow: TextOverflow.visible,
          align: TextAlign.justify,
        ),
        SizedBox(height: 20),
        CustomImage(
          imageUrl: propreneurExperience?.data.first.img,
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  Widget secondContainer() {
    return SizedBox(
      width: double.infinity,
      child: ReusableCard(
        elevation: 5,
        borderRadius: 10,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            TitleLayout(
              titleText: propreneurExperience?.data.second.title ?? "",
              size: 30,
              align: TextAlign.start,
              weight: FontWeight.bold,
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 10),
            CustomImage(
              imageUrl: propreneurExperience?.data.second.img,
              fit: BoxFit.contain,
              borderRadius: 10,
            ),
            SizedBox(height: 20),
            secondFeatureColumn(),
          ],
        ),
      ),
    );
  }

  Widget secondFeatureColumn() {
    var features = propreneurExperience?.data.second.features ?? [];
    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleLayout(
                titleText: feature.title,
                size: 20,
                align: TextAlign.start,
                weight: FontWeight.bold,
                overflow: TextOverflow.visible,
              ),
              Html(
                data: feature.subtitle,
                style: {
                  "p": Style(
                    fontSize: FontSize(16),
                    lineHeight: LineHeight(1.5),
                    textAlign: TextAlign.justify,
                  ),
                  "h3": Style(
                    fontSize: FontSize(18),
                    fontWeight: FontWeight.bold,
                    margin: Margins.symmetric(vertical: 10),
                  ),
                },
              ),
              SizedBox(height: 10),
              CustomImage(
                imageUrl: feature.image,
                fit: BoxFit.contain,
                borderRadius: 10,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget thirdContainer() {
    return SizedBox(
      width: double.infinity,
      child: ReusableCard(
        elevation: 5,
        borderRadius: 10,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            TitleLayout(
              titleText: propreneurExperience?.data.third.title ?? "",
              size: 30,
              align: TextAlign.start,
              weight: FontWeight.bold,
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 10),
            thirdFeatureCarousel(),
          ],
        ),
      ),
    );
  }

  Widget thirdFeatureCarousel() {
    var features = propreneurExperience?.data.third.features ?? [];

    return CarouselSlider(
      options: CarouselOptions(
        height: 450,
        // Height of each card
        viewportFraction: 0.95,
        // Card width relative to screen
        enableInfiniteScroll: true,
        enlargeCenterPage: false,
        // "true" -> Makes center card bigger
        autoPlay: true, // Optional autoplay
      ),
      items: features.map((feature) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  // Background Image
                  CustomImage(
                    imageUrl: feature.image,
                    fit: BoxFit.cover,
                    borderRadius: 10,
                    height: 450,
                    width: double.infinity,
                  ),
                  // Overlay for readability
                  Container(
                    height: 450,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  // Text on top
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TitleLayout(
                            titleText: feature.title,
                            size: 18,
                            color: Colors.white,
                            align: TextAlign.start,
                            weight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                          ),
                          SizedBox(height: 8),
                          Html(
                            data: feature.subtitle,
                            style: {
                              "p": Style(
                                fontSize: FontSize(14),
                                color: Colors.white,
                                lineHeight: LineHeight(1.5),
                              ),
                              "h3": Style(
                                fontSize: FontSize(16),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                margin: Margins.symmetric(vertical: 10),
                              ),
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget fourthColumn() {
    return SizedBox(
      width: double.infinity,
      child: ReusableCard(
        elevation: 5,
        borderRadius: 10,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            TitleLayout(
              titleText: propreneurExperience?.data.fourth.title ?? "",
              size: 30,
              align: TextAlign.start,
              weight: FontWeight.bold,
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 10),
            ForthSingleItem(propreneurExperience: propreneurExperience,),
          ],
        ),
      ),
    );
  }

  Widget fifthColumn() {
    return SizedBox(
      width: double.infinity,
      child: ReusableCard(
        elevation: 5,
        borderRadius: 10,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            TitleLayout(
              titleText: propreneurExperience?.data.fifth.title ?? "",
              size: 30,
              align: TextAlign.start,
              weight: FontWeight.bold,
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 10),
            Html(
              data: propreneurExperience?.data.fifth.subtitle ?? "",
              style: {
                "p": Style(fontSize: FontSize(16), lineHeight: LineHeight(1.5)),
                "h3": Style(
                  fontSize: FontSize(18),
                  fontWeight: FontWeight.bold,
                  margin: Margins.symmetric(vertical: 10),
                ),
              },
            ),
            CustomImage(
              imageUrl: propreneurExperience?.data.fifth.img,
              fit: BoxFit.contain,
              borderRadius: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget sixthListColumn() {
    // Split the subtitle into a list of items
    var subtitleText = propreneurExperience?.data.sixth.subtitle ?? "";
    var items = subtitleText.split(",").map((e) => e.trim()).toList();

    return SizedBox(
      width: double.infinity,
      child: ReusableCard(
        elevation: 5,
        borderRadius: 10,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleLayout(
                titleText: propreneurExperience?.data.sixth.title ?? "",
                size: 30,
                align: TextAlign.start,
                weight: FontWeight.bold,
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: 16),

              // The grid layout for services
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 20,
                  childAspectRatio: 4, // adjust for your text layout
                ),
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 18,
                        width: 2.5,
                        color: AppColors.primary, // yellow line
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomText(
                          items[index],
                          size: 14,
                          weight: FontWeight.w600,
                          color: Colors.black,
                          overflow: TextOverflow.visible,
                          align: TextAlign.start,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 16),

              CustomImage(
                imageUrl: propreneurExperience?.data.sixth.img ?? "",
                fit: BoxFit.contain,
                borderRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget seventhFAQs() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment: Alignment.center,
          children: [
            ///  Background image that expands with the card height
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomImage(
                  imageUrl: propreneurExperience?.data.seventh.img,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),

            ///  Dark overlay for readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),

            ///  Foreground content (automatically grows)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ReusableCard(
                elevation: 5,
                borderRadius: 10,
                backgroundColor: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleLayout(
                      titleText: propreneurExperience?.data.seventh.title ?? "",
                      size: 30,
                      align: TextAlign.start,
                      weight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                    ),
                    const SizedBox(height: 10),
                    questionAnswerLayout(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget questionAnswerLayout() {
    var features = propreneurExperience?.data.seventh.features ?? [];

    // Convert your API features into the Feature model used above
    final featureList = features.map((item) {
      return Feature(title: item.title, subtitle: item.subtitle);
    }).toList();

    return QuestionAnswerLayout(features: featureList);
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

class ReusableCard extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;
  final EdgeInsets? padding;
  final double borderRadius;
  final double? elevation;

  const ReusableCard({
    Key? key,
    required this.backgroundColor,
    required this.child,
    this.padding,
    this.borderRadius = 16.0,
    this.elevation = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      elevation: elevation ?? 4.0,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}

class TitleLayout extends StatelessWidget {
  final String titleText;

  // All CustomText properties
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? height;

  // TitleLayout-specific properties
  final double? lineWidth;
  final double? lineHeight;
  final Color? lineColor;
  final EdgeInsets? padding;

  const TitleLayout({
    Key? key,
    required this.titleText,
    this.color,
    this.size,
    this.weight,
    this.align,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.lineWidth = 100,
    this.lineHeight = 3,
    this.lineColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            titleText,
            color: color,
            size: size,
            weight: weight,
            align: align,
            maxLines: maxLines,
            overflow: overflow,
            letterSpacing: letterSpacing,
            height: height,
          ),
          Container(
            height: lineHeight,
            width: lineWidth,
            color: lineColor ?? AppColors.primary,
          ),
        ],
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

class Feature {
  final String? title;
  final String? subtitle;

  Feature({this.title, this.subtitle});
}

class QuestionAnswerLayout extends StatefulWidget {
  final List<Feature> features;

  const QuestionAnswerLayout({required this.features, super.key});

  @override
  State<QuestionAnswerLayout> createState() => _QuestionAnswerLayoutState();
}

class _QuestionAnswerLayoutState extends State<QuestionAnswerLayout> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.features.length, (index) {
        final feature = widget.features[index];
        final isExpanded = expandedIndex == index;

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    expandedIndex = isExpanded ? null : index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomText(
                          feature.title ?? "",
                          size: 16,
                          weight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.remove_circle_outline
                            : Icons.add_circle_outline,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                firstChild: Container(),
                secondChild: Html(
                  data: feature.subtitle ?? "",
                  style: {
                    "p": Style(
                      fontSize: FontSize(14),
                      textAlign: TextAlign.justify,
                      textOverflow: TextOverflow.visible,
                    ),
                  },
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ForthSingleItem extends StatefulWidget {
  final PropreneurExperienceModel? propreneurExperience;

  const ForthSingleItem({Key? key, this.propreneurExperience}) : super(key: key);

  @override
  State<ForthSingleItem> createState() => _ForthSingleItemState();
}

class _ForthSingleItemState extends State<ForthSingleItem> {
  int? expandedIndex; // To track which item is open

  @override
  Widget build(BuildContext context) {
    var features = widget.propreneurExperience?.data.fourth.features ?? [];

    return Column(
      children: List.generate(features.length, (index) {
        var feature = features[index];
        bool isExpanded = expandedIndex == index;

        return Column(
          children: [
            // Header container (Clickable)
            GestureDetector(
              onTap: () {
                setState(() {
                  expandedIndex = isExpanded ? null : index;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.indigo,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${index + 1}.',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          feature.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Expandable Image Section
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Stack(
                  children: [
                    // Background Image
                    CustomImage(
                      imageUrl: feature.image ?? "",
                      fit: BoxFit.cover,
                      borderRadius: 10,
                      height: 300,
                      width: double.infinity,
                    ),

                    // Overlay for readability
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),

                    // Text on top
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Html(
                              data: feature.subtitle,
                              style: {
                                "p": Style(
                                  fontSize: FontSize(14),
                                  color: Colors.white,
                                  lineHeight: LineHeight(1.5),
                                ),
                                "h3": Style(
                                  fontSize: FontSize(16),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  margin:
                                  Margins.symmetric(vertical: 10),
                                ),
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),

            // Add spacing between containers
            if (index != features.length - 1)
              const SizedBox(height: 16),
          ],
        );
      }),
    );
  }
}
