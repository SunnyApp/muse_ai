import 'package:flutter/material.dart';
import 'dart:async';
import 'collection_view.dart';
import 'package:flutter/services.dart';
import 'package:muse_ai/muse_ai.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MuseIndex _index;
  MuseAI _museAI;
  bool _error = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  _updateApiKey(String key) async {
    if (key != null) {
      _museAI = MuseAI(key);
      setState(() {
        _error = false;
        _loading = true;
      });
      try {
        _index = (await _museAI.collections()).index();
        setState(() {
          _loading = false;
        });
      } catch (e) {
        setState(() {
          _error = true;
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Muse Example App'),
          ),
          body: Container(
            padding: EdgeInsets.all(26),
            child: ListView(
              children: [
                TextField(
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    labelText: "Paste muse.ai API key",
                  ),
                  onChanged: (value) {
                    _updateApiKey(value);
                  },
                ),
                if (_loading)
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()))
                else if (_error)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        "Invalid API Key",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                else if (_index != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Collections",
                    ),
                  ),
                  for (var x in _index.collections)
                    ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return CollectionView(
                                  museIndex: _index,
                                  collection: x,
                                );
                              },
                              fullscreenDialog: true,
                              maintainState: true,
                            ),
                          );
                        },
                        title: Text(x.name),
                        trailing: x.visibility == "unlisted"
                            ? Icon(Icons.remove_red_eye_rounded)
                            : null),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
