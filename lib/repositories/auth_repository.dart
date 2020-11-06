import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pos_uga/services/dio_service.dart';
import 'package:pos_uga/utils/response_utils.dart';

abstract class AuthRepository {
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    try {
      Response response = await DioService.init().post("/auth", data: {
        "username": username,
        "password": password,
      });
      Map<String, dynamic> data = Map<String, dynamic>();
      data['statusCode'] = response.statusCode;
      data['data'] = response.data;
      return data;
    } on SocketException catch (e) {
      print(e);
      return ResponseUtils.error(e.message);
    } on DioError catch (e) {
      print(e);
      return ResponseUtils.error(e.message);
    } catch (e) {
      print(e);
      return ResponseUtils.error(e.message);
    }
  }

  static Future<Map<String, dynamic>> forgotpass(
      String username, String password) async {
    try {
      Response response =
          await DioService.init().post("/auth/forgotpass", data: {
        "username": username,
        "password": password,
      });
      Map<String, dynamic> data = Map<String, dynamic>();
      data['statusCode'] = response.statusCode;
      data['data'] = response.data;
      return data;
    } on SocketException catch (e) {
      print(e);
      return ResponseUtils.error(e.message);
    } on DioError catch (e) {
      print(e);
      return ResponseUtils.error(e.message);
    } catch (e) {
      print(e);
      return ResponseUtils.error(e.message);
    }
  }
}
