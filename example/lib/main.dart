import 'package:terra_flutter_bridge/terra_flutter_bridge.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _testText = "Hello World";
  bool _initialised = false;
  bool _connected = false;
  bool _daily = false;

  @override
  void initState() {
    super.initState();
    initTerraFunctionState();
  }

  // Function messages are asynchronous, so we initialize in an async method.
  Future<void> initTerraFunctionState() async {
    bool initialised = false;
    bool connected = false;
    bool daily = false;
    String testText;
    // Function messages may fail, so we use a try/catch Exception.
    // We also handle the message potentially returning null.
    // USE YOUR OWN CATCH BLOCKS
    // HAVING ALL FUNCTIONS IN THE SAME CATCH IS NOT A GOOD IDEA
    try {
      testText = await TerraFlutter.testFunction("Custom parameter") ??
          "Some function call went wrong";
      initialised = await TerraFlutter.initTerra(
              "devId",
              "xapikey",
              "JaafarGoogle",
              60,
              ["GOOGLE_FIT"],
              ["BODY", "DAILY", "ACTIVITY"]) ??
          false;
      // connected = await TerraFlutter.checkAuth("GOOGLE_FIT") ?? false;
      daily = await TerraFlutter.getDaily("GOOGLE_FIT",
              DateTime.utc(2022, 1, 1), DateTime.utc(2022, 1, 10)) ??
          false;
    } on Exception {
      testText = "Some exception went wrong";
      initialised = false;
      connected = false;
      daily = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _initialised = initialised;
      _connected = connected;
      _daily = daily;
      _testText = testText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app for Terra SDKs'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                'Custom text test: $_testText\n',
                textAlign: TextAlign.center,
              ),
              Text(
                'Did integration init: $_initialised\n',
                textAlign: TextAlign.center,
              ),
              Text(
                'Is integration connected: $_connected\n',
                textAlign: TextAlign.center,
              ),
              Text(
                'Requested daily webhook for integration: $_daily\n',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
