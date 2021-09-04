import 'package:flutter_application_sample_1/bloc/event/project_event.dart';
import 'package:flutter_application_sample_1/bloc/state/project_state.dart';
import 'package:flutter_application_sample_1/model/project.dart';
import 'package:flutter_application_sample_1/services/restapi_project.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectInitial());
  RestApiProject api = RestApiProject();
  Project model = Project();

  @override
  Stream<ProjectState> mapEventToState(ProjectEvent event) async* {
    try {
      if (event is CreateProject) {
        yield LoadingProject();
        await createProject(event.model);
      }
      if (event is GetProject) {
        yield LoadingProject();
        List<Project> getProject = await fetchData();
        yield CreateSuccesGet(getProject);
      }
      if (event is SearchProject) {
        yield LoadingProject();
        Project getProject = await getById(event.value);
        yield SuccessGetId(getProject);
      }
      if (event is UpdateProject) {
        yield LoadingProject();
        await update(event.model);
        yield SuccessUpdate();
      }
      if (event is DeleteProject) {
        yield LoadingProject();
        await delete(event.id);
        yield SuccessDelete();
      }
    } catch (e) {
      yield ApiRequestProjectError(e.toString()); //create error
    }
  }

  Future<int> createProject(Project body) async {
    var response =
        await api.createProject(body: body.toJson()) as Map<String, dynamic>;
    Project model = Project.fromJson(response['data']);
    print(response);
    return model.id;
  }

  Future<List<Project>> fetchData() async {
    var response = await api.getProject() as Map<String, dynamic>;
    List<dynamic> data = response['data'];
    List<Project> listModels = [];

    data.forEach((element) {
      listModels.add(Project.fromJson(element));
    });
    print(response);
    return listModels;
  }

  Future<Project> getById(String id) async {
    var response = await api.getById(id) as Map<String, dynamic>;
    dynamic data = response['data'];
    Project model = Project.fromJson(data);
    print(response);
    return model;
  }

  update(Project body) async {
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
