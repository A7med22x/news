import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/shared/api_constansts.dart';
import 'package:news/sourses/data/models/sources_response.dart';

class SourcesDataSources {
  Future<SourcesResponse> getSources(String categoryID) async {
    Uri uri = Uri.https(ApiConstansts.baseUrl, ApiConstansts.sourcesEndpoint, {
      'apiKey': ApiConstansts.apiKey,
      'category': categoryID,
    });

    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return SourcesResponse.fromJson(json);
  }
}