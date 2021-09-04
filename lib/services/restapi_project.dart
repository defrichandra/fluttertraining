import 'package:flutter_application_sample_1/services/api_url.dart';
import 'package:flutter_application_sample_1/services/net_util.dart';

class RestApiProject extends UrlApi {
  NetworkUtil _util = new NetworkUtil();

  Future<dynamic> createProject({Map<String, dynamic> body}) {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return _util.post(localUrl + "/project", body: body, header: header).then(
      (value) {
        print(value.toString());
        return value;
      },
    );
  }

  Future<dynamic> getProject() {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return _util.get(localUrl + "/project", header: header).then((value) {
      print(value.toString());
      return value;
    });
  }

  Future<dynamic> getById(String id) {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return _util.get(localUrl + "/project/$id", header: header).then((value) {
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
        .delete(localUrl + "/project/$id", body: body, header: header)
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
        .put(localUrl + "/project/$id", body: body, header: header)
        .then(
      (value) {
        print(value.toString());
        return value;
      },
    );
  }
}
