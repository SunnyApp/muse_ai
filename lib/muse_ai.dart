library muse_ai;

import 'package:muse_ai/muse_collections.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
export 'muse_index.dart';
export 'muse_collections.dart';

final _log = Logger("museAI");

class MuseAI {
  final String apiKey;
  final String baseUrl;
  final Dio _dio;

  MuseAI(this.apiKey, {this.baseUrl = "https://www.muse.ai/api"})
      : _dio = Dio(BaseOptions(headers: {"Key": apiKey}, baseUrl: baseUrl));

  Future<List<MuseCollection>> collections() async {
    try {
      final resp = await _dio.get<List>("/files/collections");
      return fromResponse(resp);
    } on DioError catch (e, stack) {
      _log.severe("Error requesting collections: $e", e, stack);
      rethrow;
    }
  }

  List<MuseCollection> fromResponse(Response<List> response) {
    if (response.statusCode == 200) {
      return response.data!.map((l) => MuseCollection.fromJson(l)).toList();
    } else {
      throw "Invalid response from muse AI: status=${response.statusCode}, body=${response.data}";
    }
  }
}
