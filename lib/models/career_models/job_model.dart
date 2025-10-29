class JobDetailModel {
  final bool success;
  final JobData data;

  JobDetailModel({
    required this.success,
    required this.data,
  });

  factory JobDetailModel.fromJson(Map<String, dynamic> json) {
    return JobDetailModel(
      success: json['success'] ?? false,
      data: JobData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

class JobData {
  final Job job;

  JobData({
    required this.job,
  });

  factory JobData.fromJson(Map<String, dynamic> json) {
    return JobData(
      job: Job.fromJson(json['job']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job': job.toJson(),
    };
  }
}

class Job {
  final int id;
  final int jcategoryId;
  final int languageId;
  final String title;
  final String slug;
  final int vacancy;
  final String company;
  final String description;
  final String experience;
  final String skills;
  final dynamic posts;
  final String team;
  final String jobResponsibilities;
  final dynamic employmentStatus;
  final String educationalRequirements;
  final String experienceRequirements;
  final dynamic additionalRequirements;
  final String jobLocation;
  final String salary;
  final String jobType;
  final dynamic readBeforeApply;
  final dynamic email;
  final String mapLink;
  final String openings;
  final int serialNumber;
  final dynamic metaKeywords;
  final dynamic metaDescription;
  final int status;
  final int popular;
  final dynamic createdAt;
  final String updatedAt;
  final List<String> citiesName;

  Job({
    required this.id,
    required this.jcategoryId,
    required this.languageId,
    required this.title,
    required this.slug,
    required this.vacancy,
    required this.company,
    required this.description,
    required this.experience,
    required this.skills,
    required this.posts,
    required this.team,
    required this.jobResponsibilities,
    required this.employmentStatus,
    required this.educationalRequirements,
    required this.experienceRequirements,
    required this.additionalRequirements,
    required this.jobLocation,
    required this.salary,
    required this.jobType,
    required this.readBeforeApply,
    required this.email,
    required this.mapLink,
    required this.openings,
    required this.serialNumber,
    required this.metaKeywords,
    required this.metaDescription,
    required this.status,
    required this.popular,
    required this.createdAt,
    required this.updatedAt,
    required this.citiesName,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] ?? 0,
      jcategoryId: json['jcategory_id'] ?? 0,
      languageId: json['language_id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      vacancy: json['vacancy'] ?? 0,
      company: json['company'] ?? '',
      description: json['description'] ?? '',
      experience: json['experience'] ?? '',
      skills: json['skills'] ?? '',
      posts: json['posts'],
      team: json['team'] ?? '',
      jobResponsibilities: json['job_responsibilities'] ?? '',
      employmentStatus: json['employment_status'],
      educationalRequirements: json['educational_requirements'] ?? '',
      experienceRequirements: json['experience_requirements'] ?? '',
      additionalRequirements: json['additional_requirements'],
      jobLocation: json['job_location'] ?? '',
      salary: json['salary'] ?? '',
      jobType: json['job_type'] ?? '',
      readBeforeApply: json['read_before_apply'],
      email: json['email'],
      mapLink: json['map_link'] ?? '',
      openings: json['openings'] ?? '',
      serialNumber: json['serial_number'] ?? 0,
      metaKeywords: json['meta_keywords'],
      metaDescription: json['meta_description'],
      status: json['status'] ?? 0,
      popular: json['popular'] ?? 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'] ?? '',
      citiesName: List<String>.from(json['cities_name'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jcategory_id': jcategoryId,
      'language_id': languageId,
      'title': title,
      'slug': slug,
      'vacancy': vacancy,
      'company': company,
      'description': description,
      'experience': experience,
      'skills': skills,
      'posts': posts,
      'team': team,
      'job_responsibilities': jobResponsibilities,
      'employment_status': employmentStatus,
      'educational_requirements': educationalRequirements,
      'experience_requirements': experienceRequirements,
      'additional_requirements': additionalRequirements,
      'job_location': jobLocation,
      'salary': salary,
      'job_type': jobType,
      'read_before_apply': readBeforeApply,
      'email': email,
      'map_link': mapLink,
      'openings': openings,
      'serial_number': serialNumber,
      'meta_keywords': metaKeywords,
      'meta_description': metaDescription,
      'status': status,
      'popular': popular,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'cities_name': citiesName,
    };
  }
}