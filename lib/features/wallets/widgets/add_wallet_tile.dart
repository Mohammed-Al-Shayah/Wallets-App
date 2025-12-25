import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/home/ui/widgets/wallet_icon_circle.dart';

class AddWalletTile extends StatelessWidget {
  const AddWalletTile({super.key, required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffE5E5E5),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WalletIconCircle(
                icon: Icons.add,
                backgroundIcon: ColorsManager.orange.withAlpha(20),
                colorIcon: ColorsManager.orange,
              ),
              const SizedBox(width: 16),
              Text(title, style: TextStyles.black16Bold),
            ],
          ),
        ),
      ),
    );
  }
}
