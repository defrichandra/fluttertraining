import 'package:flutter_application_sample_1/model/create_user.dart';

class SampleState {}

class SampleInitial extends SampleState {}

class LoadingSample extends SampleState {}

class ApiRequestState extends SampleState {
  final CreateUserModel model;

  ApiRequestState(this.model);
}

class ApiRequestError extends SampleState {
  final String errMsg;
  ApiRequestError(this.errMsg);
}
