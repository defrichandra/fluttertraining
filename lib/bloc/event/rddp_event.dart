import 'package:flutter_application_sample_1/model/rddp.dart';

class RddpEvent {}

class CreateRddp extends RddpEvent {
  final Rddp model;
  CreateRddp(this.model);
}

class GetRddp extends RddpEvent {}

class SearchRddp extends RddpEvent {
  final String value;
  SearchRddp(this.value);
}

class UpdateRddp extends RddpEvent {
  final Rddp model;
  UpdateRddp(this.model);
}

class DeleteRddp extends RddpEvent {
  final int id;
  DeleteRddp(this.id);
}
