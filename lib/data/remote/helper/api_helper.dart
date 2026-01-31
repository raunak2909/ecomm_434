import 'dart:convert';
import 'dart:io';

import 'package:ecomm_434/data/remote/helper/app_exception.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  getAPI() {}

  Future<dynamic> postAPI({required String url, Map<String, dynamic>? mBodyParams}) async {
    try {
      http.Response response = await http.post(Uri.parse(url), body: mBodyParams != null ? jsonEncode(mBodyParams) : null);
      return handleResponse(res: response);
    } on SocketException catch (e) {
      throw NoInternetException(exceptionMsg: e.toString());
    } catch (e) {
      rethrow;
    }
  }

  dynamic handleResponse({required http.Response res}) {
    switch (res.statusCode) {
      case 200:
        {
          ///success
          var data = jsonDecode(res.body);
          return data;
        }

      case 400:
        {
          throw BadRequestException(
            exceptionMsg: "with status code ${res.statusCode}",
          );
        }

      case 401:
        {
          throw UnAuthorisedException(
            exceptionMsg: "with status code ${res.statusCode}",
          );
        }

      case 404:
        {
          throw NoInternetException(
            exceptionMsg: "with status code ${res.statusCode}",
          );
        }

      case 500:
      default:
        {
          throw ServerException(
            exceptionMsg: "with status code ${res.statusCode}",
          );
        }
    }
  }
}
