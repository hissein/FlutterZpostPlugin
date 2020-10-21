import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ZpostCliv2/ZpostCliv2.dart';

void main() {
  const MethodChannel channel = MethodChannel('ZpostCliv2');

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
    expect(await ZpostCliv2.platformVersion, '42');
  });
}
