import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/home/ui/widgets/wallet_icon_circle.dart';

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({
    super.key,
    required this.currencyCode,
    required this.amountText,
    required this.icon,
  });

  final String currencyCode;
  final String amountText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 363.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color.fromARGB(255, 235, 231, 231).withAlpha(30),
        border: Border.all(color: ColorsManager.gray),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 21.w),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(currencyCode, style: TextStyles.white16Medium),
                Text(amountText, style: TextStyles.white24Bold),
              ],
            ),
            const Spacer(),
            WalletIconCircle(icon: icon ,backgroundIcon: ColorsManager.gray,),
          ],
        ),
      ),
    );
  }
}
