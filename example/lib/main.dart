import 'package:flutter/material.dart';
import 'dart:async';

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
  String _platformVersion = 'Unknown';
  MuseIndex _index;
  MuseAI _museAI;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  _updateApiKey(String key) async {
    if (key != null) {
      _museAI = MuseAI(key);
      setState(() {
        _loading = true;
      });
      _index = (await _museAI.collections()).index();
      setState(() {
        _loading = true;
      });
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {} on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                  helperText: "Paste muse.ai API key",
                ),
                onChanged: (value) {
                  _updateApiKey(value);
                },
              ),
              if (_loading)
                Center(child: CircularProgressIndicator())
              else if (_museAI != null)
                Container(color: Colors.red)
            ],
          ),
        ),
      ),
    );
  }
}
