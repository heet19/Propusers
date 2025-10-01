import 'package:flutter_svg/svg.dart';
import 'package:propusers/models/neighbourhood_models/neighbourhood_model.dart';
import 'package:propusers/screens/neighbourhood_sub_screen.dart';

import '../services/remote_service.dart';
import '../theme/theme.dart';
import 'package:flutter/material.dart';

import '../utils/format_coordinates.dart';
import '../widgets/search_bar_widget.dart';

class NeighbourhoodMainScreen extends StatefulWidget {
  @override
  State<NeighbourhoodMainScreen> createState() =>
      _NeighbourhoodMainScreenState();
}

class _NeighbourhoodMainScreenState extends State<NeighbourhoodMainScreen> {
  NeighbourhoodModel? neighbourhood;
  bool isLoaded = false;

  //  Search
  TextEditingController searchController = TextEditingController();
  List<NeighbourhoodData> filteredData = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    neighbourhood = await RemoteService().getNeighbourhood();
    if (neighbourhood != null) {
      setState(() {
        isLoaded = true;
        neighbourhood!.data.sort(
          (a, b) =>
              a.city_name.toLowerCase().compareTo(b.city_name.toLowerCase()),
        );
        filteredData = List.from(neighbourhood!.data);
      });
    }
  }

  void filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredData = List.from(neighbourhood!.data);
      });
    } else {
      setState(() {
        filteredData = neighbourhood!.data
            .where(
              (item) =>
                  item.city_name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
        filteredData.sort(
          (a, b) =>
              a.city_name.toLowerCase().compareTo(b.city_name.toLowerCase()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leadingWidth: 30,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: Icon(Icons.arrow_back),
          ),
        ),
        title: Text("Neighbourhood"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.accent),
            onPressed: () {},
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
        width: double.infinity,
        color: AppColors.background,
        child: Column(
          children: [
            imageWithSearch(),
            SizedBox(height: 50),
            if (!isLoaded)
              const Center(child: CircularProgressIndicator())
            else
              scrollingContainer(filteredData),
          ],
        ),
      ),
    );
  }

  Widget imageWithSearch() {
    return Container(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            elevation: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
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
            child: Row(
              children: [
                //  Expanded search bar
                Expanded(
                  child: SearchBarWidget(
                    controller: searchController,
                    hintText: "Search city...",
                    onChanged: filterSearch,
                  ),
                ),
                const SizedBox(width: 10),
                //  Filter icon
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/icons/neighbourhoodfilter.svg',
                      fit: BoxFit.contain,
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

  Widget scrollingContainer(List<NeighbourhoodData> data) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            textAndViewAllRow(),
            SizedBox(height: 10),
            NeighbourhoodMainCardGridView(data: data),
          ],
        ),
      ),
    );
  }

  Widget textAndViewAllRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Explore ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Cities',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Text("View All", style: TextStyle(color: Colors.blue, fontSize: 17)),
        ],
      ),
    );
  }
}


Widget loadNetworkImage(
    String? path, {
      double? height,
      double? width,
      BoxFit? fit,
      String placeholderAsset = "assets/images/null.jpg",
      String errorAsset = "assets/images/error.jpg",
    }) {
  if (path == null || path.isEmpty) {
    // If path is null or empty, show placeholder
    return Image.asset(
      placeholderAsset,
      height: height,
      width: width,
      fit: fit,
    );
  }

  String fullPath = path.trim();
  print("Loading image: $fullPath");


  return Image.network(
    fullPath,
    height: height,
    width: width,
    fit: fit ?? BoxFit.cover,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      print("Failed to load: $fullPath, Error: $error");
      return Image.asset(
        errorAsset,
        height: height,
        width: width,
        fit: fit,
      );
    },
  );
}


class NeighbourhoodMainGridViewCardItem extends StatelessWidget {
  final String imagePath;
  final String cityName;
  final double latitude;
  final double longitude;

  const NeighbourhoodMainGridViewCardItem({
    Key? key,
    required this.imagePath,
    required this.cityName,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Stack(
        children: [
          // networkImage(
          //   imagePath,
          //   height: 200,
          //   width: double.infinity,
          //   fit: BoxFit.cover,
          // ),

          loadNetworkImage(
            imagePath,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

      Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cityName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 4),

                Container(height: 2, width: 155, color: Colors.white),

                SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        formatCoordinates(latitude, null),
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),

                    SizedBox(width: 10),

                    Container(height: 14, width: 2, color: Colors.white),

                    SizedBox(width: 10),

                    Flexible(
                      child: Text(
                        formatCoordinates(null, longitude),
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NeighbourhoodMainCardGridView extends StatelessWidget {
  final List<NeighbourhoodData> data;

  const NeighbourhoodMainCardGridView({Key? key, required this.data})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(12),
      itemCount: data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final place = data[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    NeighbourhoodSubScreen(citySlug: place.slug),
              ),
            );
            print("Tap to Localities ${place.slug}");
          },
          child: NeighbourhoodMainGridViewCardItem(
            imagePath: place.city_image,
            cityName: place.city_name,
            latitude: place.lat,
            longitude: place.lng,
          ),
        );
      },
    );
  }
}
