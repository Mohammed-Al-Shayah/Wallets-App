import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallets/core/networking/api_exception.dart';
import 'package:wallets/features/home/data/repo/home_repo.dart';
import 'package:wallets/features/home/logic/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(const HomeState());

  Future<void> getWallets() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final wallets = await _homeRepo.getWallets();
      emit(state.copyWith(isLoading: false, wallets: wallets, errorMessage: null));
    } on ApiException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false, errorMessage: 'حدث خطأ غير متوقع'));
    }
  }
}
