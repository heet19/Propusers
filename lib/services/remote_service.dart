import 'dart:convert';

import 'package:propusers/models/privacy_policy_models/privacy_policy_terms_and_conditions_model.dart';
import 'package:http/http.dart' as http;

import '../models/about_us_models/about_us_model.dart';
import '../models/contact_us_models/contact_us_model.dart';
import '../models/management_models/management_model.dart';
import '../models/neighbourhood_models/neighbourhood_localities_model.dart';
import '../models/neighbourhood_models/neighbourhood_locality_model.dart';
import '../models/neighbourhood_models/neighbourhood_model.dart';
import '../models/office_locations_models/office_locations_model.dart';
import '../models/propreneur_experience_models/propreneur_experience_model.dart';
import '../models/proprenuer_dropdown_models/proprenuer_dropdown_model.dart';

class RemoteService {
  Future<PrivacyPolicyTermsAndConditionsModel?> getPrivacyPolicy() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.propusers.com/admin/api/privacyPolicy');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      return privacyPolicyTermsAndConditionsModelFromJson(response.body);
    }
    return null;
  }

  Future<PrivacyPolicyTermsAndConditionsModel?> getTermsAndConditions() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.propusers.com/admin/api/termsCondition');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      return privacyPolicyTermsAndConditionsModelFromJson(response.body);
    }
    return null;
  }

  Future<NeighbourhoodModel?> getNeighbourhood() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.propusers.com/admin/api/allcities');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      return neighbourhoodModelFromJson(response.body);
    }
    return null;
  }

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

  Future<Map<String, dynamic>?> signUp({
    required String name,
    required String email,
    required String password,
    required String contact,
    required String city,
    required String type,
  }) async {
    try {
      final url = Uri.parse('https://staging.propusers.com/admin/api/signUp');

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
        return data;
      } else {
        print('Signup failed: ${response.statusCode}');
        print(response.body);
        return {
          "success": false,
          "error": "Something went wrong (${response.statusCode})"
        };
      }
    } catch (e) {
      print('Error during signup: $e');
      return {"success": false, "error": e.toString()};
    }
  }

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


}