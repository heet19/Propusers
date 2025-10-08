import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propusers/models/office_locations_models/office_locations_model.dart';

import '../services/remote_service.dart';
import '../theme/theme.dart';
import '../utils/format_coordinates.dart';
import '../widgets/app_bar.dart';

class OfficeLocationScreen extends StatefulWidget {
  @override
  State<OfficeLocationScreen> createState() => _OfficeLocationScreenState();
}

class _OfficeLocationScreenState extends State<OfficeLocationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  OfficeLocationModel? officeLocation;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 tabs
    getData();
  }

  Future<void> getData() async {
    officeLocation = await RemoteService().getOfficeLocations();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      // show loader until API ready
      return Scaffold(
        appBar: CustomAppBar(
          backgroundColor: AppColors.primary,
          title: "Office Location",
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
        preferredSize: Size.fromHeight(120), // CustomAppBar + TabBar height
        child: Column(
          children: [
            CustomAppBar(
              backgroundColor: AppColors.primary,
              title: "Office Location",
              leadingWidth: 50,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
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
              tabs: const [
                Tab(text: "Headquarters"),
                Tab(text: "Regional Office"),
                Tab(text: "Multi Locations"),
              ],
            ),
          ],
        ),
      ),

      body: isLoaded
          ? TabBarView(
              controller: _tabController,
              children: [
                headquartersLocationSection(),
                regionalLocationSection(),
                multiLocationSection(),
              ],
            )
          : Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }

  Widget headquartersLocationSection() {
    var headquartersLocation = officeLocation?.headquaters;

    if (headquartersLocation == null || headquartersLocation.isEmpty) {
      return Center(
        child: CustomText(
          "No Headquarters Office Locations Found",
          size: 16,
          color: Colors.grey,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: headquartersLocation.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12,),
        itemBuilder: (context, index) {
          final location = headquartersLocation[index];
          return ReusableCard(
            company: location.company ?? "Unknown",
            address: location.address ?? "No address found",
            phone: "Phone: ${location.phone ?? "No Phone No.Found"}",
            email: "Email: ${location.email ?? "No E-mail Found"}",
            latlng: "Lat/Lng: ${formatCoordinates(
              double.tryParse(location.latitude.toString()),
              double.tryParse(location.longitude.toString()),
            )}",
            iconName: 'location',
          );
        },
      ),
    );
  }

  Widget regionalLocationSection() {
    var regionalLocation = officeLocation?.regional;

    if (regionalLocation == null || regionalLocation.isEmpty) {
      return Center(
        child: CustomText(
          "No Regional Office Locations Found",
          size: 16,
          color: Colors.grey,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: regionalLocation.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12,),
        itemBuilder: (context, index) {
          final location = regionalLocation[index];
          return ReusableCard(
            company: location.company ?? "Unknown",
            address: location.address ?? "No address found",
            phone: "Phone: ${location.phone ?? "No Phone No.Found"}",
            email: "Email: ${location.email ?? "No E-mail Found"}",
            latlng: "Lat/Lng: ${formatCoordinates(
              double.tryParse(location.latitude.toString()),
              double.tryParse(location.longitude.toString()),
            )}",
            iconName: 'location',
          );
        },
      ),
    );
  }

  Widget multiLocationSection() {
    var multiLocation = officeLocation?.multi;

    if (multiLocation == null || multiLocation.isEmpty) {
      return Center(
        child: CustomText(
          "No Multi Office Locations Found",
          size: 16,
          color: Colors.grey,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: multiLocation.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12,),
        itemBuilder: (context, index) {
          final location = multiLocation[index];
          return ReusableCard(
            company: location.company ?? "Unknown",
            address: location.address ?? "No address found",
            phone: "Phone: ${location.phone ?? "No Phone No.Found"}",
            email: "Email: ${location.email ?? "No E-mail Found"}",
            latlng: "Lat/Lng: ${formatCoordinates(
              double.tryParse(location.latitude.toString()),
              double.tryParse(location.longitude.toString()),
            )}",
            iconName: 'location',
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

class ReusableCard extends StatelessWidget {
  final String company;
  final String address;
  final String phone;
  final String email;
  final String latlng;
  final String? iconName;

  const ReusableCard({
    super.key,
    required this.company,
    required this.address,
    required this.phone,
    required this.email,
    required this.latlng,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // company
                  CustomText(
                    company,
                    color: Colors.black,
                    weight: FontWeight.bold,
                    size: 16,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // address
                  Html(
                    data: address,
                    style: {
                      "p": Style(
                        fontSize: FontSize(12),
                        color: Colors.black,
                        textAlign: TextAlign.start,
                      ),
                      "h3": Style(
                        fontSize: FontSize(14),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    },
                  ),
                  const SizedBox(height: 4),
                  //  phone
                  CustomText(
                    phone,
                    size: 12,
                    color: Colors.black,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  //  email
                  CustomText(
                    email,
                    size: 12,
                    color: Colors.black,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  //  latitude/longitude
                  CustomText(
                    latlng,
                    size: 12,
                    color: Colors.black,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (iconName != null && iconName!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomSvgIcon(
                  iconName: iconName!,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
