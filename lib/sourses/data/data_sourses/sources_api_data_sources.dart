import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/shared/api_constansts.dart';
import 'package:news/sourses/data/data_sourses/sources_data_sources.dart';
import 'package:news/sourses/data/models/source.dart';
import 'package:news/sourses/data/models/sources_response.dart';

class SourcesApiDataSources implements SourcesDataSources {
  @override
  Future<List<Source>> getSources(String categoryID) async {
    Uri uri = Uri.https(ApiConstansts.baseUrl, ApiConstansts.sourcesEndpoint, {
      'apiKey': ApiConstansts.apiKey,
      'category': categoryID,
    });

    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
    if (sourcesResponse.status == 'ok' && sourcesResponse.sources != null) {
      return sourcesResponse.sources!;
    } else {
      throw Exception('Failed to get souces');
    }
  }
}
