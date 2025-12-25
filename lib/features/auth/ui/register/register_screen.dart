import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/core/widgets/text_form_field_widget.dart';
import 'package:wallets/features/auth/logic/register/cubit/register_cubit.dart';
import 'package:wallets/features/auth/logic/register/cubit/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pushReplacementNamed(
            Routes.otpScreen,
            arguments: phoneController.text.trim(),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم التسجيل بنجاح يرجى تفيعل الحساب')),
          );
        }
        if (state.erorrMesseage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.erorrMesseage!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Register', style: TextStyles.black20SemiBold),
            backgroundColor: Colors.white,
          ),
          backgroundColor: ColorsManager.primaryColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sign Up', style: TextStyles.black20SemiBold),
                  SizedBox(height: 7.h),
                  Text(
                    'Create your wallet account',
                    style: TextStyles.gray16Medium,
                  ),
                  SizedBox(height: 34.h),
                  FieldWidget(
                    label: 'Full Name',
                    controller: nameController,
                    hintText: 'John Doe',
                    prefixIcon: Icons.person_outline_rounded,
                  ),
                  SizedBox(height: 15.h),

                  FieldWidget(
                    label: 'Phone',
                    controller: phoneController,
                    hintText: '+966 50 123 4567',
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 15.h),

                  FieldWidget(
                    label: 'Email',
                    controller: emailController,
                    hintText: 'john@example.com',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 15.h),

                  FieldWidget(
                    label: 'Password',
                    controller: passwordController,
                    hintText: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 15.h),

                  FieldWidget(
                    label: 'Confirm Password',
                    controller: passwordController,
                    hintText: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 44.h),
                  MyButton(
                    text: state.isLoading ? 'Loding . . .' : 'Sign Up',
                    onPressed: state.isLoading
                        ? null
                        : () {
                            context.read<RegisterCubit>().register(
                              nameController.text.trim(),
                              phoneController.text.trim(),
                              passwordController.text.trim(),
                              emailController.text.trim(),
                            );
                          },
                  ),

                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyles.gray16Medium,
                      ),
                      InkWell(
                        onTap: () {
                          context.pushNamed(Routes.loginScreen);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyles.orange16SemiBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
