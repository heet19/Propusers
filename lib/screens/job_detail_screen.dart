import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/career_models/job_model.dart';
import '../services/remote_service.dart';
import '../theme/theme.dart';
import '../widgets/app_bar.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';

class JobDetailScreen extends StatefulWidget {
  final String slug;

  const JobDetailScreen({Key? key, required this.slug}) : super(key: key);

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  JobDetailModel? jobDetail;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    jobDetail = await RemoteService().fetchJobDetail(widget.slug);
    if (jobDetail != null) {
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
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Icon(Icons.arrow_back),
          ),
        ),
        title: jobDetail?.data.job.title ?? "Job Detail",
      ),
      body: isLoaded
          ? Container(color: AppColors.background, child: scrollingContainer())
          : Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }

  Widget scrollingContainer() {
    final job = jobDetail!.data.job;
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            aboutCompany(job.company, job.description),
            SizedBox(height: 10,),
            roleResponsibilities(job.jobResponsibilities),
            SizedBox(height: 10,),
            yourQualification(job.educationalRequirements),
            SizedBox(height: 10,),
            keySkills(job.skills),
            SizedBox(height: 10,),
            jobDetails(job.team, job.title, "${job.experience} Years", job.salary, job.openings, job.jobType, job.citiesName.join(' | ')),
            SizedBox(height: 20,),
            // In scrollingContainer() method, replace the CareerApplicationForm:
            CareerApplicationForm(
              position: job.title,
              locationList: job.citiesName,
              jobId: job.id.toString(), // Add job ID
              cities: job.citiesName, // Add cities data (adjust based on your model)
            )
          ],
        ),
      ),
    );
  }

  Widget aboutCompany(aboutText, jobText) {
    return ReusableCard(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          TitleLayout(titleText: 'About Company', size: 20, weight: FontWeight.bold, overflow: TextOverflow.visible, align: TextAlign.start,),
          SizedBox(height: 10,),
          Html(
            data: aboutText,
            style: {
              "p": Style(fontSize: FontSize(16), lineHeight: LineHeight(1.5)),
              "h3": Style(
                fontSize: FontSize(18),
                fontWeight: FontWeight.bold,
                margin: Margins.symmetric(vertical: 10),
                textAlign: TextAlign.justify,
                textOverflow: TextOverflow.visible
              ),
            },
          ),
          SizedBox(height: 20,),
          TitleLayout(titleText: 'Job Description', size: 20, weight: FontWeight.bold, overflow: TextOverflow.visible, align: TextAlign.start,),
          SizedBox(height: 10,),
          Html(
            data: jobText,
            style: {
              "p": Style(fontSize: FontSize(16), lineHeight: LineHeight(1.5)),
              "h3": Style(
                  fontSize: FontSize(18),
                  fontWeight: FontWeight.bold,
                  margin: Margins.symmetric(vertical: 10),
                  textAlign: TextAlign.justify,
                  textOverflow: TextOverflow.visible
              ),
            },
          ),
        ],
      ),
    );
  }

  Widget roleResponsibilities(roleText) {
    return ReusableCard(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          TitleLayout(titleText: 'Your Role/Responsibilities', size: 20, weight: FontWeight.bold, overflow: TextOverflow.visible, align: TextAlign.start,),
          SizedBox(height: 10,),
          Html(
            data: roleText,
            style: {
              "p": Style(fontSize: FontSize(16), lineHeight: LineHeight(1.5)),
              "h3": Style(
                  fontSize: FontSize(18),
                  fontWeight: FontWeight.bold,
                  margin: Margins.symmetric(vertical: 10),
                  textAlign: TextAlign.justify,
                  textOverflow: TextOverflow.visible
              ),
            },
          ),

        ],
      ),
    );
  }

  Widget yourQualification(qualificationText) {
    return ReusableCard(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          TitleLayout(titleText: 'Your Qualification', size: 20, weight: FontWeight.bold, overflow: TextOverflow.visible, align: TextAlign.start,),
          SizedBox(height: 10,),
          Html(
            data: qualificationText,
            style: {
              "p": Style(fontSize: FontSize(16), lineHeight: LineHeight(1.5)),
              "h3": Style(
                  fontSize: FontSize(18),
                  fontWeight: FontWeight.bold,
                  margin: Margins.symmetric(vertical: 10),
                  textAlign: TextAlign.justify,
                  textOverflow: TextOverflow.visible
              ),
            },
          ),

        ],
      ),
    );
  }

  Widget keySkills(keySkillText) {
    return ReusableCard(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          TitleLayout(titleText: 'Key Skills', size: 20, weight: FontWeight.bold, overflow: TextOverflow.visible, align: TextAlign.start,),
          SizedBox(height: 10,),
          SkillsChips(skillsString: keySkillText,)
        ],
      ),
    );
  }

  Widget jobDetails(teamText, jobText, experienceText, salaryText, openingText, jobTypeText, locationText) {
    return ReusableCard(
      backgroundColor: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleLayout(titleText: 'Team', size: 20, weight: FontWeight.bold, overflow: TextOverflow.visible, align: TextAlign.start,),
          SizedBox(height: 10),
          CustomText(teamText, overflow: TextOverflow.visible, align: TextAlign.start),
          SizedBox(height: 20),
          TitleLayout(titleText: 'Job Role', size: 20, weight: FontWeight.bold, overflow: TextOverflow.visible, align: TextAlign.start,),
          SizedBox(height: 10),
          CustomText(jobText, overflow: TextOverflow.visible, align: TextAlign.start),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            IconNameRow(icon: Icons.shopping_bag_outlined, iconColor: AppColors.primary, name: experienceText),
            IconNameRow(icon: Icons.currency_rupee, iconColor: AppColors.primary, name: salaryText),
          ],),
          SizedBox(height: 20),
          TitleLayout(titleText: 'Total Openings', size: 20, weight: FontWeight.bold, overflow: TextOverflow.visible, align: TextAlign.start,),
          SizedBox(height: 10),
          CustomText(openingText, overflow: TextOverflow.visible, align: TextAlign.start),
          SizedBox(height: 20),
          jobTypePill(jobTypeText),
          SizedBox(height: 20),
          TitleLayout(titleText: 'Location', size: 20, weight: FontWeight.bold, overflow: TextOverflow.visible, align: TextAlign.start,),
          SizedBox(height: 10),
          IconNameRow(icon: Icons.location_on_outlined, iconColor: AppColors.primary, name: locationText),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget jobTypePill(String jobType) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFFEF7E9), // Light cream background like your image
        borderRadius: BorderRadius.circular(20), // Rounded pill shape
      ),
      child: Text(
        jobType,
        style: TextStyle(
          color: Colors.black87, // Dark text
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
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

class ReusableCard extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;
  final EdgeInsets? padding;
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

class TitleLayout extends StatelessWidget {
  final String titleText;

  // All CustomText properties
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? height;

  // TitleLayout-specific properties
  final double? lineWidth;
  final double? lineHeight;
  final Color? lineColor;
  final EdgeInsets? padding;

  const TitleLayout({
    Key? key,
    required this.titleText,
    this.color,
    this.size,
    this.weight,
    this.align,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.lineWidth = 100,
    this.lineHeight = 3,
    this.lineColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            titleText,
            color: color,
            size: size,
            weight: weight,
            align: align,
            maxLines: maxLines,
            overflow: overflow,
            letterSpacing: letterSpacing,
            height: height,
          ),
          Container(
            height: lineHeight,
            width: lineWidth,
            color: lineColor ?? AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double borderRadius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Widget? errorWidget;

  const CustomImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius = 12.0,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.errorWidget,
  }) : super(key: key);

  bool get _isNetwork =>
      imageUrl != null &&
          (imageUrl!.startsWith('http://') || imageUrl!.startsWith('https://'));

  bool get _hasImage => imageUrl != null && imageUrl!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    //  If no image URL, return empty SizedBox
    if (!_hasImage) return const SizedBox.shrink();

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: _isNetwork
            ? Image.network(
          imageUrl!,
          height: height,
          width: width,
          fit: fit,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) =>
          errorWidget ?? const SizedBox.shrink(), // No fallback shown
        )
            : Image.asset(imageUrl!, height: height, width: width, fit: fit),
      ),
    );
  }
}

class Feature {
  final String? title;
  final String? subtitle;

  Feature({this.title, this.subtitle});
}

class IconNameRow extends StatelessWidget {
  final IconData icon;
  final String name;
  final double iconSize;
  final Color iconColor;
  final TextStyle? textStyle;
  final double spacing;

  const IconNameRow({
    super.key,
    required this.icon,
    required this.name,
    this.iconSize = 24,
    this.iconColor = Colors.black,
    this.textStyle,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
        SizedBox(width: spacing),
        Text(
          name,
          style: textStyle ??
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}

class SkillsChips extends StatelessWidget {
  final String skillsString;

  const SkillsChips({super.key, required this.skillsString});

  @override
  Widget build(BuildContext context) {
    // Split the API string into individual skills
    final List<String> skills = skillsString.split(',').map((s) => s.trim()).toList();

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: skills.map((skill) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7E9), // light beige color from image
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconNameRow(
            icon: Icons.star,
            iconSize: 16,
            iconColor: const Color(0xFF0A2540), // dark blue from image
            name: skill,
            textStyle: const TextStyle(
              color: Color(0xFF0A2540),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            spacing: 6,
          ),
        );
      }).toList(),
    );
  }
}


// -----------------------------
// APPLICATION FORM WIDGET
// -----------------------------
class CareerApplicationForm extends StatefulWidget {
  final String position;
  final List<String> locationList;
  final String jobId; // Add this
  final List<dynamic> cities; // Add this to get city IDs

  const CareerApplicationForm({
    super.key,
    required this.position,
    required this.locationList,
    required this.jobId, // Add this
    required this.cities, // Add this
  });

  @override
  State<CareerApplicationForm> createState() => _CareerApplicationFormState();
}

class _CareerApplicationFormState extends State<CareerApplicationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController referralController = TextEditingController();

  String? selectedLocation;
  String? fileName;
  PlatformFile? selectedFile;
  bool isSubmitting = false;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.first;
        fileName = selectedFile!.name;
      });
    } else {
      setState(() {
        fileName = null;
        selectedFile = null;
      });
    }
  }

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload your resume (PDF/DOCX)')),
      );
      return;
    }

    if (selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a location')),
      );
      return;
    }

    setState(() => isSubmitting = true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Submitting application...')),
    );

    // Find the city ID for the selected location
    String cityId = '';
    try {
      // Assuming your cities list contains objects with id and name
      // Adjust this based on your actual data structure  
      var selectedCity = widget.cities.firstWhere(
            (city) => city['name'] == selectedLocation,
        orElse: () => null,
      );
      cityId = selectedCity?['id']?.toString() ?? '';
    } catch (e) {
      print('Error finding city ID: $e');
    }

    final result = await RemoteService().submitCareerApplication(
      fname: nameController.text.trim(),
      referralBy: referralController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      position: widget.position,
      jobId: widget.jobId,
      cityId: cityId,
      location: selectedLocation!,
      resumeFile: File(selectedFile!.path!),
    );

    setState(() => isSubmitting = false);

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Application submitted successfully!')),
      );

      _formKey.currentState!.reset();
      setState(() {
        selectedFile = null;
        fileName = null;
        selectedLocation = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed: ${result['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Discover Your New Career',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text('Great Opportunity!',
                  style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 20),

              _buildTextField('Name', nameController, TextInputType.name),
              const SizedBox(height: 12),

              _buildTextField(
                'Email ID',
                emailController,
                TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your email';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              _buildTextField(
                'Phone No.',
                phoneController,
                TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter phone number';
                  if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                    return 'Enter valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              _buildReadOnlyField("Position Applied For", widget.position),
              const SizedBox(height: 12),

              _buildDropdown<String>(
                "Location",
                selectedLocation,
                widget.locationList,
                    (value) => setState(() => selectedLocation = value),
              ),

              const SizedBox(height: 12),

              _buildTextField('Referral By', referralController, TextInputType.text,
                  requiredField: false),
              const SizedBox(height: 12),

              const Text(
                "Upload Resume (Only Pdf & Docx file)",
                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 45),
                ),
                icon: const Icon(Icons.attach_file, color: Colors.white),
                label: Text(
                  fileName ?? "Choose File",
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: isSubmitting ? null : pickFile,
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 45),
                ),
                onPressed: isSubmitting ? null : submitForm,
                child: isSubmitting
                    ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _buildTextField(
      String label, TextEditingController controller, TextInputType type,
      {String? Function(String?)? validator, bool requiredField = true}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      validator: validator ??
          (requiredField
              ? (value) =>
          value == null || value.isEmpty ? 'Please enter $label' : null
              : null),
    );
  }

  Widget _buildDropdown<T>(
      String label, T? currentValue, List<T> items, ValueChanged<T?> onChanged) {
    return DropdownButtonFormField<T>(
      value: currentValue,
      items: items
          .map((item) => DropdownMenuItem<T>(
        value: item,
        child: Text(item.toString()),
      ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      validator: (value) => value == null ? 'Please select $label' : null,
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}