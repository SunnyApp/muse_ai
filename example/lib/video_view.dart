import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:muse_ai/muse_ai.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final MuseVideo video;

  const VideoView({
    Key key,
    @required this.video,
  }) : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  ChewieController _chewie;
  VideoPlayerController _vp;

  @override
  void initState() {
    super.initState();
    _vp = VideoPlayerController.network(widget.video.format("mp4"));
    _chewie = ChewieController(
      aspectRatio: 4.0 / 3.0,
      autoInitialize: true,
      videoPlayerController: _vp,
    );
  }

  @override
  void dispose() {
    _vp.dispose();
    _chewie.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("Video"),
        ),
        body: Container(
          child: Chewie(
            controller: _chewie,
          ),
        ),
      ),
    );
  }
}
