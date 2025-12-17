import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallets/core/networking/api_constants.dart';
import 'package:wallets/core/networking/api_service.dart';
import 'package:wallets/core/networking/dio_factory.dart';
import 'package:wallets/core/storage/token_storage.dart';
import 'package:wallets/core/storage/user_storage.dart';
import 'package:wallets/features/auth/data/repo/auth_repo.dart';
import 'package:wallets/features/auth/data/repo/auth_repo_impl.dart';
import 'package:wallets/features/auth/logic/login/cubit/login_cubit.dart';
import 'package:wallets/features/auth/logic/otp/cubit/otp_cubit.dart';
import 'package:wallets/features/auth/logic/register/cubit/register_cubit.dart';
import 'package:wallets/features/home/data/repo/home_repo.dart';
import 'package:wallets/features/home/data/repo/home_repo_impl.dart';
import 'package:wallets/features/home/logic/cubit/home_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  // TokenStorage
  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage(getIt()));
  // UserStorage
  getIt.registerLazySingleton<UserStorage>(() => UserStorage(getIt()));

  // Dio
  getIt.registerLazySingleton(() {
    return DioFactory.create(
      baseUrl: ApiConstants.baseApiUrl,
      tokenProvider: () => getIt<TokenStorage>().getToken(),
    );
  });

  // ApiService
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt()));

  // Repositories
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(getIt<UserStorage>(), api: getIt(), tokenStorage: getIt()),
  );
  getIt.registerSingleton<HomeRepo>(HomeRepoImpl(getIt()));

  // 6) Cubits (factory)
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
  getIt.registerFactory<OtpCubit>(() => OtpCubit(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
}
