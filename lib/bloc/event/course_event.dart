import 'package:flutter_application_sample_1/model/course.dart';

class CourseEvent {}

class CreateCourse extends CourseEvent {
  final Course model;
  CreateCourse(this.model);
}

class GetCourse extends CourseEvent {}

class SearchCourse extends CourseEvent {
  final String value;
  SearchCourse(this.value);
}

class UpdateCourse extends CourseEvent {
  final Course model;
  UpdateCourse(this.model);
}

class DeleteCourse extends CourseEvent {
  final int id;
  DeleteCourse(this.id);
  // final Course model;
  // DeleteCourse(this.model);
}
