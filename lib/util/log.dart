import 'dart:developer';

import 'package:flutter/foundation.dart';

class Log {
  Log._();

  static void d(dynamic data) {
    if (kDebugMode) {
      log('$data');
    }
  }
}
