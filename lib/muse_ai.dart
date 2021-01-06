library muse_ai;

import 'package:muse_ai/muse_collections.dart';
import 'package:dio/dio.dart';

class MuseAI {
  final String apiKey;
  final Dio _dio;
  MuseAI(this.apiKey)
      : assert(apiKey != null, "You must provide an api key"),
        _dio = Dio(BaseOptions(
            headers: {"Authorization": "Bearer $apiKey"},
            baseUrl: "https://vv8-9-0.muse.ai/api"));

  Future<MuseCollections> collections() async {
    final resp = await _dio.get<Map<String, dynamic>>("/files/collections");
    return fromResponse(resp);
  }

  MuseCollections fromResponse(Response<Map<String, dynamic>> response) {
    if (response.statusCode == 200) {
      return MuseCollections.fromJson(response.data);
    } else {
      throw "Invalid response from ipstack: status=${response.statusCode}, body=${response.data}";
    }
  }
}
