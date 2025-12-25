
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.backgroundColor = ColorsManager.orange,
    this.textStyle,
    this.iconColor = Colors.white,
    this.iconBackgroundColor = Colors.white24,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 16,
    this.iconSize = 48,
    this.iconRadius = 16,
    this.spacing = 16,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  // Colors & styles
  final Color backgroundColor;
  final TextStyle? textStyle;
  final Color iconColor;
  final Color iconBackgroundColor;
  final EdgeInsetsGeometry padding;

  // Raw sizes (use .w/.h/.r from ScreenUtil)
  final double borderRadius;
  final double iconSize;
  final double iconRadius;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            Container(
              width: iconSize.w,
              height: iconSize.h,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(iconRadius.r),
              ),
              child: Icon(icon, color: iconColor),
            ),
            SizedBox(width: spacing.w),
            Expanded(
              child: Text(
                title,
                style: textStyle ?? TextStyles.white16Medium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );

    if (onTap == null) return content;

    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius.r),
      onTap: onTap,
      child: content,
    );
  }
}
