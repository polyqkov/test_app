import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:test_app/data/api/exceptions/auth_exception.dart';
import 'package:test_app/data/api/models/auth_model.dart';
import 'package:test_app/data/api/service/api_service.dart';
import 'package:test_app/domain/models/user_model.dart';

part 'event.dart';
part 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthFetchEvent>(_mapFetchAuthEventToState);
  }

  Future<void> _mapFetchAuthEventToState(
      AuthFetchEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.none));
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      UserModel userModel = await ApiService().auth(
          email: event.authModel.email, password: event.authModel.password);

      emit(state.copyWith(status: AuthStatus.done, userModel: userModel));
    } on AuthException catch (error) {
      Logger().e(error);

      emit(state.copyWith(
          status: AuthStatus.error, error: error.message.toString()));
    }
  }
}
