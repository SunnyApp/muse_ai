import 'package:muse_ai/muse_collections.dart';

class MuseIndex {
  final List<MuseCollection> collections;
  MuseIndex(this.collections)
      : _videosBySvid = {
          for (var c in collections)
            for (var video in c.videos!) video.svid: video,
        },
        _videosByFid = {
          for (var c in collections)
            for (var video in c.videos!) video.fid: video,
        },
        _videosByUrl = {
          for (var c in collections)
            for (var video in c.videos!) video.url: video,
        };

  final Map<String?, MuseVideo> _videosBySvid;
  final Map<String?, MuseVideo> _videosByFid;
  final Map<String?, MuseVideo> _videosByUrl;

  MuseVideo? findVideoByFid(String fid) {
    return _videosByFid[fid];
  }

  MuseVideo? findVideoBySvid(String svid) {
    return _videosBySvid[svid];
  }

  MuseVideo? findVideoByUrl(String url) {
    return _videosByUrl[url];
  }
}
