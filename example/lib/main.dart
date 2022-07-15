import 'package:terra_flutter_bridge/terra_flutter_bridge.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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
    Connection c = Connection.appleHealth;
    // Function messages may fail, so we use a try/catch Exception.
    // We also handle the message potentially returning null.
    // USE YOUR OWN CATCH BLOCKS
    // HAVING ALL FUNCTIONS IN THE SAME CATCH IS NOT A GOOD IDEA
    try {
      testText = await TerraFlutter.testFunction(
              "Awaiting init functions before pulling user ID") ??
          "Some function call went wrong";
      initialised =
          await TerraFlutter.initTerra("devID", "refID", 60, 60, 60, 60, 60) ??
              false;
      connected = await TerraFlutter.initConnection(c, "token", true, [
            Permission.activity,
            Permission.daily,
            Permission.sleep,
            Permission.nutrition,
            Permission.athlete,
            Permission.body
          ], []) ??
          false;
      testText = await TerraFlutter.getUserId(c) ?? "1234";
      daily = await TerraFlutter.getDaily(
              c, DateTime.utc(2022, 1, 1), DateTime.utc(2022, 1, 2)) ??
          false;
      daily = await TerraFlutter.getAthlete(c) ?? false;
      daily = await TerraFlutter.getBody(
              c, DateTime.utc(2022, 1, 1), DateTime.utc(2022, 1, 2)) ??
          false;
      daily = await TerraFlutter.getNutrition(
              c, DateTime.utc(2022, 1, 1), DateTime.utc(2022, 1, 2)) ??
          false;
      daily = await TerraFlutter.getSleep(
              c, DateTime.utc(2022, 1, 1), DateTime.utc(2022, 1, 2)) ??
          false;
      daily = await TerraFlutter.getActivity(
              c, DateTime.utc(2022, 1, 1), DateTime.utc(2022, 1, 2)) ??
          false;
    } on Exception catch (e) {
      // print('error caught: $e');
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
                'User id: $_testText\n',
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
