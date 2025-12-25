import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/core/widgets/text_form_field_widget.dart';
import 'package:wallets/features/auth/logic/login/cubit/login_cubit.dart';
import 'package:wallets/features/auth/logic/login/cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pushReplacementNamed(Routes.homeScreen);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("تم تسجيل الدخول بنجاح")));
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsManager.primaryColor,
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 80.h, right: 24.w, left: 24.w),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/svgs/wallets.svg'),
                    SizedBox(height: 16.h),
                    Text('Welcome', style: TextStyles.blue20Bold),
                    SizedBox(height: 8.h),
                    Text('Login', style: TextStyles.gray16Medium),
                    SizedBox(height: 40.h),
                    FieldWidget(
                      label: 'Phone',
                      controller: phoneController,
                      hintText: '+966 50 123 4567',
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 24.h),

                    FieldWidget(
                      label: 'Password',
                      controller: passwordController,
                      hintText: '••••••••',
                      isPassword: true,
                      prefixIcon: Icons.lock,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 8.h),

                    Row(
                      children: [
                        Spacer(),
                        Text(
                          'Forgot Password?',
                          style: TextStyles.orange16SemiBold,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    MyButton(
                      text: state.isLoading ? 'Loading . . .' : 'Sign In',
                      // Disable the button while loading; otherwise trigger login directly.
                      onPressed: state.isLoading
                          ? null
                          : () {
                              context.read<LoginCubit>().login(
                                phoneController.text.trim(),
                                passwordController.text.trim(),
                              );
                            },
                    ),
                    SizedBox(height: 40.h),

                    InkWell(
                      onTap: () => context.pushNamed(Routes.registerScreen),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dont't have an account? ",
                            style: TextStyles.gray16Medium,
                          ),
                          Text('Sign Up', style: TextStyles.orange16SemiBold),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
