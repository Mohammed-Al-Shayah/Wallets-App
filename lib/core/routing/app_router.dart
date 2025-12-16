import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallets/core/di/service_locator.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/features/auth/logic/login/cubit/login_cubit.dart';
import 'package:wallets/features/auth/ui/login/login_screen.dart';
import 'package:wallets/features/get_start/ui/get_start_screen.dart';
import 'package:wallets/features/home/ui/home_screen.dart';
import 'package:wallets/features/onboarding/ui/onboarding_screen.dart';
import 'package:wallets/features/auth/ui/otp/otp_screen.dart';
import 'package:wallets/features/auth/ui/register/register_screen.dart';

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
          builder: (context) => RegisterScreen.blocProvider(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Routes.otpScreen:
        return MaterialPageRoute(builder: (context) => const OtpScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const Center(child: Text('404 Not Found')),
        );
    }
  }
}
