
import 'package:logger/logger.dart';
import 'package:terra_flutter_bridge/models/enums.dart';
import 'package:terra_flutter_bridge/models/responses.dart';
import 'package:terra_flutter_bridge/terra_flutter_bridge.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:terra_flutter_example/generate.dart';
import 'config.dart' as constants;

var logger = Logger();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class AuthTokenResponse {
  String token;
  String status;

  AuthTokenResponse(this.token, this.status);

  factory AuthTokenResponse.fromJson(Map<String, dynamic> json) {
    return AuthTokenResponse(
      json['token'],
      json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'status': status,
      };
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
    Connection c = Connection.samsung;

    // Function messages may fail, so we use a try/catch Exception.
    // We also handle the message potentially returning null.
    // USE YOUR OWN CATCH BLOCKS
    // HAVING ALL FUNCTIONS IN THE SAME CATCH IS NOT A GOOD IDEA
    try {
      DateTime now = DateTime.now().toUtc();
      DateTime lastMidnight = DateTime(now.year, now.month, now.day);
      initialised = await TerraFlutter.initTerra(constants.devId, "test_ref2");
      // await postPlannedWorkout_();
      logger.d(initialised?.success);
      connected = await TerraFlutter.initConnection(c, (await generateToken()).token , true, []);

      testText = await TerraFlutter.getUserId(c);
      logger.d(testText?.userId as String);
      // daily = await TerraFlutter.getDaily(
      //         c, DateTime(2023, 02, 01), now);
      // // daily = await TerraFlutter.getAthlete(c);
      // // daily = await TerraFlutter.getMenstruation(
      // //         c, DateTime(2023, 02, 01), DateTime(2023, 02, 10), toWebhook: false);
      // daily = await TerraFlutter.getNutrition(
      //         c, DateTime(2023, 02, 01), DateTime(2023, 02, 10));
      // daily = await TerraFlutter.getSleep(
      //         c, DateTime(2023, 02, 01), DateTime(2023, 02, 10));
      // daily = await TerraFlutter.getActivity(
      //         c, DateTime(2023, 02, 01), DateTime(2023, 02, 03), toWebhook: false);
      logger.d("permissions:" );
      logger.d(await TerraFlutter.getGivenPermissions());
    } on Exception catch (e) {
      logger.d('error caught: $e');
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


  Future<AuthTokenResponse> generateToken() async {
    final response = await http.post(
      Uri.parse("https://api.tryterra.co/v2/auth/generateAuthToken"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Dev-Id': constants.devId,
        'x-api-key': constants.apiKey,
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return AuthTokenResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to create data.');
    }
  }

  Future<void> postPlannedWorkout_() async{
    final resp = await TerraFlutter.postPlannedWorkout(Connection.appleHealth, generateSamplePlannedWorkout());
    logger.d((resp?.success ?? false));
    final postedPlannedWorkouts = await TerraFlutter.getPlannedWorkouts(Connection.appleHealth);
    logger.d(postedPlannedWorkouts?.data.toString() ?? "No data");
    // final markComplete = await TerraFlutter.completePlannedWorkout(Connection.appleHealth, "ceef601a-23e4-4393-8483-a9f6d37b0407", DateTime.now());
    // logger.d((markComplete?.success ?? false));
    final deleteWorkout = await TerraFlutter.deletePlannedWorkout(Connection.appleHealth, "ceef601a-23e4-4393-8483-a9f6d37b0407");
    logger.d((deleteWorkout?.success ?? false));
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
