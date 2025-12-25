import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallets/core/networking/api_exception.dart';
import 'package:wallets/features/auth/data/repo/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _repo;

  LoginCubit(this._repo) : super(const LoginState());

  Future<void> login(String phone, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    try {
      await _repo.login(phone: phone, password: password);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      if (e is ApiException) {
        emit(state.copyWith(isLoading: false, errorMessage: e.message));
      } else {
        emit(
          state.copyWith(isLoading: false, errorMessage: 'حدث خطأ غير متوقع'),
        );
      }
    }
  }
}
