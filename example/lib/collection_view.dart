import 'package:flutter/material.dart';
import 'package:muse_ai/muse_ai.dart';
import 'video_view.dart';

class CollectionView extends StatefulWidget {
  final MuseIndex? museIndex;
  final MuseCollection collection;

  const CollectionView(
      {Key? key, required this.museIndex, required this.collection})
      : super(key: key);

  @override
  _CollectionViewState createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(widget.collection.name!),
        ),
        body: Container(
          padding: EdgeInsets.all(26),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Videos",
                ),
              ),
              for (var video in widget.collection.videos!)
                ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return VideoView(video: video);
                          },
                          fullscreenDialog: true,
                          maintainState: true));
                    },
                    title: Text(video.title!),
                    trailing:
                        Text("${Duration(seconds: video.duration!.toInt())}"))
            ],
          ),
        ),
      ),
    );
  }
}
