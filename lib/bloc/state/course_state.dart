import 'package:flutter_application_sample_1/model/course.dart';

class CourseState {}

class CourseInitial extends CourseState {}

class LoadingCourse extends CourseState {}

class ApiRequestCourseSuccess extends CourseState {
  final Course model;
  ApiRequestCourseSuccess(this.model);
}

class ApiRequestCourseError extends CourseState {
  final String errMsg;
  ApiRequestCourseError(this.errMsg);
}

class CreateSuccesGet extends CourseState {
  final List<Course> model;

  CreateSuccesGet(this.model);
}

class SuccessGetId extends CourseState {
  final Course model;

  SuccessGetId(this.model);
}

class SuccessUpdate extends CourseState {}

class SuccessDelete extends CourseState {}
