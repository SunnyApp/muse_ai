import 'package:muse_ai/muse_index.dart';

class MuseCollection {
  String? name;
  String? scid;
  int? tcreated;
  List<MuseVideo>? videos;
  String? visibility;

  MuseCollection(
      {this.name, this.scid, this.tcreated, this.videos, this.visibility});

  MuseCollection.fromJson(dynamic json) {
    name = json["name"] as String?;
    scid = json["scid"] as String?;
    tcreated = json["tcreated"] as int?;
    if (json["videos"] != null) {
      videos = [];
      json["videos"].forEach((v) {
        videos!.add(MuseVideo.fromJson(v));
      });
    }
    visibility = json["visibility"] as String?;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["scid"] = scid;
    map["tcreated"] = tcreated;
    if (videos != null) {
      map["videos"] = videos!.map((v) => v.toJson()).toList();
    }
    map["visibility"] = visibility;
    return map;
  }
}

class MuseVideo {
  double? duration;
  String? fid;
  String? svid;
  String? title;
  String? url;

  MuseVideo({this.duration, this.fid, this.svid, this.title, this.url});

  MuseVideo.fromJson(dynamic json) {
    duration = json["duration"] as double?;
    fid = json["fid"] as String?;
    svid = json["svid"] as String?;
    title = json["title"] as String?;
    url = json["url"] as String?;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["duration"] = duration;
    map["fid"] = fid;
    map["svid"] = svid;
    map["title"] = title;
    map["url"] = url;
    return map;
  }

  String format(String format, {String? size}) {
    return "https://cdn.muse.ai/w/${fid}/videos/video${size == null ? '' : '-$size'}.$format";
  }
}

extension ListOfMuseCollectionsExt on List<MuseCollection> {
  MuseIndex index() => MuseIndex(this);
}

extension FutureListOfMuseCollectionsExt on Future<List<MuseCollection>> {
  Future<MuseIndex> index() async => MuseIndex(await this);
}
