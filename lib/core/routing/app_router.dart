import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallets/core/di/service_locator.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/features/auth/logic/login/cubit/login_cubit.dart';
import 'package:wallets/features/auth/logic/otp/cubit/otp_cubit.dart';
import 'package:wallets/features/auth/logic/register/cubit/register_cubit.dart';
import 'package:wallets/features/auth/ui/login/login_screen.dart';
import 'package:wallets/features/get_start/ui/get_start_screen.dart';
import 'package:wallets/features/home/logic/cubit/home_cubit.dart';
import 'package:wallets/features/home/ui/home_screen.dart';
import 'package:wallets/features/transaction_history/ui/transaction_history_screen.dart';
import 'package:wallets/features/onboarding/ui/onboarding_screen.dart';
import 'package:wallets/features/auth/ui/otp/otp_screen.dart';
import 'package:wallets/features/auth/ui/register/register_screen.dart';
import 'package:wallets/features/wallets/ui/wallets_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onbordingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.getStartScreen:
        return MaterialPageRoute(builder: (context) => const GetStartScreen());
      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HomeCubit>()
              ..getWallets()
              ..getAllTransactions(),
            child: const HomeScreen(),
          ),
        );
      case Routes.otpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<OtpCubit>(),
            child: const OtpScreen(),
          ),
          settings: settings,
        );
      case Routes.walletsScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HomeCubit>()..getWallets(),
            child: const WalletsSCreen(),
          ),
        );
      case Routes.transactionHistoryScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HomeCubit>()
              ..getWallets()
              ..getAllTransactions(),
            child: const TransactionHistoryScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Center(child: Text('404 Not Found')),
        );
    }
  }
}
