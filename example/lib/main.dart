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
  DataMessage? daily;

  @override
  void initState() {
    super.initState();
    initTerraFunctionState();
  }

  // Function messages are asynchronous, so we initialize in an async method.
  Future<void> initTerraFunctionState() async {
    SuccessMessage? initialised;
    SuccessMessage? connected;
    UserId? testText;
    Connection c = Connection.appleHealth;
    // Function messages may fail, so we use a try/catch Exception.
    // We also handle the message potentially returning null.
    // USE YOUR OWN CATCH BLOCKS
    // HAVING ALL FUNCTIONS IN THE SAME CATCH IS NOT A GOOD IDEA
    try {
      DateTime now = DateTime.now().toUtc();
      DateTime lastMidnight = DateTime(now.year, now.month, now.day);
      initialised = await TerraFlutter.initTerra("DEVID", "refId");
      print(initialised?.success);
      connected = await TerraFlutter.initConnection(c, "TOKEN", false, []);

      testText = await TerraFlutter.getUserId(c);
      print(testText?.userId);
      daily = await TerraFlutter.getDaily(
              c, lastMidnight, now);
      // daily = await TerraFlutter.getAthlete(c);
      // daily = await TerraFlutter.getMenstruation(
      //         c, DateTime(2023, 02, 01), DateTime(2023, 02, 10), toWebhook: false);
      daily = await TerraFlutter.getNutrition(
              c, DateTime(2023, 02, 01), DateTime(2023, 02, 10));
      daily = await TerraFlutter.getSleep(
              c, DateTime(2023, 02, 01), DateTime(2023, 02, 10));
      daily = await TerraFlutter.getActivity(
              c, DateTime(2023, 02, 01), DateTime(2023, 02, 03), toWebhook: false);
      print(await TerraFlutter.isHealthConnectAvailable());
    } on Exception catch (e) {
      print('error caught: $e');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _initialised = initialised?.success ?? false;
      _connected = connected?.success ?? false;
      _testText = testText?.userId ?? "";
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
                'Requested daily webhook for integration: $daily\n',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
