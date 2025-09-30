import 'package:flutter/material.dart';
import 'package:propusers/screens/collection_screen.dart';
import 'package:propusers/screens/more_screen.dart';
import 'package:propusers/screens/propusers_screen.dart';
import 'package:propusers/screens/top_cities_screen.dart';
import 'package:propusers/theme/theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int myIndex = 0;

  void changeTab(int index) {
    setState(() {
      myIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      PropusersScreen(),
      TopCitiesScreen(changeTab: changeTab),
      CollectionScreen(changeTab: changeTab),
      MoreScreen(changeTab: changeTab),
    ];

    return Scaffold(
      body: IndexedStack(children: widgetList, index: myIndex,),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: myIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.window), label: "Profile"),
        ],
      ),
    );
  }
}
