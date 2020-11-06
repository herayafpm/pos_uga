import 'dart:io';
import 'package:pos_uga/utils/response_utils.dart';

abstract class ConnectionRepository {
  // ignore: missing_return
  static Future<Map<String, dynamic>> init() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return ResponseUtils.ok("Berhasil");
      }
    } on SocketException catch (e) {
      return ResponseUtils.error(e.message.toString());
    }
  }
}
