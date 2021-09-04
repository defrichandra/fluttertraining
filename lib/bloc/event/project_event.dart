import 'package:flutter_application_sample_1/model/project.dart';

class ProjectEvent {}

class CreateProject extends ProjectEvent {
  final Project model;
  CreateProject(this.model);
}

class GetProject extends ProjectEvent {}

class SearchProject extends ProjectEvent {
  final String value;
  SearchProject(this.value);
}

class UpdateProject extends ProjectEvent {
  final Project model;
  UpdateProject(this.model);
}

class DeleteProject extends ProjectEvent {
  final int id;
  DeleteProject(this.id);
}
