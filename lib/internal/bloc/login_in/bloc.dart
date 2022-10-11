import 'package:bloc/bloc.dart';
import 'package:test_app/data/local/service/local_service.dart';
part 'event.dart';
part 'state.dart';

class LogInOutBloc extends Bloc<LogInOutEvent, LogInOutState> {
  LogInOutBloc() : super(const LogInOutState()) {
    on<LogInEvent>(_mapFetchLogInEventToState);
    on<LogOutEvent>(_mapFetchLogOutEventToState);
  }

  void _mapFetchLogInEventToState(
      LogInEvent event, Emitter<LogInOutState> emit) {
    emit(state.copyWith(status: LogInOutStatus.none));

    emit(state.copyWith(status: LogInOutStatus.login));
  }

  Future<void> _mapFetchLogOutEventToState(
      LogOutEvent event, Emitter<LogInOutState> emit) async {
    emit(state.copyWith(status: LogInOutStatus.none));
    await LocalService().deleteApiKey();
    emit(state.copyWith(status: LogInOutStatus.logout));
  }
}
