import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:propusers/models/management_models/management_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/theme.dart';
import '../widgets/app_bar.dart';
import 'management_screen.dart';

class MemberDetailScreen extends StatefulWidget {
  final TeamMember member;

  const MemberDetailScreen({super.key, required this.member});

  @override
  State<MemberDetailScreen> createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends State<MemberDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final member = widget.member; //  make it accessible inside build()

    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.primary,
        title: member.name ?? "Unknown",
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

      body: scrollingContainer(),
    );
  }

  Widget scrollingContainer() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
        child: Column(
            children: [
              imageContainer(),
              SizedBox(height: 10),
              introRow(),
              SizedBox(height: 10),
              descriptionText(),
              SizedBox(height: 10),
              contactItems(),
              SizedBox(height: 10),
            ]
        )
    );
  }

  Widget imageContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: BoxBorder.all(
            width: 1,
            style: BorderStyle.solid,
            color: Colors.black
        ),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: CustomCachedImage(
        imageUrl: widget.member.avatar ?? '',
        height: 250,
        width: 250,
        fit: BoxFit.contain,
        borderRadius: 100,
      ),
    );
  }

  Widget nameDesignationColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            widget.member.name ?? 'Unknown',
            color: Colors.black,
            weight: FontWeight.bold,
            size: 18,
            maxLines: 2,
          ),
          SizedBox(height: 10),
          CustomText(
            widget.member.designation ?? 'No designation',
            color: Colors.grey,
            weight: FontWeight.w600,
            size: 16,
            maxLines: 2,
          ),
        ],
    );
  }

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

  Widget socialIconRow() {
    final List<String> svgIconNames = ['facebook', 'instagram', 'x', 'linkedin'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: svgIconNames.map((iconName) {
        // Determine link based on icon
        String? link;
        switch (iconName.toLowerCase()) {
          case 'facebook':
            link = widget.member?.fbLink;
            break;
          case 'instagram':
            link = widget.member?.instaLink;
            break;
          case 'x':
            link = widget.member?.twitterLink;
            break;
          case 'linkedin':
            link = widget.member?.linkedin;
            break;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
            onTap: () => _launchURL(link),
            child: CustomSvgIcon(iconName: iconName, size: 30),
          ),
        );
      }).toList(),
    );
  }

  Widget introRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        nameDesignationColumn(),
        socialIconRow()
      ],
    );
  }

  Widget descriptionText() {
    return Html(
      data: widget.member.description ?? 'No Description',
      style: {
        "p": Style(
          fontSize: FontSize(16),
          color: Colors.black,
          lineHeight: LineHeight(1.5),
          textAlign: TextAlign.justify
        ),
        "h3": Style(
          fontSize: FontSize(18),
          fontWeight: FontWeight.bold,
          color: Colors.black,
          margin: Margins.symmetric(vertical: 10),
        ),
      },
    );
  }

// Launch Email (with fallback to Gmail web)
  Future<void> _launchEmail(String? email) async {
    if (email == null || email.isEmpty) {
      print("Email not available");
      return;
    }

    final Uri emailUri = Uri(scheme: 'mailto', path: email.trim());
    try {
      if (!await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
        // Fallback to Gmail web compose
        final gmailUri = Uri.parse(
            "https://mail.google.com/mail/?view=cm&fs=1&to=${email.trim()}");
        if (!await launchUrl(gmailUri, mode: LaunchMode.externalApplication)) {
          await launchUrl(gmailUri, mode: LaunchMode.inAppBrowserView);
        }
      }
    } catch (e) {
      print("Could not launch email for $email — $e");
    }
  }

// Launch Phone (with fallback to Snackbar)
  Future<void> _launchPhone(String? phone) async {
    if (phone == null || phone.isEmpty) {
      print("Phone number not available");
      return;
    }

    final Uri phoneUri = Uri(scheme: 'tel', path: phone.trim());
    try {
      if (!await launchUrl(phoneUri, mode: LaunchMode.externalApplication)) {
        // fallback: show message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No dialer app available to call $phone")),
        );
      }
    } catch (e) {
      print("Could not launch phone for $phone — $e");
    }
  }

  Widget contactItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContactItem(
          icon: Icon(Icons.email, color: Colors.blue),
          text: widget.member.email ?? 'No E-mail Found',
          onTap: () {
            print("Email clicked!");
            _launchEmail(widget.member.email);
            // You can also launch mailto link
          },
        ),
        SizedBox(height: 12),
        ContactItem(
          icon: Icon(Icons.phone_in_talk, color: Colors.blue),
          text: widget.member.contact ?? 'No Contact Found',
          onTap: () {
            print("Phone clicked!");
            _launchPhone(widget.member.contact);
            // You can launch tel: link here
          },
        ),
      ],
    );
  }

}


class ContactItem extends StatelessWidget {
  final Widget icon; // Can pass Icon, Svg, or any Widget
  final String text;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final double spacing;

  const ContactItem({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
    this.textStyle,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Make the text (or entire row) clickable
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: spacing),
          Flexible(
            child: Text(
              text,
              style: textStyle ??
                  TextStyle(
                    color: Colors.black, // default clickable color
                    fontSize: 16,
                    decoration: onTap != null
                        ? TextDecoration.none
                        : TextDecoration.none,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
