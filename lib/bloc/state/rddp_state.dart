import 'package:flutter_application_sample_1/model/rddp.dart';

class RddpState {}

class RddpInitial extends RddpState {}

class LoadingRddp extends RddpState {}

class ApiRequestRddpSuccess extends RddpState {
  final Rddp model;
  ApiRequestRddpSuccess(this.model);
}

class ApiRequestRddpError extends RddpState {
  final String errMsg;
  ApiRequestRddpError(this.errMsg);
}

class CreateSuccesGet extends RddpState {
  final List<Rddp> model;

  CreateSuccesGet(this.model);
}

class SuccessGetId extends RddpState {
  final Rddp model;

  SuccessGetId(this.model);
}

class SuccessUpdate extends RddpState {}

class SuccessDelete extends RddpState {}
