import 'package:propusers/models/privacy_policy_models/privacy_policy_terms_and_conditions_model.dart';
import 'package:http/http.dart' as http;

import '../models/neighbourhood_models/neighbourhood_localities_model.dart';
import '../models/neighbourhood_models/neighbourhood_locality_model.dart';
import '../models/neighbourhood_models/neighbourhood_model.dart';

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

  Future<NeighbourhoodLocalitiesModel?> getNeighbourhoodLocalities(String city_slug) async {
    var client = http.Client();
    var uri = Uri.parse('https://www.propusers.com/admin/api/localities');
    var response = await client.post(
      uri,
      body: {"city_slug": city_slug},
    );
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

}
