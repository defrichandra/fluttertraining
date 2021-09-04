import 'package:flutter_application_sample_1/bloc/event/sample_event.dart';
import 'package:flutter_application_sample_1/bloc/state/sample_state.dart';

import 'package:flutter_application_sample_1/model/create_user.dart';
import 'package:flutter_application_sample_1/services/restapi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SampleBloc extends Bloc<SampleEvent, SampleState> {
  SampleBloc() : super(SampleInitial());
  RestApi api = RestApi();
  CreateUserModel model = CreateUserModel();

  @override
  Stream<SampleState> mapEventToState(SampleEvent event) async* {
    try {
      if (event is RequestApi) {
        yield LoadingSample();
        await create(event.model);
        await Future<void>.delayed(Duration(seconds: 2));

        yield ApiRequestState(this.model); //create success

      }
    } catch (e) {
      yield ApiRequestError(e.toString()); //create error
    }
  }

  create(CreateUserModel model) async {
    Map<String, dynamic> response = await api.create(body: model.toJson());
    this.model = CreateUserModel.map(response);
  }
}
