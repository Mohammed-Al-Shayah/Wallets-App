import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallets/core/networking/api_exception.dart';
import 'package:wallets/features/auth/data/repo/auth_repo.dart';
import 'package:wallets/features/auth/logic/otp/cubit/otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepo _repo;
  OtpCubit(this._repo) : super(OtpState());

  Future<void> otp(String phone, String code) async {
    emit(
      state.copyWith(isLoading: true, erorrMesseage: null, isSuccess: false),
    );
    try {
      await _repo.otp(phone: phone, code: code, purpose: 'register');
      emit(
        state.copyWith(isLoading: false, erorrMesseage: null, isSuccess: true),
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
