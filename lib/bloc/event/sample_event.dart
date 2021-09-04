import 'package:flutter_application_sample_1/model/create_user.dart';

class SampleEvent {}

class RequestApi extends SampleEvent {
  final CreateUserModel model;

  RequestApi(this.model);
}
