import 'package:flutter/material.dart';
import 'package:propusers/screens/profile_screen.dart';

import '../theme/theme.dart';
import '../widgets/app_bar.dart';

class PropusersScreen extends StatefulWidget {
  @override
  State<PropusersScreen> createState() => _PropusersScreenState();
}

class _PropusersScreenState extends State<PropusersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.primary,
        leadingWidth: 50,
        leading: GestureDetector(
          onTap: () {
            print("Menu Clicked..");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Menu Clicked..."),
                backgroundColor: Colors.green,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/squarelogo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        title: "Propusers",
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
          "Propusers Screen",
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
