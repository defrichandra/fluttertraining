import 'package:flutter_application_sample_1/services/api_url.dart';
import 'package:flutter_application_sample_1/services/net_util.dart';

class RestApiRddp extends UrlApi {
  NetworkUtil _util = new NetworkUtil();

  Future<dynamic> createRddp({Map<String, dynamic> body}) {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return _util.post(localUrl + "/rddp", body: body, header: header).then(
      (value) {
        print(value.toString());
        return value;
      },
    );
  }

  Future<dynamic> getRddp() {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return _util.get(localUrl + "/rddp", header: header).then((value) {
      print(value.toString());
      return value;
    });
  }

  Future<dynamic> getById(String id) {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    return _util.get(localUrl + "/rddp/$id", header: header).then((value) {
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
        .delete(localUrl + "/rddp/$id", body: body, header: header)
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
    return _util.put(localUrl + "/rddp/$id", body: body, header: header).then(
      (value) {
        print(value.toString());
        return value;
      },
    );
  }
}
