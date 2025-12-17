import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/home/ui/widgets/wallet_icon_circle.dart';

class WalletItemTile extends StatelessWidget {
  const WalletItemTile({
    super.key,
    required this.name,
    required this.code,
    required this.amountText,
    required this.changeText,
    required this.icon,
    required this.iconBg,
    this.iconColor = Colors.white,
    this.onTap,
  });

  final String name; // US Dollar
  final String code; // USD
  final String amountText; // $ 12,450.50
  final String changeText; // +5.2%
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(21),
          child: Row(
            children: [
              WalletIconCircle(
                icon: icon,
                backgroundIcon: iconBg,
                colorIcon: iconColor,
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyles.blue16bold),
                  Text(code, style: TextStyles.gray16Medium),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(amountText, style: TextStyles.blue16bold),
                  Text(changeText, style: TextStyles.green16Medium),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
