import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletIconCircle extends StatelessWidget {
  const WalletIconCircle({
    super.key,
    required this.icon,
    required this.backgroundIcon,
    this.colorIcon,
    this.onTapIcon,
  });

  final IconData icon;
  final Color backgroundIcon;
  final Color? colorIcon;
  final VoidCallback? onTapIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapIcon,
      child: Container(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: backgroundIcon,
        ),
        child: Icon(icon, color: colorIcon),
      ),
    );
  }
}
