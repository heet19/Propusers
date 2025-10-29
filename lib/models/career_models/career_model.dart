class CareerModel {
  final bool success;
  final Intro intro;
  final Value value;
  final OurValue ourValue;
  final Empowerment empowerment;
  final Award award;
  final LearnMore learnMore;
  final Trending trending;
  final Jobs jobs;
  final Counts counts;
  final List<CareerTitle> careerTitle;
  final FormHeading formheading;

  CareerModel({
    required this.success,
    required this.intro,
    required this.value,
    required this.ourValue,
    required this.empowerment,
    required this.award,
    required this.learnMore,
    required this.trending,
    required this.jobs,
    required this.counts,
    required this.careerTitle,
    required this.formheading,
  });

  factory CareerModel.fromJson(Map<String, dynamic> json) {
    return CareerModel(
      success: json['success'] ?? false,
      intro: Intro.fromJson(json['intro']),
      value: Value.fromJson(json['value']),
      ourValue: OurValue.fromJson(json['our_value']),
      empowerment: Empowerment.fromJson(json['empowerment']),
      award: Award.fromJson(json['award']),
      learnMore: LearnMore.fromJson(json['learn_more']),
      trending: Trending.fromJson(json['trending']),
      jobs: Jobs.fromJson(json['jobs']),
      counts: Counts.fromJson(json['counts']),
      careerTitle: (json['career_title'] as List?)
          ?.map((item) => CareerTitle.fromJson(item))
          .toList() ?? [],
      formheading: FormHeading.fromJson(json['formheading']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'intro': intro.toJson(),
      'value': value.toJson(),
      'our_value': ourValue.toJson(),
      'empowerment': empowerment.toJson(),
      'award': award.toJson(),
      'learn_more': learnMore.toJson(),
      'trending': trending.toJson(),
      'jobs': jobs.toJson(),
      'counts': counts.toJson(),
      'career_title': careerTitle.map((item) => item.toJson()).toList(),
      'formheading': formheading.toJson(),
    };
  }
}

class SectionBase {
  final int id;
  final int secId;
  final String? title;
  final String? description;
  final String? subtitle;
  final String? name;
  final String? designation;
  final String? bgImg;
  final String? img;
  final String? video;
  final String createdAt;
  final String updatedAt;
  final String? videoUrl;
  final String? url;

  SectionBase({
    required this.id,
    required this.secId,
    this.title,
    this.description,
    this.subtitle,
    this.name,
    this.designation,
    this.bgImg,
    this.img,
    this.video,
    required this.createdAt,
    required this.updatedAt,
    this.videoUrl,
    this.url,
  });

  factory SectionBase.fromJson(Map<String, dynamic> json) {
    return SectionBase(
      id: json['id'] ?? 0,
      secId: json['sec_id'] ?? 0,
      title: json['title'],
      description: json['description'],
      subtitle: json['subtitle'],
      name: json['name'],
      designation: json['designation'],
      bgImg: json['bg_img'],
      img: json['img'],
      video: json['video'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      videoUrl: json['video_url'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sec_id': secId,
      'title': title,
      'description': description,
      'subtitle': subtitle,
      'name': name,
      'designation': designation,
      'bg_img': bgImg,
      'img': img,
      'video': video,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'video_url': videoUrl,
      'url': url,
    };
  }
}

class Intro extends SectionBase {
  Intro({
    required super.id,
    required super.secId,
    required super.title,
    required super.description,
    required super.subtitle,
    required super.name,
    required super.designation,
    required super.bgImg,
    required super.img,
    required super.video,
    required super.createdAt,
    required super.updatedAt,
    required super.videoUrl,
    required super.url,
  });

  factory Intro.fromJson(Map<String, dynamic> json) {
    return Intro(
      id: json['id'] ?? 0,
      secId: json['sec_id'] ?? 0,
      title: json['title'],
      description: json['description'],
      subtitle: json['subtitle'],
      name: json['name'],
      designation: json['designation'],
      bgImg: json['bg_img'],
      img: json['img'],
      video: json['video'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      videoUrl: json['video_url'],
      url: json['url'],
    );
  }
}

class Value extends SectionBase {
  Value({
    required super.id,
    required super.secId,
    required super.title,
    required super.description,
    required super.subtitle,
    required super.name,
    required super.designation,
    required super.bgImg,
    required super.img,
    required super.video,
    required super.createdAt,
    required super.updatedAt,
    required super.videoUrl,
    required super.url,
  });

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(
      id: json['id'] ?? 0,
      secId: json['sec_id'] ?? 0,
      title: json['title'],
      description: json['description'],
      subtitle: json['subtitle'],
      name: json['name'],
      designation: json['designation'],
      bgImg: json['bg_img'],
      img: json['img'],
      video: json['video'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      videoUrl: json['video_url'],
      url: json['url'],
    );
  }
}

class Empowerment extends SectionBase {
  Empowerment({
    required super.id,
    required super.secId,
    required super.title,
    required super.description,
    required super.subtitle,
    required super.name,
    required super.designation,
    required super.bgImg,
    required super.img,
    required super.video,
    required super.createdAt,
    required super.updatedAt,
    required super.videoUrl,
    required super.url,
  });

  factory Empowerment.fromJson(Map<String, dynamic> json) {
    return Empowerment(
      id: json['id'] ?? 0,
      secId: json['sec_id'] ?? 0,
      title: json['title'],
      description: json['description'],
      subtitle: json['subtitle'],
      name: json['name'],
      designation: json['designation'],
      bgImg: json['bg_img'],
      img: json['img'],
      video: json['video'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      videoUrl: json['video_url'],
      url: json['url'],
    );
  }
}

class DivItem {
  final int id;
  final int secId;
  final String? title;
  final String? subtitle;
  final String? content;
  final String? name;
  final String? designation;
  final String? location;
  final String? img;
  final String? icon;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String? url;

  DivItem({
    required this.id,
    required this.secId,
    this.title,
    this.subtitle,
    this.content,
    this.name,
    this.designation,
    this.location,
    this.img,
    this.icon,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.url,
  });

  factory DivItem.fromJson(Map<String, dynamic> json) {
    return DivItem(
      id: json['id'] ?? 0,
      secId: json['sec_id'] ?? 0,
      title: json['title'],
      subtitle: json['subtitle'],
      content: json['content'],
      name: json['name'],
      designation: json['designation'],
      location: json['location'],
      img: json['img'],
      icon: json['icon'],
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sec_id': secId,
      'title': title,
      'subtitle': subtitle,
      'content': content,
      'name': name,
      'designation': designation,
      'location': location,
      'img': img,
      'icon': icon,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'url': url,
    };
  }
}

class OurValue extends SectionBase {
  final List<DivItem> divs;

  OurValue({
    required super.id,
    required super.secId,
    required super.title,
    required super.description,
    required super.subtitle,
    required super.name,
    required super.designation,
    required super.bgImg,
    required super.img,
    required super.video,
    required super.createdAt,
    required super.updatedAt,
    required super.videoUrl,
    required super.url,
    required this.divs,
  });

  factory OurValue.fromJson(Map<String, dynamic> json) {
    return OurValue(
      id: json['id'] ?? 0,
      secId: json['sec_id'] ?? 0,
      title: json['title'],
      description: json['description'],
      subtitle: json['subtitle'],
      name: json['name'],
      designation: json['designation'],
      bgImg: json['bg_img'],
      img: json['img'],
      video: json['video'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      videoUrl: json['video_url'],
      url: json['url'],
      divs: (json['divs'] as List?)
          ?.map((item) => DivItem.fromJson(item))
          .toList() ?? [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'divs': divs.map((item) => item.toJson()).toList(),
    };
  }
}

class Award extends SectionBase {
  final List<DivItem> divs;

  Award({
    required super.id,
    required super.secId,
    required super.title,
    required super.description,
    required super.subtitle,
    required super.name,
    required super.designation,
    required super.bgImg,
    required super.img,
    required super.video,
    required super.createdAt,
    required super.updatedAt,
    required super.videoUrl,
    required super.url,
    required this.divs,
  });

  factory Award.fromJson(Map<String, dynamic> json) {
    return Award(
      id: json['id'] ?? 0,
      secId: json['sec_id'] ?? 0,
      title: json['title'],
      description: json['description'],
      subtitle: json['subtitle'],
      name: json['name'],
      designation: json['designation'],
      bgImg: json['bg_img'],
      img: json['img'],
      video: json['video'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      videoUrl: json['video_url'],
      url: json['url'],
      divs: (json['divs'] as List?)
          ?.map((item) => DivItem.fromJson(item))
          .toList() ?? [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'divs': divs.map((item) => item.toJson()).toList(),
    };
  }
}

class LearnMore extends SectionBase {
  final List<DivItem> divs;

  LearnMore({
    required super.id,
    required super.secId,
    required super.title,
    required super.description,
    required super.subtitle,
    required super.name,
    required super.designation,
    required super.bgImg,
    required super.img,
    required super.video,
    required super.createdAt,
    required super.updatedAt,
    required super.videoUrl,
    required super.url,
    required this.divs,
  });

  factory LearnMore.fromJson(Map<String, dynamic> json) {
    return LearnMore(
      id: json['id'] ?? 0,
      secId: json['sec_id'] ?? 0,
      title: json['title'],
      description: json['description'],
      subtitle: json['subtitle'],
      name: json['name'],
      designation: json['designation'],
      bgImg: json['bg_img'],
      img: json['img'],
      video: json['video'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      videoUrl: json['video_url'],
      url: json['url'],
      divs: (json['divs'] as List?)
          ?.map((item) => DivItem.fromJson(item))
          .toList() ?? [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'divs': divs.map((item) => item.toJson()).toList(),
    };
  }
}

class Trending extends SectionBase {
  final List<DivItem> divs;

  Trending({
    required super.id,
    required super.secId,
    required super.title,
    required super.description,
    required super.subtitle,
    required super.name,
    required super.designation,
    required super.bgImg,
    required super.img,
    required super.video,
    required super.createdAt,
    required super.updatedAt,
    required super.videoUrl,
    required super.url,
    required this.divs,
  });

  factory Trending.fromJson(Map<String, dynamic> json) {
    return Trending(
      id: json['id'] ?? 0,
      secId: json['sec_id'] ?? 0,
      title: json['title'],
      description: json['description'],
      subtitle: json['subtitle'],
      name: json['name'],
      designation: json['designation'],
      bgImg: json['bg_img'],
      img: json['img'],
      video: json['video'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      videoUrl: json['video_url'],
      url: json['url'],
      divs: (json['divs'] as List?)
          ?.map((item) => DivItem.fromJson(item))
          .toList() ?? [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'divs': divs.map((item) => item.toJson()).toList(),
    };
  }
}

class JobLocation {
  final int id;
  final String name;

  JobLocation({
    required this.id,
    required this.name,
  });

  factory JobLocation.fromJson(Map<String, dynamic> json) {
    return JobLocation(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class JobPosting {
  final int id;
  final String title;
  final String slug;
  final String jobType;
  final String? company;
  final int? vacancy;
  final String? salary;
  final String? jobLocation;
  final List<JobLocation> jobLocationWithIds;
  final String? openings;
  final int popular;
  final int categoryId;
  final String? mapLink;
  final String? experience;

  JobPosting({
    required this.id,
    required this.title,
    required this.slug,
    required this.jobType,
    this.company,
    this.vacancy,
    this.salary,
    this.jobLocation,
    required this.jobLocationWithIds,
    this.openings,
    required this.popular,
    required this.categoryId,
    this.mapLink,
    this.experience,
  });

  factory JobPosting.fromJson(Map<String, dynamic> json) {
    return JobPosting(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      jobType: json['job_type'] ?? '',
      company: json['company'],
      vacancy: json['vacancy'],
      salary: json['salary'],
      jobLocation: json['job_location'],
      jobLocationWithIds: (json['job_location_with_ids'] as List?)
          ?.map((item) => JobLocation.fromJson(item))
          .toList() ?? [],
      openings: json['openings'],
      popular: json['popular'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      mapLink: json['map_link'],
      experience: json['experience'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'job_type': jobType,
      'company': company,
      'vacancy': vacancy,
      'salary': salary,
      'job_location': jobLocation,
      'job_location_with_ids': jobLocationWithIds.map((item) => item.toJson()).toList(),
      'openings': openings,
      'popular': popular,
      'category_id': categoryId,
      'map_link': mapLink,
      'experience': experience,
    };
  }
}

class Jobs extends SectionBase {
  final List<dynamic> jobLocation;
  final List<JobPosting> jobPostings;

  Jobs({
    required super.id,
    required super.secId,
    required super.title,
    required super.description,
    required super.subtitle,
    required super.name,
    required super.designation,
    required super.bgImg,
    required super.img,
    required super.video,
    required super.createdAt,
    required super.updatedAt,
    required super.videoUrl,
    required super.url,
    required this.jobLocation,
    required this.jobPostings,
  });

  factory Jobs.fromJson(Map<String, dynamic> json) {
    return Jobs(
      id: json['id'] ?? 0,
      secId: json['sec_id'] ?? 0,
      title: json['title'],
      description: json['description'],
      subtitle: json['subtitle'],
      name: json['name'],
      designation: json['designation'],
      bgImg: json['bg_img'],
      img: json['img'],
      video: json['video'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      videoUrl: json['video_url'],
      url: json['url'],
      jobLocation: json['job_location'] ?? [],
      jobPostings: (json['job_postings'] as List?)
          ?.map((item) => JobPosting.fromJson(item))
          .toList() ?? [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'job_location': jobLocation,
      'job_postings': jobPostings.map((item) => item.toJson()).toList(),
    };
  }
}

class Counts {
  final String title;
  final String counts;

  Counts({
    required this.title,
    required this.counts,
  });

  factory Counts.fromJson(Map<String, dynamic> json) {
    return Counts(
      title: json['title'] ?? '',
      counts: json['counts'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'counts': counts,
    };
  }
}

class CareerTitle {
  final int id;
  final String title;
  final String subtitle;
  final String page;
  final String section;

  CareerTitle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.page,
    required this.section,
  });

  factory CareerTitle.fromJson(Map<String, dynamic> json) {
    return CareerTitle(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      page: json['page'] ?? '',
      section: json['section'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'page': page,
      'section': section,
    };
  }
}

class FormHeading extends SectionBase {
  FormHeading({
    required super.id,
    required super.secId,
    required super.title,
    required super.description,
    required super.subtitle,
    required super.name,
    required super.designation,
    required super.bgImg,
    required super.img,
    required super.video,
    required super.createdAt,
    required super.updatedAt,
    required super.videoUrl,
    required super.url,
  });

  factory FormHeading.fromJson(Map<String, dynamic> json) {
    return FormHeading(
      id: json['id'] ?? 0,
      secId: json['sec_id'] ?? 0,
      title: json['title'],
      description: json['description'],
      subtitle: json['subtitle'],
      name: json['name'],
      designation: json['designation'],
      bgImg: json['bg_img'],
      img: json['img'],
      video: json['video'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      videoUrl: json['video_url'],
      url: json['url'],
    );
  }
}