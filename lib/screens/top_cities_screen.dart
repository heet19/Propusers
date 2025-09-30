import 'package:flutter/material.dart';
import 'package:propusers/screens/profile_screen.dart';

import '../theme/theme.dart';
import '../widgets/app_bar.dart';

class TopCitiesScreen extends StatefulWidget {

  final Function(int)? changeTab;
  TopCitiesScreen({this.changeTab});

  @override
  State<TopCitiesScreen> createState() => _TopCitiesScreenState();
}

class _TopCitiesScreenState extends State<TopCitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
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
        title: "Top Cities",
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

      body: Center(
        child: Text(
          "Top Cities Screen",
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
