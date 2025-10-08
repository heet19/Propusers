import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propusers/models/management_models/management_model.dart';
import 'package:propusers/screens/member_detail_screen.dart';
import 'package:propusers/services/remote_service.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/theme.dart';
import '../widgets/app_bar.dart';

class ManagementScreen extends StatefulWidget {
  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  ManagementTeamModel? managementTeam;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    managementTeam = await RemoteService().getManagementTeam();
    if (managementTeam != null &&
        managementTeam!.titles != null &&
        managementTeam!.titles!.isNotEmpty) {
      _tabController = TabController(
        length: managementTeam!.titles!.length,
        vsync: this,
      );
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded || _tabController == null) {
      // show loader until API + tabcontroller ready
      return Scaffold(
        appBar: CustomAppBar(
          backgroundColor: AppColors.primary,
          title: "Management",
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), // Height for CustomAppBar + TabBar
        child: Column(
          children: [
            CustomAppBar(
              backgroundColor: AppColors.primary,
              title: "Management",
              leadingWidth: 50,
              leading: GestureDetector(
                onTap: () {
                  print("Back Icon Clicked..");
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabs: managementTeam!.titles!
                  .map((title) => Tab(text: title.title ?? "Untitled"))
                  .toList(),
            ),
          ],
        ),
      ),

      body: isLoaded
          ? TabBarView(
              controller: _tabController,
              children: managementTeam!.titles!.asMap().entries.map((entry) {
                final index = entry.key;
                final title = entry.value;

                // Match tab index to team section
                List<TeamMember> teamList = [];
                if (index == 0) {
                  teamList = managementTeam?.staff ?? [];
                } else if (index == 1) {
                  teamList = managementTeam?.backend ?? [];
                } else if (index == 2) {
                  teamList = managementTeam?.lead ?? [];
                }

                return buildTeamSection(
                  teamMembers: teamList,
                  emptyMessage: "No ${title.title ?? 'members'} found",
                );
              }).toList(),
            )
          : Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }

  // Build Team Section with scrollable GridView
  Widget buildTeamSection({
    required List<TeamMember> teamMembers,
    required String emptyMessage,
  }) {
    if (teamMembers.isEmpty) {
      return Center(child: CustomText(emptyMessage, size: 16));
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: teamMembers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.65, // Adjust for flexible height
        ),
        itemBuilder: (context, index) {
          final member = teamMembers[index];
          return ReusableCard(
            imageUrl: member.avatar ?? '',
            name: member.name ?? 'Unknown',
            designation: member.designation ?? 'No designation',
            svgIconNames: ['facebook', 'instagram', 'x', 'linkedin'],
            member: member,
          );
        },
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

class CustomSvgIcon extends StatelessWidget {
  final String iconName;
  final double? size;
  final Color? color;
  final BoxFit fit;

  const CustomSvgIcon({
    Key? key,
    required this.iconName,
    this.size,
    this.color,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$iconName.svg',
      width: size ?? 24,
      height: size ?? 24,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      fit: fit,
    );
  }
}

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double borderRadius;
  final String errorAsset;
  final String nullAsset;

  const CustomCachedImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius = 8.0,
    this.errorAsset = 'assets/images/error.jpg', // fallback image
    this.nullAsset = 'assets/images/null.jpg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If imageUrl is null or empty, directly show errorAsset
    if (imageUrl == null || imageUrl!.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          nullAsset,
          height: height,
          width: width ?? double.infinity,
          fit: fit,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: height,
            width: width,
            color: Colors.grey.shade300,
          ),
        ),
        errorWidget: (context, url, error) =>
            Image.asset(errorAsset, height: height, width: width, fit: fit),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String designation;
  final List<String> svgIconNames; // List of 4 icon names (without .svg)
  final TeamMember? member; // pass member for links

  const ReusableCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.designation,
    required this.svgIconNames,
    this.member,
  });

  // Function to open link if available
  Future<void> _launchURL(String? url) async {
    if (url == null || url.isEmpty) {
      print("Link not available");
      return;
    }

    final Uri uri = Uri.parse(url);

    try {
      // Try external application first
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        // fallback: open in browser
        await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
      }
    } catch (e) {
      print("Could not launch $url — $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Tap on ${member?.name} card');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MemberDetailScreen(member: member!),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Flexible(
                flex: 8,
                child: CustomCachedImage(
                  imageUrl: imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              // Name
              Flexible(
                flex: 3,
                child: CustomText(
                  name,
                  color: AppColors.primary,
                  weight: FontWeight.bold,
                  size: 16,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 4),
              // Designation
              Flexible(
                flex: 2,
                child: CustomText(
                  designation,
                  size: 12,
                  color: Colors.grey,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 8),
              // SVG Icons Row
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: svgIconNames.map((iconName) {
                    // Determine link based on icon
                    String? link;
                    switch (iconName.toLowerCase()) {
                      case 'facebook':
                        link = member?.fbLink;
                        break;
                      case 'instagram':
                        link = member?.instaLink;
                        break;
                      case 'x':
                        link = member?.twitterLink;
                        break;
                      case 'linkedin':
                        link = member?.linkedin;
                        break;
                    }

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: GestureDetector(
                          onTap: () => _launchURL(link),
                          child: CustomSvgIcon(iconName: iconName, size: 24),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
