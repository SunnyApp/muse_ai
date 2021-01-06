library muse_ai;

import 'package:muse_ai/muse_collections.dart';
import 'package:dio/dio.dart';
export 'muse_index.dart';
export 'muse_collections.dart';

class MuseAI {
  final String apiKey;
  final Dio _dio;
  MuseAI(this.apiKey)
      : assert(apiKey != null, "You must provide an api key"),
        _dio = Dio(BaseOptions(
            headers: {"Key": apiKey}, baseUrl: "https://vv8-9-0.muse.ai/api"));

  Future<List<MuseCollection>> collections() async {
    final resp = await _dio.get<List>("/files/collections");
    return fromResponse(resp);
  }

  List<MuseCollection> fromResponse(Response<List> response) {
    if (response.statusCode == 200) {
      return response.data.map((l) => MuseCollection.fromJson(l)).toList();
    } else {
      throw "Invalid response from ipstack: status=${response.statusCode}, body=${response.data}";
    }
  }
}
