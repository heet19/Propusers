import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';

import '../models/neighbourhood_models/neighbourhood_locality_model.dart';
import '../services/remote_service.dart';
import '../theme/theme.dart';
import 'package:flutter/material.dart';

import '../utils/format_coordinates.dart';

class NeighbourhoodDetailScreen extends StatefulWidget {
  final String citySlug;

  const NeighbourhoodDetailScreen({super.key, required this.citySlug});

  @override
  State<NeighbourhoodDetailScreen> createState() =>
      _NeighbourhoodDetailScreenState();
}

class _NeighbourhoodDetailScreenState extends State<NeighbourhoodDetailScreen> {
  LocalityData? localityData;
  List<Point> points = [];
  String cityName = "";
  String cityImage = "";
  bool isLoading = true;
  bool isError = false;

  final GlobalKey _infoCardKey = GlobalKey();
  double cardHeight = 0;

  @override
  void initState() {
    super.initState();
    fetchLocalityDetail();
  }

  Future<void> fetchLocalityDetail() async {
    try {
      final response = await RemoteService().getLocalityDetail(
        widget.citySlug,
      ); // API call
      if (response != null && response.data != null) {
        setState(() {
          localityData = response.data!;
          cityName = localityData?.localityName ?? "";
          cityImage = localityData?.locality_image ?? "";
          points = localityData?.points ?? [];
          isLoading = false;
        });

        WidgetsBinding.instance.addPostFrameCallback((_) =>
            _updateCardHeight());
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  void _updateCardHeight() {
    if (_infoCardKey.currentContext != null) {
      final RenderBox renderBox =
      _infoCardKey.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        cardHeight = renderBox.size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (isError || localityData == null) {
      return const Scaffold(body: Center(child: Text("Failed to load data")));
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leadingWidth: 30,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),

        title: Text(cityName.isNotEmpty ? cityName : "City Name"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.accent),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/squarelogo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),

      body: Container(
        color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            scrollingContainer(),
          ],
        ),
      ),
    );
  }

  Widget scrollingContainer() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            infoSection(),

            const SizedBox(height: 40),
            AboutContainerText(
              title: cityName,
              description: localityData!.description ?? "",
            ),
            SizedBox(height: 20),
            aroundText(
                "Around the ${localityData?.localityName ?? "Locality Name"}"),
            SizedBox(height: 40),
            aroundText(
              "10 Points of ${localityData?.localityName ?? "Locality Name"}",),
            SizedBox(height: 20),
            TenPointsOfAnyCity(points: points),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  sellRentButton(
                    "Homes for Sales in ${localityData?.localityName ??
                        "Locality Name"}",
                  ),
                  const SizedBox(width: 8),
                  sellRentButton(
                    "Homes for Rent in ${localityData?.localityName ??
                        "Locality Name"}",
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            TenPointImage(points: points),
            SizedBox(height: 30),
            aroundText("Other Neighbourhoods"),
            SizedBox(height: 10),
            Text("No Neighbourhood Available!"),
            SizedBox(height: 30),
            aroundText("Homes for Sale Near"),
            SizedBox(height: 10),
            Text("No Data Available"),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget infoSection() {
    return Stack(
      children: [
        //  Background Image
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3), // Dark overlay
            ),
            child: Image.network(
              cityImage,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
            ),
          ),
        ),

        // Overlay content
        Column(
          children: [
            // Top-left Welcome Text
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: RichText(
                  text: TextSpan(
                    text: "Welcome ",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: "to ${cityName.isNotEmpty ? cityName : "City"}",
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50), // spacing for card

            // Info Card
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: firstInfoCard(localityData!),
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ],
    );
  }
  }


  Widget firstInfoCard(LocalityData data) {
    final info = {
      "Country": "India",
      "State": data.state ?? "",
      "Division": data.division ?? "",
      "District": data.district ?? "",
      "District Population": data.district_population ?? "",
      "Coordinates": (data.latitude != null && data.longitude != null) ? formatCoordinates(data.latitude!, data.longitude!) : "",
      "Elevation": data.elevation ?? "",
      "Area": data.area ?? "",
      "City": data.city ?? "",
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber.withOpacity(0.6), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: info.entries.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    e.key,
                    style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    e.value.isNotEmpty ? e.value : "—",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget aroundText(String mainHeading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainHeading,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        Container(height: 3, width: 100, color: AppColors.primary),
      ],
    );
  }

  Widget sellRentButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: AppColors.accent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }


class AboutContainerText extends StatefulWidget {
  final String title;
  final String description;

  const AboutContainerText({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<AboutContainerText> createState() => _AboutContainerTextState();
}

class _AboutContainerTextState extends State<AboutContainerText> {
  bool isExpanded = false;
  late String collapsedText;
  bool showReadMore = false;

  @override
  void initState() {
    super.initState();
    collapsedText = _getCollapsedText(widget.description, 150); // 150 chars
    showReadMore = _needsReadMore(widget.description);
  }

  // Strip HTML and truncate
  String _getCollapsedText(String htmlString, int limit) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? '';
    if (parsedString.length <= limit) return parsedString;
    return parsedString.substring(0, limit) + "...";
  }

  // Check if text exceeds 3 lines
  bool _needsReadMore(String htmlString) {
    final document = parse(htmlString);
    final String text = parse(document.body?.text).documentElement?.text ?? '';

    // TextPainter measures the number of lines
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 14,
          height: 1, // lineHeight
        ),
      ),
      maxLines: 3,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 400); // maxWidth depends on your layout

    return textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Know About ${widget.title}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF0D1B2A),
            ),
          ),
          const SizedBox(height: 8),
          Html(
            data: isExpanded ? widget.description : collapsedText,
            style: {
              "body": Style(
                fontSize: FontSize(14),
                color: Colors.black87,
                lineHeight: LineHeight.number(1),
              ),
            },
          ),
          if (showReadMore) // Only show if needed
            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? "Read less" : "Read more",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final List<String> items;

  const InfoCard({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(height: 3, width: 100, color: AppColors.primary),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      item,
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TenPointsOfAnyCity extends StatefulWidget {
  final List<Point> points;

  const TenPointsOfAnyCity({super.key, required this.points});

  @override
  State<TenPointsOfAnyCity> createState() => _TenPointsOfAnyCityState();
}

class _TenPointsOfAnyCityState extends State<TenPointsOfAnyCity> {
  // Track expanded state for each description
  final Map<int, bool> expandedMap = {};

  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final visiblePoints = showAll
        ? widget.points.length
        : widget.points.length.clamp(
        0, 5); //  max 5, but not more than available

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visiblePoints,
          itemBuilder: (context, index) {
            final point = widget.points[index];
            final isExpanded = expandedMap[index] ?? false;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${index + 1}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          point.title ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Truncated description with ellipsis
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _stripHtmlTags(point.description ?? ""),
                                  maxLines: isExpanded ? null : 3,
                                  overflow: isExpanded
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    height: 1.3,
                                  ),
                                ),
                                if ((point.description ?? "").isNotEmpty)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        expandedMap[index] = !isExpanded;
                                      });
                                    },
                                    child: Text(
                                      isExpanded ? "See Less" : "See More",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 8),

        //  Bottom "See More Points / See Less Points"
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  showAll = !showAll;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              child: Text(
                showAll ? "See Less Points" : "See More Points",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///  Helper: remove HTML tags so we can safely show plain text
  String _stripHtmlTags(String htmlText) {
    final regex = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(regex, "");
  }
}


class TenPointImage extends StatefulWidget {
  final List<Point> points;

  const TenPointImage({super.key, required this.points});

  @override
  State<TenPointImage> createState() => _TenPointImageState();
}

class _TenPointImageState extends State<TenPointImage> {
  bool showAll = false;

  Widget networkImage(String? url, {double? height, double? width}) {
    if (url == null || url.isEmpty || url.contains("Image to be updated")) {
      return const SizedBox.shrink();
    }

    url = url.trim();

    return Image.network(
      url,
      height: height,
      width: width ?? double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox.shrink(); // also hide if error
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.points.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          "No points available.",
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ),
      );
    }

    final visiblePoints = showAll
        ? widget.points.length
        : widget.points.length.clamp(0, 5);


    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visiblePoints,
          itemBuilder: (context, index) {
            final point = widget.points[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: AppColors.primary,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${index + 1}".padLeft(2, '0'),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              point.title ?? "No Title Available",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 100,
                        child: SingleChildScrollView(
                          child: Html(
                            data: point.description ??
                                "No Description Available",
                            style: {
                              "body": Style(
                                fontSize: FontSize(14),
                                color: Colors.black87,
                                lineHeight: LineHeight.number(1.4),
                              ),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),

                // Image 1
                if (point.image_one != null &&
                    point.image_one!.isNotEmpty &&
                    !point.image_one!.contains("Image to be updated"))
                  networkImage(point.image_one),

                const SizedBox(height: 5),

                // Image 2 & 3 in row (only show if available)
                if ((point.image_two != null &&
                    point.image_two!.isNotEmpty &&
                    !point.image_two!.contains("Image to be updated")) ||
                    (point.image_three != null &&
                        point.image_three!.isNotEmpty &&
                        !point.image_three!.contains("Image to be updated")))
                  Row(
                    children: [
                      if (point.image_two != null &&
                          point.image_two!.isNotEmpty &&
                          !point.image_two!.contains("Image to be updated"))
                        Expanded(
                            child: networkImage(point.image_two, height: 180)),
                      if (point.image_two != null &&
                          point.image_two!.isNotEmpty &&
                          !point.image_two!.contains("Image to be updated") &&
                          point.image_three != null &&
                          point.image_three!.isNotEmpty &&
                          !point.image_three!.contains("Image to be updated"))
                        const SizedBox(width: 5),
                      if (point.image_three != null &&
                          point.image_three!.isNotEmpty &&
                          !point.image_three!.contains("Image to be updated"))
                        Expanded(child: networkImage(
                            point.image_three, height: 180)),
                    ],
                  ),

                const SizedBox(height: 5),

                // Image 4
                if (point.image_four != null &&
                    point.image_four!.isNotEmpty &&
                    !point.image_four!.contains("Image to be updated"))
                  networkImage(point.image_four),

                const SizedBox(height: 20),
              ],
            );
          },
        ),
        if (widget.points.length > 5)
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showAll = !showAll;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                child: Text(
                  showAll ? "See Less" : "See All",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}