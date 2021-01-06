import 'package:muse_ai/muse_index.dart';

class MuseCollection {
  String name;
  String scid;
  int tcreated;
  List<MuseVideo> videos;
  String visibility;

  MuseCollection(
      {this.name, this.scid, this.tcreated, this.videos, this.visibility});

  MuseCollection.fromJson(dynamic json) {
    name = json["name"];
    scid = json["scid"];
    tcreated = json["tcreated"];
    if (json["videos"] != null) {
      videos = [];
      json["videos"].forEach((v) {
        videos.add(MuseVideo.fromJson(v));
      });
    }
    visibility = json["visibility"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["scid"] = scid;
    map["tcreated"] = tcreated;
    if (videos != null) {
      map["videos"] = videos.map((v) => v.toJson()).toList();
    }
    map["visibility"] = visibility;
    return map;
  }
}

class MuseVideo {
  double duration;
  String fid;
  String svid;
  String title;
  String url;

  MuseVideo({this.duration, this.fid, this.svid, this.title, this.url});

  MuseVideo.fromJson(dynamic json) {
    duration = json["duration"];
    fid = json["fid"];
    svid = json["svid"];
    title = json["title"];
    url = json["url"];
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
}

extension ListOfMuseCollectionsExt on List<MuseCollection> {
  MuseIndex index() => MuseIndex(this);
}
