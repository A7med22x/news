import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstansts {
  static const String baseUrl = 'newsapi.org';
  static String apiKey = dotenv.env['API_KEY']!;
  static const String sourcesEndpoint = '/v2/top-headlines/sources';
  static const String newsEndpoint = '/v2/top-headlines';
  static const String searchEndpoint = '/v2/everything';
}
