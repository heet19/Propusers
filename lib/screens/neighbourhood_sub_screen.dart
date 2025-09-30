import 'package:flutter_svg/svg.dart';
import 'package:propusers/screens/neighbourhood_detail_screen.dart';
import 'package:propusers/services/remote_service.dart';

import '../models/neighbourhood_models/neighbourhood_localities_model.dart';
import '../theme/theme.dart';
import 'package:flutter/material.dart';

import '../utils/format_coordinates.dart';
import '../widgets/search_bar_widget.dart';

class NeighbourhoodSubScreen extends StatefulWidget {
  final String cityId;

  const NeighbourhoodSubScreen({Key? key, required this.cityId})
    : super(key: key);

  @override
  State<NeighbourhoodSubScreen> createState() => _NeighbourhoodSubScreenState();
}

class _NeighbourhoodSubScreenState extends State<NeighbourhoodSubScreen> {
  final RemoteService apiService = RemoteService();
  List<LocalitiesData> localities = [];
  CityData? cityData;

  bool isLoadingLocalities = true;

  //  Search controller
  TextEditingController searchController = TextEditingController();
  List<LocalitiesData> filteredLocalities = [];

  @override
  void initState() {
    super.initState();
    fetchLocalities(int.tryParse(widget.cityId) ?? 0);
  }

  Future<void> fetchLocalities(int city_id) async {
    setState(() => isLoadingLocalities = true);
    final model = await apiService.getNeighbourhoodLocalities(
      city_id.toString(),
    );
    if (model != null) {
      localities = model.data;

      localities.sort(
        (a, b) => a.locality_name.toLowerCase().compareTo(
          b.locality_name.toLowerCase(),
        ),
      );

      filteredLocalities = List.from(localities); // initially show all
      cityData = model.cityData;
    }
    setState(() => isLoadingLocalities = false);
  }

  void filterLocalities(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredLocalities = List.from(localities);
      });
    } else {
      setState(() {
        filteredLocalities = localities
            .where(
              (loc) =>
                  loc.locality_name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
        filteredLocalities.sort(
          (a, b) => a.locality_name.toLowerCase().compareTo(
            b.locality_name.toLowerCase(),
          ),
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
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),

        title: Text(cityData?.city_name ?? "City Name"),
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
            imageSearchContainer(
              cityData?.city_image ?? "assets/images/neighbourhooddetails.jpg",
              "Search ${cityData?.city_name ?? "City Name"}'s Locality...",
              searchController,
              filterLocalities,
              cityData?.city_name ?? "City Name",
              cityData?.lat ?? 00.0000,
              cityData?.lng ?? 00.0000,
            ),
            const SizedBox(height: 40),
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
            NeighbourhoodSubCardGridView(localities: filteredLocalities),
          ],
        ),
      ),
    );
  }

  Widget imageSearchContainer(
    String imagePath,
    String hintTitle,
    TextEditingController controller,
    Function(String) onSearch,
    String cityName,
    double lat,
    double lng,
  ) {
    return Container(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            elevation: 8,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
                height: 180,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                ),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                                progress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),

          // Overlay gradient for readability
          Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Positioned texts
          Positioned(
            left: 20,
            top: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // City Guides
                RichText(
                  text: TextSpan(
                    text: "$cityName ",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    children: const [
                      TextSpan(
                        text: "Guides",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 40, height: 1, color: AppColors.primary),
              ],
            ),
          ),

          // Lat Long pill
          Positioned(
            bottom: 50,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    formatCoordinates(lat, lng),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Explore",
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  cityName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: 20,
            right: 20,
            bottom: -25,
            child: Row(
              children: [
                // Search bar
                Expanded(
                  child: SearchBarWidget(
                    controller: searchController,
                    hintText:
                        "Search ${cityData?.city_name ?? 'City'} Localities...",
                    onChanged: filterLocalities,
                  ),
                ),

                const SizedBox(width: 10),

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
}

class neighbourhoodSubGridViewCardItem extends StatelessWidget {
  final String cityName;
  final String imagePath;
  final String title;
  final double? latitude;
  final double? logitude;

  const neighbourhoodSubGridViewCardItem({
    Key? key,
    required this.cityName,
    required this.imagePath,
    required this.title,
    required this.latitude,
    required this.logitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Stack(
        children: [
          Image.network(
            imagePath,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 50, color: Colors.grey),
            ),
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
                  title,
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
                        formatCoordinates(null, logitude),
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

class NeighbourhoodSubCardGridView extends StatelessWidget {
  final List<LocalitiesData> localities;

  const NeighbourhoodSubCardGridView({Key? key, required this.localities})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (localities.isEmpty) {
      return const Center(child: Text("No localities found"));
    }

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(12),
      itemCount: localities.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final localitiesData = localities[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NeighbourhoodDetailScreen(
                  cityId: localitiesData.id.toString(),
                ),
              ),
            );
          },
          child: neighbourhoodSubGridViewCardItem(
            cityName: localitiesData.city_name,
            imagePath: localitiesData.locality_image,
            title: localitiesData.locality_name,
            latitude: localitiesData.latitude,
            logitude: localitiesData.logitude,
          ),
        );
      },
    );
  }
}
