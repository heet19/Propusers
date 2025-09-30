import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:propusers/models/privacy_policy_models/privacy_policy_terms_and_conditions_model.dart';
import 'package:propusers/services/remote_service.dart';

import '../theme/theme.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  PrivacyPolicyTermsAndConditionsModel? privacyPolicy;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    privacyPolicy = await RemoteService().getPrivacyPolicy();
    if (privacyPolicy != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leadingWidth: 30,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        title: Text("Privacy Policy"),
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
      body: isLoaded
          ? SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              privacyPolicy!.pageName,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            Html(
              data: privacyPolicy!.content,
              style: {
                "p": Style(
                  fontSize: FontSize(16),
                  lineHeight: LineHeight(1.5),
                ),
                "h3": Style(
                  fontSize: FontSize(18),
                  fontWeight: FontWeight.bold,
                  margin: Margins.symmetric(vertical: 10),
                ),
              },
            ),
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
