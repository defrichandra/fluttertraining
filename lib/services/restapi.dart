import 'package:flutter_application_sample_1/services/api_url.dart';
import 'package:flutter_application_sample_1/services/net_util.dart';

class RestApi extends UrlApi {
  NetworkUtil _util = new NetworkUtil();

  Future<dynamic> create({Map<String, String> body}) {
    return _util
        .post(
      baseUrl + "api/users",
      body: body,
    )
        .then(
      (value) {
        print(value.toString());
        return value;
      },
    );
  }

  Future<dynamic> createCourse({Map<String, dynamic> body}) {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return _util
        .post(localUrl + "/mst_course", body: body, header: header)
        .then(
      (value) {
        print(value.toString());
        return value;
      },
    );
  }

  Future<dynamic> getCourse() {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return _util.get(localUrl + "/mst_course", header: header).then((value) {
      print(value.toString());
      return value;
    });
  }

  Future<dynamic> getById(String id) {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return _util
        .get(localUrl + "/mst_course/$id", header: header)
        .then((value) {
      print(value.toString());
      return value;
    });
  }

  Future<dynamic> delete({int id, Map<String, dynamic> body}) {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return _util
        .delete(localUrl + "/mst_course/$id", body: body, header: header)
        .then(
      (value) {
        print(value.toString());
        return value;
      },
    );
  }

  Future<dynamic> update({int id, Map<String, dynamic> body}) {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return _util
        .put(localUrl + "/mst_course/$id", body: body, header: header)
        .then(
      (value) {
        print(value.toString());
        return value;
      },
    );
  }
}
