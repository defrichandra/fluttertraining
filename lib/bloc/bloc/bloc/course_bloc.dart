import 'package:flutter_application_sample_1/bloc/event/course_event.dart';
import 'package:flutter_application_sample_1/bloc/state/course_state.dart';
import 'package:flutter_application_sample_1/model/course.dart';
import 'package:flutter_application_sample_1/services/restapi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseInitial());
  RestApi api = RestApi();
  Course model = Course();

  @override
  Stream<CourseState> mapEventToState(CourseEvent event) async* {
    try {
      if (event is CreateCourse) {
        yield LoadingCourse();
        //await Future<void>.delayed(Duration(seconds: 3));
        await createCourse(event.model);
      }
      if (event is GetCourse) {
        yield LoadingCourse();
        List<Course> getCourse = await fetchData();
        yield CreateSuccesGet(getCourse);
      }
      if (event is SearchCourse) {
        yield LoadingCourse();
        Course getCourse = await getById(event.value);
        yield SuccessGetId(getCourse);
      }
      if (event is UpdateCourse) {
        yield LoadingCourse();
        await update(event.model);
        yield SuccessUpdate();
      }
      if (event is DeleteCourse) {
        yield LoadingCourse();
        await delete(event.id);
        yield SuccessDelete();
      }
    } catch (e) {
      yield ApiRequestCourseError(e.toString()); //create error
    }
  }

  //Method 1 untuk menjalankan request melalui restAPI untuk course hardcode di api_course
  // createCourse(Course model) async {
  //   var response =
  //       await api.createCourse(body: model.toJson()) as Map<String, dynamic>;
  //   this.model = Course.fromJson(response['data']);
  //   print(response);
  // }

  Future<int> createCourse(Course body) async {
    var response =
        await api.createCourse(body: body.toJson()) as Map<String, dynamic>;
    Course model = Course.fromJson(response['data']);
    print(response);
    return model.id;
  }

  Future<List<Course>> fetchData() async {
    var response = await api.getCourse() as Map<String, dynamic>;
    List<dynamic> data = response['data'];
    List<Course> listModel = [];

    data.forEach((element) {
      listModel.add(Course.fromJson(element));
    });
    print(response);
    return listModel;
  }

  Future<Course> getById(String id) async {
    var response = await api.getById(id) as Map<String, dynamic>;
    dynamic data = response['data'];
    Course model = Course.fromJson(data);
    print(response);
    return model;
  }

  update(Course body) async {
    int id = body.id;
    body.id = null;
    var response =
        await api.update(id: id, body: body.toJson()) as Map<String, dynamic>;
    print(response);
  }

  delete(int id) async {
    var response = await api.delete(id: id) as Map<String, dynamic>;
    print(response);
  }
}
