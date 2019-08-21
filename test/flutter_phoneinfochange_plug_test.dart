import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_phoneinfochange_plug/flutter_phoneinfochange_plug.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_phoneinfochange_plug');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterPhoneinfochangePlug.platformVersion, '42');
  });
}
