import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallets/core/networking/api_exception.dart';
import 'package:wallets/features/auth/data/repo/auth_repo.dart';
import 'package:wallets/features/auth/logic/register/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo _repo;
  RegisterCubit(this._repo) : super(const RegisterState());

  Future<void> register(
    String name,
    String phone,
    String password,
    String email,
  ) async {
    emit(
      state.copyWith(isLoading: true, erorrMesseage: null, isSuccess: false),
    );
    try {
      await _repo.register(
        name: name,
        phone: phone,
        password: password,
        email: email,
      );
      emit(
        state.copyWith(isLoading: false, isSuccess: true, erorrMesseage: null),
      );
    } catch (e) {
      if (e is ApiException) {
        emit(state.copyWith(isLoading: false, erorrMesseage: e.message));
      } else {
        emit(
          state.copyWith(isLoading: false, erorrMesseage: 'حدث خطأ غير متوقع'),
        );
      }
    }
  }
}
