import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';

class TotalBalanceCard extends StatelessWidget {
  const TotalBalanceCard({
    super.key,
    required this.title,
    required this.totalText,
    required this.changeText,
    required this.compareText,
    this.icon = Icons.trending_up,
    this.onTap,
  });

  final String title;
  final String totalText;
  final String changeText; // +8.5%
  final String compareText; // vs last month
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.orange,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: ColorsManager.grayLight,
              offset: const Offset(10, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyles.black16Medium),
                  Text(totalText, style: TextStyles.black16Bold),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Text(changeText, style: TextStyles.green16Medium),
                      Text('\t$compareText', style: TextStyles.gray16Medium),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: Colors.black.withAlpha(10),
                ),
                child: Icon(icon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
