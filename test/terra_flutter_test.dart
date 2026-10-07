import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terra_flutter_bridge/terra_flutter_bridge.dart';

void main() {
  const MethodChannel channel = MethodChannel('terra_flutter_bridge');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      return '${methodCall.method}:${methodCall.arguments['text']}';
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('testFunction round-trips over the plugin channel', () async {
    expect(await TerraFlutter.testFunction('hello'), 'testFunction:hello');
  });
}
