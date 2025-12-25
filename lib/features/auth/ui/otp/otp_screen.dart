import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/core/widgets/my_button.dart';
import 'package:wallets/core/widgets/otp_box.dart';
import 'package:wallets/features/auth/logic/otp/cubit/otp_cubit.dart';
import 'package:wallets/features/auth/logic/otp/cubit/otp_state.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController pinController = TextEditingController();
  final ValueNotifier<bool> isComplete = ValueNotifier<bool>(false);

  @override
  void dispose() {
    pinController.dispose();
    isComplete.dispose();
    super.dispose();
  }

  void _verify(String phone) {
    final String code = pinController.text.trim();
    context.read<OtpCubit>().otp(phone, code);
  }

  @override
  Widget build(BuildContext context) {
    final String? phone = ModalRoute.of(context)?.settings.arguments as String?;
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pushNamedAndRemoveUntil(
            Routes.homeScreen,
            predicate: (_) => false,
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
            title: Text('Register', style: TextStyles.blue20Bold),
            backgroundColor: Colors.white,
          ),
          backgroundColor: ColorsManager.primaryColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/svgs/v4.svg'),
                  SizedBox(height: 16.h),
                  Text('Enter OTP', style: TextStyles.blue16Medium),
                  SizedBox(height: 8.h),
                  Text(
                    'OTP sent to your phone',
                    style: TextStyles.gray16Medium,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    phone ?? '',
                    style: TextStyles.blue16Medium,
                  ),
                  SizedBox(height: 40.h),

                  OtpBoxes(controller: pinController, isComplete: isComplete),

                  SizedBox(height: 40.h),

                  ValueListenableBuilder<bool>(
                    valueListenable: isComplete,
                    builder: (context, enabled, _) {
                      return MyButton(
                        text: state.isLoading ? 'Verifying...' : 'Verify',
                        onPressed: state.isLoading || !enabled || phone == null
                            ? null
                            : () => _verify(phone),
                      );
                    },
                  ),

                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code? ",
                        style: TextStyles.gray16Medium,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Resend OTP',
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
