import 'dart:async';

import 'package:flutter/services.dart';

class PhoneNumber {
  final int countryCode;
  final int nationalNumber;
  final String numberExtension;

  PhoneNumber.fromMap(map)
    : this.countryCode = map['countryCode'],
      this.nationalNumber = map['nationalNumber'],
      this.numberExtension = map['numberExtension'];
}

class FlutterLibPhoneNumber {
  static const MethodChannel _channel =
      const MethodChannel('com.vizmo.flutterlibphonenumber');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<PhoneNumber> parse(String phoneNumber, {String defaultRegion = 'IN'}) async {
    final args = {
      'phoneNumber': phoneNumber,
      'defaultRegion': defaultRegion,
      'ignoreType': true
    };
    final phoneMap = await _channel.invokeMethod('parse', args);
    return PhoneNumber.fromMap(phoneMap);
  }
}
