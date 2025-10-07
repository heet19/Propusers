import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propusers/screens/about_us_screen.dart';
import 'package:propusers/screens/management_screen.dart';
import 'package:propusers/screens/neighbourhood_main_screen.dart';
import 'package:propusers/screens/privacy_policy_screen.dart';
import 'package:propusers/screens/profile_screen.dart';
import 'package:propusers/screens/terms_and_conditions_screen.dart';
import '../theme/theme.dart';
import '../widgets/app_bar.dart';
import '../widgets/search_bar_widget.dart';

class MoreScreen extends StatefulWidget {

  final Function(int)? changeTab;
  MoreScreen({this.changeTab});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  final List<Map<String, dynamic>> items = [
    {
      "svgPath": "assets/icons/topcities.svg",
      "title": "Top Cities",
      "iconColor": const Color(0xFFF2C94C),
    },
    {
      "svgPath": "assets/icons/neighbourhood.svg",
      "title": "Neighbourhood",
      "iconColor": const Color(0xFFF2C94C),
      "route": NeighbourhoodMainScreen(),
    },
    {
      "svgPath": "assets/icons/loancalculator.svg",
      "title": "Loan Calculator",
      "iconColor": const Color(0xFFF2C94C),
    },
    {
      "svgPath": "assets/icons/rera.svg",
      "title": "RERA",
      "iconColor": const Color(0xFFF2C94C),
    },
    {
      "svgPath": "assets/icons/expertadvice.svg",
      "title": "Expert Advice",
      "iconColor": const Color(0xFFF2C94C),
    },
    {
      "svgPath": "assets/icons/legaladvice.svg",
      "title": "Legal Advice",
      "iconColor": const Color(0xFFF2C94C),
    },
    {
      "svgPath": "assets/icons/policypolicy.svg",
      "title": "Privacy Policy",
      "iconColor": const Color(0xFFF2C94C),
      "route": PrivacyPolicyScreen(),
    },
    {
      "svgPath": "assets/icons/termandcondition.svg",
      "title": "Terms & Conditions",
      "iconColor": const Color(0xFFF2C94C),
      "route": TermsAndConditionsScreen(),
    },
    {
      "svgPath": "assets/icons/propmakeover.svg",
      "title": "PropMakeover",
      "iconColor": const Color(0xFFF2C94C),
    },
    {
      "svgPath": "assets/icons/joinpropenure.svg",
      "title": "Join as Propreneur",
      "iconColor": const Color(0xFFF2C94C),
    },
    {
      "svgPath": "assets/icons/propcafe.svg",
      "title": "Prop Cafe",
      "iconColor": const Color(0xFFF2C94C),
    },
    {
      "svgPath": "assets/icons/propsamadhan.svg",
      "title": "Prop Samadhan",
      "iconColor": const Color(0xFFF2C94C),
    },
    {
      "svgPath": "assets/icons/joinpropenure.svg",
      "title": "Proprenuer",
      "iconColor": const Color(0xFFF2C94C),
    },
    {
      "svgPath": "assets/icons/about_us.svg",
      "title": "About Us",
      "iconColor": const Color(0xFFF2C94C),
      "route": AboutUsScreen(),
    },
    {
      "svgPath": "assets/icons/management.svg",
      "title": "Management Team",
      "iconColor": const Color(0xFFF2C94C),
      "route": ManagementScreen(),
    },
    {
      "svgPath": "assets/icons/propsamadhan.svg",
      "title": "Settings",
      "iconColor": const Color(0xFFF2C94C),
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter items based on search query
    List<Map<String, dynamic>> filteredItems = items
        .where(
          (item) =>item["title"].toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar:  CustomAppBar(
        backgroundColor: AppColors.primary,
        leadingWidth: 50,
        leading: GestureDetector(
          onTap: () {
            print("Back Icon Clicked..");
            if (widget.changeTab != null) widget.changeTab!(0);
          },
          child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: Icon(Icons.arrow_back)
          ),
        ),
        title: "More",
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.accent),
            onPressed: () {
              print("Notifications clicked");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Notification Clicked..."),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              print("Profile image clicked");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: Container(
              width: 35,
              height: 35,
              margin: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/squarelogo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Container(
        width: double.infinity,
        color: AppColors.background,
        child: Column(
          children: [
            imageSearchContainer(),
            SizedBox(height: 10),
            Expanded(
              child: filteredItems.isEmpty
                  ? Center(
                      child: Text(
                        "No results found",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : MoreListGrid(items: filteredItems),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageSearchContainer() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/more_screen_image.jpg',
                fit: BoxFit.cover,
                height: 180,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: -25,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SearchBarWidget(
                controller: searchController,
                hintText: "Search",
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoreListItem extends StatelessWidget {
  final String svgPath;
  final String title;
  final Color? iconColor;
  final VoidCallback? onTap;

  const MoreListItem({
    Key? key,
    required this.svgPath,
    required this.title,
    this.iconColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.5, color: const Color(0xFFF2DCA2)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgPath,
                height: 40,
                width: 40,
                color: iconColor,
                colorFilter: iconColor != null
                    ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                    : null,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D1B2A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoreListGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const MoreListGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return MoreListItem(
            svgPath: item["svgPath"],
            title: item["title"],
            iconColor: item["iconColor"],
            onTap: () {
              debugPrint("Tapped on ${item['title']}");

              if (item["route"] != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item["route"]),
                );
              } else {
                debugPrint("No screen defined for ${item['title']}");
              }
            },
          );
        },
      ),
    );
  }
}
