import 'package:flutter_application_sample_1/bloc/event/rddp_event.dart';
import 'package:flutter_application_sample_1/bloc/state/rddp_state.dart';
import 'package:flutter_application_sample_1/model/rddp.dart';
import 'package:flutter_application_sample_1/services/restapi_rddp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RddpBloc extends Bloc<RddpEvent, RddpState> {
  RddpBloc() : super(RddpInitial());
  RestApiRddp api = RestApiRddp();
  Rddp model = Rddp();

  @override
  Stream<RddpState> mapEventToState(RddpEvent event) async* {
    try {
      if (event is CreateRddp) {
        yield LoadingRddp();
        await createRddp(event.model);
      }
      if (event is GetRddp) {
        yield LoadingRddp();
        List<Rddp> getRddp = await fetchData();
        yield CreateSuccesGet(getRddp);
      }
      if (event is SearchRddp) {
        yield LoadingRddp();
        Rddp getRddp = await getById(event.value);
        yield SuccessGetId(getRddp);
      }
      if (event is UpdateRddp) {
        yield LoadingRddp();
        await update(event.model);
        yield SuccessUpdate();
      }
      if (event is DeleteRddp) {
        yield LoadingRddp();
        await delete(event.id);
        yield SuccessDelete();
      }
    } catch (e) {
      yield ApiRequestRddpError(e.toString()); //create error
    }
  }

  Future<int> createRddp(Rddp body) async {
    var response =
        await api.createRddp(body: body.toJson()) as Map<String, dynamic>;
    Rddp model = Rddp.fromJson(response['data']);
    print(response);
    return model.id;
  }

  Future<List<Rddp>> fetchData() async {
    var response = await api.getRddp() as Map<String, dynamic>;
    List<dynamic> data = response['data'];
    List<Rddp> listModel = [];

    data.forEach((element) {
      listModel.add(Rddp.fromJson(element));
    });
    print(response);
    return listModel;
  }

  Future<Rddp> getById(String id) async {
    var response = await api.getById(id) as Map<String, dynamic>;
    dynamic data = response['data'];
    Rddp model = Rddp.fromJson(data);
    print(response);
    return model;
  }

  update(Rddp body) async {
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
