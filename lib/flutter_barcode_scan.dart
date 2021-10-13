
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterBarcodeScan {
  static const MethodChannel _channel = MethodChannel('flutter_barcode_scan');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
