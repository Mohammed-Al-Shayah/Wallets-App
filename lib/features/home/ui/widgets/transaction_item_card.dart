import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/home/ui/widgets/wallet_icon_circle.dart';

class TransactionItemCard extends StatelessWidget {
  const TransactionItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dateTime,
    required this.amountText,
    required this.icon,
    required this.iconBackgroundColor,
    required this.amountTextStyle,
    this.showStatusIcon = false,
    this.statusIcon,
    this.statusIconColor,
  });

  final String title;
  final String subtitle;
  final String dateTime;
  final String amountText;

  final IconData icon;
  final Color iconBackgroundColor;
  final TextStyle amountTextStyle;

  final bool showStatusIcon;
  final IconData? statusIcon;
  final Color? statusIconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WalletIconCircle(
            icon: icon,
            backgroundIcon: iconBackgroundColor,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TitleRow(
                  title: title,
                  showStatusIcon: showStatusIcon,
                  statusIcon: statusIcon,
                  statusIconColor: statusIconColor,
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyles.gray14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  dateTime,
                  style: TextStyles.gray14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amountText,
                style: amountTextStyle,
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow({
    required this.title,
    required this.showStatusIcon,
    this.statusIcon,
    this.statusIconColor,
  });

  final String title;
  final bool showStatusIcon;
  final IconData? statusIcon;
  final Color? statusIconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyles.black16Bold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (showStatusIcon) ...[
          const SizedBox(width: 6),
          Icon(
            statusIcon ?? Icons.check_circle_outline,
            size: 18,
            color: statusIconColor ?? Colors.green,
          ),
        ],
      ],
    );
  }
}
