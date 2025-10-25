import 'dart:convert';
import 'dart:io';

import 'package:propusers/models/privacy_policy_models/privacy_policy_terms_and_conditions_model.dart';
import 'package:http/http.dart' as http;
import 'package:propusers/models/sign_in_models/sign_in_model.dart';

import '../models/about_us_models/about_us_model.dart';
import '../models/blogs_models/blogs_model.dart';
import '../models/career_models/career_model.dart';
import '../models/career_models/job_model.dart';
import '../models/contact_us_models/contact_us_model.dart';
import '../models/management_models/management_model.dart';
import '../models/neighbourhood_models/neighbourhood_localities_model.dart';
import '../models/neighbourhood_models/neighbourhood_locality_model.dart';
import '../models/neighbourhood_models/neighbourhood_model.dart';
import '../models/news_models/news_model.dart';
import '../models/office_locations_models/office_locations_model.dart';
import '../models/propreneur_experience_models/propreneur_experience_model.dart';
import '../models/proprenuer_dropdown_models/proprenuer_dropdown_model.dart';
import '../models/sign_up_models/sign_up_model.dart';
import '../models/verify_user_models/verify_user_model.dart';

class RemoteService {

  /// Privacy Policy
  Future<PrivacyPolicyTermsAndConditionsModel?> getPrivacyPolicy() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.propusers.com/admin/api/privacyPolicy');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      return privacyPolicyTermsAndConditionsModelFromJson(response.body);
    }
    return null;
  }

  /// Terms And Conditions
  Future<PrivacyPolicyTermsAndConditionsModel?> getTermsAndConditions() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.propusers.com/admin/api/termsCondition');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      return privacyPolicyTermsAndConditionsModelFromJson(response.body);
    }
    return null;
  }

  /// Neighbourhood
  Future<NeighbourhoodModel?> getNeighbourhood() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.propusers.com/admin/api/allcities');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      return neighbourhoodModelFromJson(response.body);
    }
    return null;
  }

  /// Neighbourhood Localities
  Future<NeighbourhoodLocalitiesModel?> getNeighbourhoodLocalities(
    String city_slug,
  ) async {
    var client = http.Client();
    var uri = Uri.parse('https://www.propusers.com/admin/api/localities');
    var response = await client.post(uri, body: {"city_slug": city_slug});
    if (response.statusCode == 200) {
      return NeighbourhoodLocalitiesModelFromJson(response.body);
    }
    return null;
  }

  /// Locality Detail
  Future<NeighbourhoodResponse?> getLocalityDetail(String id) async {
    var client = http.Client();
    try {
      // Pass the ID directly in the URL
      var uri = Uri.parse('https://www.propusers.com/admin/api/locality/$id');
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        return neighbourhoodResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching locality detail: $e");
      return null;
    } finally {
      client.close();
    }
  }

  /// About Us
  Future<AboutUsModel?> getAboutUs() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.propusers.com/admin/api/aboutPage');

    try {
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        return aboutUsModelFromJson(response.body);
      } else {
        print("Error fetching AboutUs: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception in getAboutUs: $e");
      return null;
    } finally {
      client.close();
    }
  }

  /// Management Team
  Future<ManagementTeamModel?> getManagementTeam() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.propusers.com/admin/api/managementPage');

    try {
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        return managementTeamModelFromJson(response.body);
      } else {
        print("Error fetching Management Team: ${response.statusCode}");
        print("Response body: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception in getManagementTeam: $e");
      return null;
    } finally {
      client.close();
    }
  }

  /// Office Locations
  Future<OfficeLocationModel?> getOfficeLocations() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.propusers.com/admin/api/officeLocations');

    try {
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        return officeLocationModelFromJson(response.body);
      } else {
        print("Error fetching Office Locations: ${response.statusCode}");
        print("Response body: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception in getOfficeLocations: $e");
      return null;
    } finally {
      client.close();
    }
  }

  /// Contact Us
  Future<ContactUsModel?> getContactUs() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.propusers.com/admin/api/contactUsData');

    try {
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        return contactUsModelFromJson(response.body);
      } else {
        print("Error fetching Contact Us: ${response.statusCode}");
        print("Response body: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception in getContactUs: $e");
      return null;
    } finally {
      client.close();
    }
  }

  /// Propreneur Experience
  Future<PropreneurExperienceModel?> getPropreneurExperience() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.propusers.com/admin/api/ExperienceData');

    try {
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        return propreneurExperienceModelFromJson(response.body);
      } else {
        print("Error fetching Propreneur Experience: ${response.statusCode}");
        print("Response body: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception in getPropreneurExperience: $e");
      return null;
    } finally {
      client.close();
    }
  }

  /// Proprenuer Dropdown
  Future<ProprenuerDropdownModel?> getProprenuerDropdown() async {
    var client = http.Client();
    var uri = Uri.parse(
      'https://www.propusers.com/admin/api/ProprenuerDropdown',
    );

    try {
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        return proprenuerDropdownModelFromJson(response.body);
      } else {
        print("Error fetching Proprenuer Dropdown: ${response.statusCode}");
        print("Response body: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception in getProprenuerDropdown: $e");
      return null;
    } finally {
      client.close();
    }
  }

  /// Sign Up
  Future<SignUpModel?> signUp({
    required String name,
    required String email,
    required String password,
    required String contact,
    required String city,
    required String type,
  }) async {
    final url = Uri.parse('https://staging.propusers.com/admin/api/signUp');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'name': name,
          'email': email,
          'password': password,
          'contact': contact,
          'city': city,
          'type': type,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          //  Replace the previous Map return with this
          final signUpUser = SignUpModel.fromJson(data);
          return signUpUser; // return model directly
        } else {
          // API returned success=false
          return null;
        }
      } else {
        return null; // HTTP error
      }
    } catch (e) {
      return null; // exception
    }
  }

  /// Verify User
  Future<VerifyUserModel?> verifyUser({required int userId}) async {
    final url = Uri.parse('https://staging.propusers.com/admin/api/verifyUser');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'user_id': userId.toString()},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return VerifyUserModel.fromJson(data);
        } else {
          return null; // failed
        }
      } else {
        return null; // HTTP error
      }
    } catch (e) {
      return null; // Exception
    }
  }

  /// Resend Otp
  Future<Map<String, dynamic>?> resendOtp({required String email, required String type}) async {
    try {
      final url = Uri.parse('https://staging.propusers.com/admin/api/resendOtp?email=$email&type=$type');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        print('Resend OTP failed: ${response.statusCode}');
        print(response.body);
        return {
          "success": false,
          "error": "Something went wrong (${response.statusCode})"
        };
      }
    } catch (e) {
      print('Error during resend OTP: $e');
      return {"success": false, "error": e.toString()};
    }
  }

  /// Sign In API (POST)
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
    required int type,
  }) async {
    final url = Uri.parse('https://staging.propusers.com/admin/api/signIn');

    try {
      final response = await http.post(url, body: {
        'email': email,
        'password': password,
        'type': type.toString(),
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          final user = SignInModel.fromJson(data['data']);
          return {
            'success': true,
            'user': user,
          };
        } else {
          return {
            'success': false,
            'message': data['message'] ?? 'Invalid email or password',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Failed with status code ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  /// Send OTP API (POST)
  Future<Map<String, dynamic>> sendOtp({
    required String email,
    required int type,
  }) async {
    final url = Uri.parse('https://staging.propusers.com/admin/api/sendOtp?email=$email&type=$type');

    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'type': type.toString(),
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed with status code ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  /// Reset Password API (POST)
  Future<Map<String, dynamic>> resetPassword({
    required String userId,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse(
        'https://staging.propusers.com/admin/api/resetPassword?user_id=$userId&password=$password&confirm_password=$confirmPassword');

    try {
      final response = await http.post(
        url,
        body: {
          'user_id': userId,
          'password': password,
          'confirm_password': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed with status code ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  /// Career Data
  static Future<CareerModel?> fetchCareerData() async {
    try {
      final response = await http.get(Uri.parse('https://staging.propusers.com/admin/api/careerPage'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return CareerModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load career data');
      }
    } catch (e) {
      print('Error fetching career data: $e');
      return null;
    }
  }

  /// Job Detail
  Future<JobDetailModel?> fetchJobDetail(String slug) async {
    var client = http.Client();
    try {
      var uri = Uri.parse('https://staging.propusers.com/admin/api/job/$slug'); // Adjust endpoint as per your API
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        // Decode JSON and return JobDetailModel
        var jsonData = json.decode(response.body);
        return JobDetailModel.fromJson(jsonData);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      client.close();
    }
    return null;
  }

  /// Career Application Form
  Future<Map<String, dynamic>> submitCareerApplication({
    required String fname,
    required String referralBy,
    required String email,
    required String phone,
    required String position,
    required String jobId,
    required String cityId,
    required String location,
    File? resumeFile, // optional file upload
  }) async {
    final url = Uri.parse('https://staging.propusers.com/admin/api/careerenquiryData');

    try {
      var request = http.MultipartRequest('POST', url);

      // Required fields
      request.fields['fname'] = fname;
      request.fields['referralBy'] = referralBy;
      request.fields['email'] = email;
      request.fields['phone'] = phone;
      request.fields['position'] = position;
      request.fields['job_id'] = jobId;
      request.fields['city_id'] = cityId;
      request.fields['location'] = location;
      request.fields['type'] = 'career'; // static field

      // Attach file (PDF/DOCX)
      if (resumeFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('file', resumeFile.path),
        );
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> data = jsonDecode(responseBody);
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'message': 'Server Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Fetches news list from API
  static Future<NewsListingModel?> fetchNewsListing() async {
    try {
      final response = await http.get(Uri.parse("https://www.propusers.com/admin/api/news_listing"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return NewsListingModel.fromJson(data);
      } else {
        print("Failed to load news: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching news: $e");
      return null;
    }
  }

  /// Fetch all blogs
  Future<BlogsListingModel> fetchBlogsListing() async {
    final url = Uri.parse('https://www.propusers.com/admin/api/blogs_listing'); // Adjust endpoint if needed

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return BlogsListingModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load blogs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load blogs: $e');
    }
  }

  /// Fetch trending blogs only
  Future<List<BlogData>> fetchTrendingBlogs() async {
    final blogsListing = await fetchBlogsListing();
    return blogsListing.data.where((blog) => blog.isTrending == 1).toList();
  }

}
