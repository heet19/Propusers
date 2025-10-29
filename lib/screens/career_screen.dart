import 'package:flutter/material.dart';
import 'package:propusers/screens/job_detail_screen.dart';
import 'package:propusers/services/remote_service.dart';
import '../models/career_models/career_model.dart';
import '../theme/theme.dart';
import '../widgets/app_bar.dart';

class CareerScreen extends StatefulWidget {
  @override
  State<CareerScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<CareerScreen> {
  late Future<CareerModel?> futureCareerData;

  @override
  void initState() {
    super.initState();
    futureCareerData = RemoteService.fetchCareerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.primary,
        leadingWidth: 50,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Icon(Icons.arrow_back),
          ),
        ),
        title: "Career",
      ),

      body: FutureBuilder<CareerModel?>(
        future: futureCareerData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No career data available"));
          }

          final careerData = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (careerData.intro.title != null)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      careerData.intro.title!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                if (careerData.jobs.jobPostings.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      careerData.jobs.title ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Build job list dynamically
                  ...careerData.jobs.jobPostings.map(
                        (job) => JobCard(
                      title: job.title,
                      company: "Propusers",
                      location: job.jobLocation ?? "",
                      jobTypes: jobTypes(job),
                      salary: job.salary ?? "",
                      onApply: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                JobDetailScreen(slug: job.slug),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  /// Converts job posting fields into a list of job types

  List<String> jobTypes(JobPosting job) {
    final List<String> types = [];

    // Check if job_type exists and add it
    if (job.jobType != null && job.jobType!.isNotEmpty) {
      types.add(job.jobType!);
    }

    return types;
  }


}

class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final List<String> jobTypes;
  final String salary;
  final VoidCallback onApply;

  const JobCard({
    Key? key,
    required this.title,
    required this.company,
    required this.location,
    required this.jobTypes,
    required this.salary,
    required this.onApply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F5FF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and title
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE082),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.campaign, color: Colors.amber, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      company,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            location,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Job type tags
          if (jobTypes.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: jobTypes.map((type) => _buildTag(type)).toList(),
            ),

          const SizedBox(height: 12),

          // Salary and Apply button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                salary,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              ElevatedButton(
                onPressed: onApply,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Apply Now",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
