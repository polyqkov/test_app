import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:test_app/data/api/exceptions/reg_exception.dart';
import 'package:test_app/data/api/models/reg_model.dart';
import 'package:test_app/data/api/service/api_service.dart';
import 'package:test_app/domain/models/user_model.dart';

part 'event.dart';
part 'state.dart';

class RegBloc extends Bloc<RegEvent, RegState> {
  RegBloc() : super(const RegState()) {
    on<RegFetchEvent>(_mapFetchRegEventToState);
  }

  Future<void> _mapFetchRegEventToState(
      RegFetchEvent event, Emitter<RegState> emit) async {
    emit(state.copyWith(status: RegStatus.none));
    try {
      emit(state.copyWith(status: RegStatus.loading));

      UserModel userModel = await ApiService()
          .reg(email: event.regModel.email, password: event.regModel.password);

      emit(state.copyWith(status: RegStatus.done, userModel: userModel));
    } on RegException catch (error) {
      Logger().e(error);

      emit(state.copyWith(
          status: RegStatus.error, error: error.message.toString()));
    }
  }
}
