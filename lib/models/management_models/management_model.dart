import 'dart:convert';

ManagementTeamModel managementTeamModelFromJson(String str) =>
    ManagementTeamModel.fromJson(json.decode(str));

String managementTeamModelToJson(ManagementTeamModel data) =>
    json.encode(data.toJson());

class ManagementTeamModel {
  final bool? success;
  final List<TeamMember>? staff;
  final List<Proprenuer>? proprenuer;
  final List<TeamMember>? lead;
  final List<TitleSection>? titles;
  final List<TeamMember>? backend;

  ManagementTeamModel({
    this.success,
    this.staff,
    this.proprenuer,
    this.lead,
    this.titles,
    this.backend,
  });

  factory ManagementTeamModel.fromJson(Map<String, dynamic> json) =>
      ManagementTeamModel(
        success: json["success"],
        staff: json["staff"] != null
            ? List<TeamMember>.from(
            json["staff"].map((x) => TeamMember.fromJson(x)))
            : [],
        proprenuer: json["proprenuer"] != null
            ? List<Proprenuer>.from(
            json["proprenuer"].map((x) => Proprenuer.fromJson(x)))
            : [],
        lead: json["lead"] != null
            ? List<TeamMember>.from(
            json["lead"].map((x) => TeamMember.fromJson(x)))
            : [],
        titles: json["titles"] != null
            ? List<TitleSection>.from(
            json["titles"].map((x) => TitleSection.fromJson(x)))
            : [],
        backend: json["backend"] != null
            ? List<TeamMember>.from(
            json["backend"].map((x) => TeamMember.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "staff": staff != null
        ? List<dynamic>.from(staff!.map((x) => x.toJson()))
        : [],
    "proprenuer": proprenuer != null
        ? List<dynamic>.from(proprenuer!.map((x) => x.toJson()))
        : [],
    "lead": lead != null
        ? List<dynamic>.from(lead!.map((x) => x.toJson()))
        : [],
    "titles": titles != null
        ? List<dynamic>.from(titles!.map((x) => x.toJson()))
        : [],
    "backend": backend != null
        ? List<dynamic>.from(backend!.map((x) => x.toJson()))
        : [],
  };
}

class TeamMember {
  final int? id;
  final int? isMain;
  final int? teamLeadId;
  final int? sequence;
  final String? name;
  final String? email;
  final String? propuserEmail;
  final dynamic probationMonths;
  final String? contact;
  final String? gender;
  final String? address;
  final dynamic city;
  final dynamic neighborhood;
  final dynamic state;
  final dynamic country;
  final String? designation;
  final String? description;
  final String? role;
  final String? type;
  final int? status;
  final dynamic reason;
  final String? emailVerifiedAt;
  final String? dob;
  final String? avatar;
  final dynamic images;
  final String? joiningDate;
  final int? mTeam;
  final int? teamLead;
  final String? fbLink;
  final dynamic twitterLink;
  final dynamic instaLink;
  final String? linkedin;
  final String? createdAt;
  final String? updatedAt;
  final String? username;
  final String? language;
  final int? teamId;
  final dynamic assetsReq;
  final dynamic assetsName;
  final String? salary;
  final int? roleNotification;
  final dynamic anniversary;
  final dynamic exitDate;
  final dynamic leavingDate;
  final String? aadhar;
  final String? pan;
  final String? altNumber;
  final String? bankName;
  final dynamic accNo;
  final dynamic accName;
  final dynamic ifsc;
  final int? backendTeam;
  final dynamic anniversaryDate;
  final String? maritalStatus;
  final int? savedNotification;
  final int? addedBy;
  final dynamic googleId;
  final dynamic stringData;
  final dynamic trainingAssign;
  final List<dynamic>? socialLinks;
  final String? url;

  TeamMember({
    this.id,
    this.isMain,
    this.teamLeadId,
    this.sequence,
    this.name,
    this.email,
    this.propuserEmail,
    this.probationMonths,
    this.contact,
    this.gender,
    this.address,
    this.city,
    this.neighborhood,
    this.state,
    this.country,
    this.designation,
    this.description,
    this.role,
    this.type,
    this.status,
    this.reason,
    this.emailVerifiedAt,
    this.dob,
    this.avatar,
    this.images,
    this.joiningDate,
    this.mTeam,
    this.teamLead,
    this.fbLink,
    this.twitterLink,
    this.instaLink,
    this.linkedin,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.language,
    this.teamId,
    this.assetsReq,
    this.assetsName,
    this.salary,
    this.roleNotification,
    this.anniversary,
    this.exitDate,
    this.leavingDate,
    this.aadhar,
    this.pan,
    this.altNumber,
    this.bankName,
    this.accNo,
    this.accName,
    this.ifsc,
    this.backendTeam,
    this.anniversaryDate,
    this.maritalStatus,
    this.savedNotification,
    this.addedBy,
    this.googleId,
    this.stringData,
    this.trainingAssign,
    this.socialLinks,
    this.url,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
    id: json["id"],
    isMain: json["is_main"],
    teamLeadId: json["team_lead_id"],
    sequence: json["sequence"],
    name: json["name"],
    email: json["email"],
    propuserEmail: json["propuser_email"],
    probationMonths: json["probation_months"],
    contact: json["contact"],
    gender: json["gender"],
    address: json["address"],
    city: json["city"],
    neighborhood: json["neighborhood"],
    state: json["state"],
    country: json["country"],
    designation: json["designation"],
    description: json["description"],
    role: json["role"],
    type: json["type"],
    status: json["status"],
    reason: json["reason"],
    emailVerifiedAt: json["email_verified_at"],
    dob: json["dob"],
    avatar: json["avatar"],
    images: json["images"],
    joiningDate: json["joining_date"],
    mTeam: json["m_team"],
    teamLead: json["team_lead"],
    fbLink: json["fb_link"],
    twitterLink: json["twitter_link"],
    instaLink: json["insta_link"],
    linkedin: json["linkedin"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    username: json["username"],
    language: json["language"],
    teamId: json["team_id"],
    assetsReq: json["assets_req"],
    assetsName: json["assets_name"],
    salary: json["salary"],
    roleNotification: json["role_notification"],
    anniversary: json["anniversary"],
    exitDate: json["exit_date"],
    leavingDate: json["leaving_date"],
    aadhar: json["aadhar"],
    pan: json["pan"],
    altNumber: json["alt_number"],
    bankName: json["bank_name"],
    accNo: json["acc_no"],
    accName: json["acc_name"],
    ifsc: json["ifsc"],
    backendTeam: json["backend_team"],
    anniversaryDate: json["anniversary_date"],
    maritalStatus: json["marital_status"],
    savedNotification: json["saved_notification"],
    addedBy: json["added_by"],
    googleId: json["google_id"],
    stringData: json["string_data"],
    trainingAssign: json["training_assign"],
    socialLinks: json["social_links"] != null
        ? List<dynamic>.from(json["social_links"].map((x) => x))
        : [],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_main": isMain,
    "team_lead_id": teamLeadId,
    "sequence": sequence,
    "name": name,
    "email": email,
    "propuser_email": propuserEmail,
    "probation_months": probationMonths,
    "contact": contact,
    "gender": gender,
    "address": address,
    "city": city,
    "neighborhood": neighborhood,
    "state": state,
    "country": country,
    "designation": designation,
    "description": description,
    "role": role,
    "type": type,
    "status": status,
    "reason": reason,
    "email_verified_at": emailVerifiedAt,
    "dob": dob,
    "avatar": avatar,
    "images": images,
    "joining_date": joiningDate,
    "m_team": mTeam,
    "team_lead": teamLead,
    "fb_link": fbLink,
    "twitter_link": twitterLink,
    "insta_link": instaLink,
    "linkedin": linkedin,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "username": username,
    "language": language,
    "team_id": teamId,
    "assets_req": assetsReq,
    "assets_name": assetsName,
    "salary": salary,
    "role_notification": roleNotification,
    "anniversary": anniversary,
    "exit_date": exitDate,
    "leaving_date": leavingDate,
    "aadhar": aadhar,
    "pan": pan,
    "alt_number": altNumber,
    "bank_name": bankName,
    "acc_no": accNo,
    "acc_name": accName,
    "ifsc": ifsc,
    "backend_team": backendTeam,
    "anniversary_date": anniversaryDate,
    "marital_status": maritalStatus,
    "saved_notification": savedNotification,
    "added_by": addedBy,
    "google_id": googleId,
    "string_data": stringData,
    "training_assign": trainingAssign,
    "social_links": socialLinks != null
        ? List<dynamic>.from(socialLinks!.map((x) => x))
        : [],
    "url": url,
  };
}

class Proprenuer {
  final int? id;
  final int? requestId;
  final int? role;
  final int? userId;
  final String? name;
  final String? slug;
  final String? address;
  final int? contact;
  final String? email;
  final String? lookingToPropuser;
  final String? fname;
  final String? lname;
  final String? fatherName;
  final String? gender;
  final String? dob;
  final String? description;
  final String? maritalStatus;
  final String? marriageAniversary;
  final int? alternateContact;
  final int? whatsappNumber;
  final int? landlineNumber;
  final String? currentAddress;
  final String? permanentAddress;
  final dynamic primaryMarket;
  final int? state;
  final int? city;
  final String? activeCities;
  final String? rera;
  final String? pan;
  final dynamic aadhaar;
  final String? education;
  final int? totalExperience;
  final int? realEstateExperience;
  final int? otherIndustriesExperience;
  final int? totalInventoriesSold;
  final String? expertise;
  final String? linguisticsProficiency;
  final String? currentOccupancy;
  final String? currentWorkingAs;
  final dynamic monthlyIncome;
  final String? membership;
  final String? skills;
  final String? companyName;
  final String? teamName;
  final String? linkedn;
  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? youtube;
  final String? website;
  final String? identityProof;
  final String? licenceProof;
  final String? propuserEmail;
  final String? password;
  final String? requestStatus;
  final dynamic rejectReason;
  final int? status;
  final int? deleteStatus;
  final String? propAvatar;
  final int? appRejectedBy;
  final String? appRejectedAt;
  final String? createdAt;
  final String? updatedAt;
  final int? top;
  final dynamic awards;
  final String? teamImage;
  final dynamic locality;
  final dynamic permanentState;
  final dynamic permanentCity;
  final dynamic bannerImage;
  final int? addedBy;
  final String? imageUrl;

  Proprenuer({
    this.id,
    this.requestId,
    this.role,
    this.userId,
    this.name,
    this.slug,
    this.address,
    this.contact,
    this.email,
    this.lookingToPropuser,
    this.fname,
    this.lname,
    this.fatherName,
    this.gender,
    this.dob,
    this.description,
    this.maritalStatus,
    this.marriageAniversary,
    this.alternateContact,
    this.whatsappNumber,
    this.landlineNumber,
    this.currentAddress,
    this.permanentAddress,
    this.primaryMarket,
    this.state,
    this.city,
    this.activeCities,
    this.rera,
    this.pan,
    this.aadhaar,
    this.education,
    this.totalExperience,
    this.realEstateExperience,
    this.otherIndustriesExperience,
    this.totalInventoriesSold,
    this.expertise,
    this.linguisticsProficiency,
    this.currentOccupancy,
    this.currentWorkingAs,
    this.monthlyIncome,
    this.membership,
    this.skills,
    this.companyName,
    this.teamName,
    this.linkedn,
    this.facebook,
    this.twitter,
    this.instagram,
    this.youtube,
    this.website,
    this.identityProof,
    this.licenceProof,
    this.propuserEmail,
    this.password,
    this.requestStatus,
    this.rejectReason,
    this.status,
    this.deleteStatus,
    this.propAvatar,
    this.appRejectedBy,
    this.appRejectedAt,
    this.createdAt,
    this.updatedAt,
    this.top,
    this.awards,
    this.teamImage,
    this.locality,
    this.permanentState,
    this.permanentCity,
    this.bannerImage,
    this.addedBy,
    this.imageUrl,
  });

  factory Proprenuer.fromJson(Map<String, dynamic> json) => Proprenuer(
    id: json["id"],
    requestId: json["request_id"],
    role: json["role"],
    userId: json["user_id"],
    name: json["name"],
    slug: json["slug"],
    address: json["address"],
    contact: json["contact"],
    email: json["email"],
    lookingToPropuser: json["looking_to_propuser"],
    fname: json["fname"],
    lname: json["lname"],
    fatherName: json["father_name"],
    gender: json["gender"],
    dob: json["dob"],
    description: json["description"],
    maritalStatus: json["marital_status"],
    marriageAniversary: json["marriage_aniversary"],
    alternateContact: json["alternate_contact"],
    whatsappNumber: json["whatsapp_number"],
    landlineNumber: json["landline_number"],
    currentAddress: json["current_address"],
    permanentAddress: json["permanent_address"],
    primaryMarket: json["primary_market"],
    state: json["state"],
    city: json["city"],
    activeCities: json["active_cities"],
    rera: json["rera"],
    pan: json["pan"],
    aadhaar: json["aadhaar"],
    education: json["education"],
    totalExperience: json["total_experience"],
    realEstateExperience: json["real_estate_experience"],
    otherIndustriesExperience: json["other_industries_experience"],
    totalInventoriesSold: json["total_inventories_sold"],
    expertise: json["expertise"],
    linguisticsProficiency: json["linguistics_proficiency"],
    currentOccupancy: json["current_occupancy"],
    currentWorkingAs: json["current_working_as"],
    monthlyIncome: json["monthly_income"],
    membership: json["membership"],
    skills: json["skills"],
    companyName: json["company_name"],
    teamName: json["team_name"],
    linkedn: json["linkedn"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    instagram: json["instagram"],
    youtube: json["youtube"],
    website: json["website"],
    identityProof: json["identity_proof"],
    licenceProof: json["licence_proof"],
    propuserEmail: json["propuser_email"],
    password: json["password"],
    requestStatus: json["request_status"],
    rejectReason: json["reject_reason"],
    status: json["status"],
    deleteStatus: json["delete_status"],
    propAvatar: json["prop_avatar"],
    appRejectedBy: json["app_rejected_by"],
    appRejectedAt: json["app_rejected_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    top: json["top"],
    awards: json["awards"],
    teamImage: json["team_image"],
    locality: json["locality"],
    permanentState: json["permanent_state"],
    permanentCity: json["permanent_city"],
    bannerImage: json["banner_image"],
    addedBy: json["added_by"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "request_id": requestId,
    "role": role,
    "user_id": userId,
    "name": name,
    "slug": slug,
    "address": address,
    "contact": contact,
    "email": email,
    "looking_to_propuser": lookingToPropuser,
    "fname": fname,
    "lname": lname,
    "father_name": fatherName,
    "gender": gender,
    "dob": dob,
    "description": description,
    "marital_status": maritalStatus,
    "marriage_aniversary": marriageAniversary,
    "alternate_contact": alternateContact,
    "whatsapp_number": whatsappNumber,
    "landline_number": landlineNumber,
    "current_address": currentAddress,
    "permanent_address": permanentAddress,
    "primary_market": primaryMarket,
    "state": state,
    "city": city,
    "active_cities": activeCities,
    "rera": rera,
    "pan": pan,
    "aadhaar": aadhaar,
    "education": education,
    "total_experience": totalExperience,
    "real_estate_experience": realEstateExperience,
    "other_industries_experience": otherIndustriesExperience,
    "total_inventories_sold": totalInventoriesSold,
    "expertise": expertise,
    "linguistics_proficiency": linguisticsProficiency,
    "current_occupancy": currentOccupancy,
    "current_working_as": currentWorkingAs,
    "monthly_income": monthlyIncome,
    "membership": membership,
    "skills": skills,
    "company_name": companyName,
    "team_name": teamName,
    "linkedn": linkedn,
    "facebook": facebook,
    "twitter": twitter,
    "instagram": instagram,
    "youtube": youtube,
    "website": website,
    "identity_proof": identityProof,
    "licence_proof": licenceProof,
    "propuser_email": propuserEmail,
    "password": password,
    "request_status": requestStatus,
    "reject_reason": rejectReason,
    "status": status,
    "delete_status": deleteStatus,
    "prop_avatar": propAvatar,
    "app_rejected_by": appRejectedBy,
    "app_rejected_at": appRejectedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "top": top,
    "awards": awards,
    "team_image": teamImage,
    "locality": locality,
    "permanent_state": permanentState,
    "permanent_city": permanentCity,
    "banner_image": bannerImage,
    "added_by": addedBy,
    "image_url": imageUrl,
  };
}

class TitleSection {
  final int? id;
  final String? title;
  final String? subtitle;
  final String? page;
  final String? section;

  TitleSection({
    this.id,
    this.title,
    this.subtitle,
    this.page,
    this.section,
  });

  factory TitleSection.fromJson(Map<String, dynamic> json) => TitleSection(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    page: json["page"],
    section: json["section"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "page": page,
    "section": section,
  };
}