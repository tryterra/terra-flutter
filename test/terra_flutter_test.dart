import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terra_flutter_bridge/terra_flutter_bridge.dart';

void main() {
  const MethodChannel channel = MethodChannel('terra_flutter_bridge');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TerraFlutter.platformVersion, '42');
  });
}
