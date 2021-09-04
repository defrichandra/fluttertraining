import 'package:flutter_application_sample_1/model/project.dart';

class ProjectState {}

class ProjectInitial extends ProjectState {}

class LoadingProject extends ProjectState {}

class ApiRequestProjectSuccess extends ProjectState {
  final Project model;
  ApiRequestProjectSuccess(this.model);
}

class ApiRequestProjectError extends ProjectState {
  final String errMsg;
  ApiRequestProjectError(this.errMsg);
}

class CreateSuccesGet extends ProjectState {
  final List<Project> model;

  CreateSuccesGet(this.model);
}

class SuccessGetId extends ProjectState {
  final Project model;

  SuccessGetId(this.model);
}

class SuccessUpdate extends ProjectState {}

class SuccessDelete extends ProjectState {}
