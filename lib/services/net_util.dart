import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_sample_1/helper/app_exception.dart';
import 'package:http/http.dart' as http;

class NetworkUtil {
  // method dibuat berdasarkan jenis req api
  //Future<dynamic> post(String url, {Map<String, String> body})
  Future<dynamic> post(String url,
      {Map<String, dynamic> body, Map<String, String> header}) async {
    print(url);
    print(body);
    String jsonBody = json.encode(body);
    // jenis req http.post/put/delete etc disesuaikan dengan contoh api
    return await http.post(url, body: jsonBody, headers: header).then(
          (http.Response response) => _returnResponse(response),
        );
  }

  //untuk find all
  Future<dynamic> get(String url, {Map<String, String> header}) async {
    print(url);
    // jenis req http.post/put/delete etch disesuaikan dengan contoh api
    return await http.get(url, headers: header).then(
          (http.Response response) => _returnResponse(response),
        );
  }

  //untuk delete
  Future<dynamic> delete(String url,
      {Map<String, dynamic> body, Map<String, String> header}) async {
    print(url);
    // jenis req http.post/put/delete etch disesuaikan dengan contoh api
    return await http.delete(url, headers: header).then(
          (http.Response response) => _returnResponse(response),
        );
  }

  // untuk update
  Future<dynamic> put(String url,
      {Map<String, dynamic> body, Map<String, String> header}) async {
    print(url);
    print(body);
    String jsonBody = json.encode(body);
    // jenis req http.post/put/delete etc disesuaikan dengan contoh api
    return await http.put(url, body: jsonBody, headers: header).then(
          (http.Response response) => _returnResponse(response),
        );
  }

  //untuk patch
  // Future<dynamic> patch(String url,
  //     {Map<String, dynamic> body, Map<String, dynamic> header}) async {
  //   print(url);
  //   print(body);

  //   String jsonBody = json.encode(body);
  //   return await http.patch(url, body: jsonBody, headers: header).then(
  //         (http.Response response) => _returnResponse(response),
  //       );
  // }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson;
        if (response.body is String && response.body.isNotEmpty) {
          responseJson = json.decode(response.body.toString());
        } else {
          responseJson = response.body;
        }
        return responseJson;
      case 201:
        var responseJson;
        if (response.body is String && response.body.isNotEmpty) {
          responseJson = json.decode(response.body.toString());
        } else {
          responseJson = response.body;
        }
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        throw BadRequestException(responseJson['error']);
      case 401:
        throw RefreshTokenFailedException('Response 401');
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        var responseJson = json.decode(response.body.toString());
        throw FetchDataException(responseJson['error']);
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
