import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propusers/models/contact_us_models/contact_us_model.dart';
import 'package:propusers/services/remote_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/theme.dart';
import '../widgets/app_bar.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  ContactUsModel? contactUs;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    contactUs = await RemoteService().getContactUs();
    if (contactUs != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.primary,
        leadingWidth: 50,
        leading: GestureDetector(
          onTap: () {
            print("Back Icon Clicked..");
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Icon(Icons.arrow_back),
          ),
        ),
        title: "Contact Us",
      ),

      body: isLoaded
          ? contactUsInformation()
          : Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }

  Widget contactUsScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          CustomText(
            contactUs!.titles.first.subtitle,
            size: 16,
            color: Colors.white,
            align: TextAlign.center,
            overflow: TextOverflow.visible,
            weight: FontWeight.w600,
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget contactUsInformation() {
    return FullScreenBackground(
      imageUrl: contactUs!.data.imageUrl, // API image URL
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            contactUsScreen(),
            ReusableCard(
              backgroundColor: AppColors.primary,
              borderRadius: 10,
              elevation: 5,
              padding: EdgeInsets.all(20),
              child: contactUsInformationChildren(),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactUsInformationChildren() {
    return Column(
      children: [
        CustomText(
          "Contact Information",
          color: AppColors.accent,
          size: 20,
          weight: FontWeight.bold,
          align: TextAlign.center,
        ),
        SizedBox(height: 20),
        CustomText(
          contactUs!.data.contactInfo,
          overflow: TextOverflow.visible,
          align: TextAlign.justify,
        ),
        SizedBox(height: 30),
        ContactUsInformationChildrenContactDetail(
          iconPath: "assets/icons/location.svg",
          iconSize: 20,
          headingText: "Our Corporate Address",
          descriptionText: contactUs!.data.contactAddresses,
          onDescriptionTap: () => _launchMap(contactUs!.data.contactAddresses),
        ),
        SizedBox(height: 20),
        ContactUsInformationChildrenContactDetail(
          iconPath: "assets/icons/mail_two.svg",
          iconSize: 20,
          headingText: "E-mail",
          descriptionText: contactUs!.data.contactMails,
          onDescriptionTap: () => _launchEmail(contactUs!.data.contactMails),
        ),
        SizedBox(height: 20),
        ContactUsInformationChildrenContactDetail(
          iconPath: "assets/icons/call.svg",
          iconSize: 20,
          headingText: "Call",
          descriptionTextWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (contactUs?.data.contactNumbers ?? "")
                .split(",") // split by comma
                .map((number) => number.trim()) // remove extra spaces
                .where((number) => number.isNotEmpty) // ignore empty strings
                .map(
                  (number) =>
                  GestureDetector(
                    onTap: () => _launchPhone(number),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: CustomText(number, color: AppColors.accent),
                    ),
                  ),
            )
                .toList(),
          ),
        ),
        SizedBox(height: 30),
        socialLink(),
      ],
    );
  }

  // Launch Map (with fallback to Map web)
  Future<void> _launchMap(String address) async {
    if (address == null || address.isEmpty) {
      print("Address not Available");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Address not Available')));
      return;
    }

    final Uri geoUri = Uri.parse('geo:0,0?q=${Uri.encodeComponent(address)}');
    final Uri webUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(
          address)}',
    );

    try {
      if (await canLaunchUrl(geoUri)) {
        await launchUrl(geoUri, mode: LaunchMode.externalApplication);
      } else
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print("Could not launch map for $address — $e");
    }
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
          "https://mail.google.com/mail/?view=cm&fs=1&to=${email.trim()}",
        );
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

  Widget socialLink() {
    return SocialLinkRow(
      links: [
        SocialLink(assetPath: "assets/icons/facebook_two.svg",
            url: "https://www.facebook.com/propuserscom",
            color: AppColors.accent),
        SocialLink(assetPath: "assets/icons/youtube.svg",
            url: "https://www.youtube.com/@propusers",
            color: AppColors.accent),
        SocialLink(assetPath: "assets/icons/x.svg",
            url: "https://x.com/RTNPropusers",
            color: AppColors.accent),
        SocialLink(assetPath: "assets/icons/instagram_two.svg",
            url: "https://www.instagram.com/propusers.com_/#",
            color: AppColors.accent),
        SocialLink(assetPath: "assets/icons/linkedin_two.svg",
            url: "https://www.linkedin.com/company/propusers-com/",
            color: AppColors.accent),
      ],
      iconSize: 25,
      spacing: 10,
    );
  }

}

class FullScreenBackground extends StatelessWidget {
  final String imageUrl;
  final Widget child;

  const FullScreenBackground({
    Key? key,
    required this.imageUrl,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.network(
            height: double.infinity,
            width: double.infinity,
            imageUrl,
            fit: BoxFit.cover,
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
            errorBuilder: (context, error, stackTrace) =>
                Container(color: Colors.grey.shade800),
          ),
        ),

        // Dark overlay
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
          ),
        ),

        // Foreground content
        SafeArea(child: child),
      ],
    );
  }
}

class ReusableCard extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double? elevation;

  const ReusableCard({
    Key? key,
    required this.backgroundColor,
    required this.child,
    this.padding,
    this.borderRadius = 16.0,
    this.elevation = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      elevation: elevation ?? 4.0,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: child,
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

  const CustomText(this.text, {
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

class ContactUsInformationChildrenContactDetail extends StatelessWidget {
  final String iconPath; // SVG asset path
  final String headingText; // Main heading
  final String? descriptionText; // Clickable text
  final Widget? descriptionTextWidget; // Optional custom widget
  final VoidCallback? onDescriptionTap; // Click action

  final Color? iconColor;
  final double? iconSize;
  final TextStyle? headingStyle;
  final TextStyle? descriptionStyle;

  const ContactUsInformationChildrenContactDetail({
    Key? key,
    required this.iconPath,
    required this.headingText,
    this.descriptionText,
    this.descriptionTextWidget,
    this.onDescriptionTap,
    this.iconColor,
    this.iconSize = 30,
    this.headingStyle,
    this.descriptionStyle,
  })
      : assert(
  descriptionText != null || descriptionTextWidget != null,
  'Either descriptionText or descriptionTextWidget must be provided.',
  ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SVG Icon
        SvgPicture.asset(
          iconPath,
          color: iconColor ?? AppColors.accent,
          height: iconSize,
          width: iconSize,
        ),
        const SizedBox(width: 12),

        // Column with heading + clickable text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                headingText,
                size: 16,
                weight: FontWeight.bold,
                color: AppColors.accent,
              ),
              const SizedBox(height: 4),
              descriptionTextWidget ??
                  GestureDetector(
                    onTap: onDescriptionTap,
                    child: CustomText(
                      descriptionText ?? '',
                      size: 14,
                      color: AppColors.accent,
                      align: TextAlign.justify,
                      overflow: TextOverflow.visible,
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

class SocialLinkRow extends StatelessWidget {
  final List<SocialLink> links; // List of social icons + URLs
  final double iconSize;
  final double spacing;

  const SocialLinkRow({
    Key? key,
    required this.links,
    this.iconSize = 40,
    this.spacing = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: links.map((link) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: GestureDetector(
            onTap: () => _launchURL(link.url),
            child: SvgPicture.asset(
              link.assetPath,
              height: iconSize,
              width: iconSize,
              color: link.color, // optional: can color icons
            ),
          ),
        );
      }).toList(),
    );
  }

  void _launchURL(String url) async {
    if (url == null || url.isEmpty) {
      print("No Social Found");
      return;
    }

    final Uri uri = Uri.parse(url);

    try {
      // First, try to launch as external application (prefers native app)
      bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (launched) {
        print("App opened for $url");
      } else {
        // If app launch fails, try launching in browser
        print("App not available, opening in browser");
        await launchUrl(
          uri,
          mode: LaunchMode.platformDefault,
        );
        print("Web opened for $url");
      }
    } catch (e) {
      print("Could not launch url for $url — $e");

      // Final fallback - try with platform default
      try {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      } catch (e) {
        print("All launch attempts failed for $url — $e");
      }
    }
  }
}

// Model class for social link
class SocialLink {
  final String assetPath; // SVG asset path
  final String url; // link to open
  final Color? color; // optional icon color

  SocialLink({required this.assetPath, required this.url, this.color});
}
