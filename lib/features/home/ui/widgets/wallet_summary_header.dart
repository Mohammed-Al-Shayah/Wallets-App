import 'package:flutter/material.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/home/ui/widgets/wallet_icon_circle.dart';

class WalletSummaryHeader extends StatelessWidget {
  const WalletSummaryHeader({
    super.key,
    required this.title,
    required this.amountText,
    required this.icon,
    this.onTapIcon,
  });

  final String title;
  final String amountText;
  final IconData icon;
  final VoidCallback? onTapIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyles.white16Medium),
            Text(amountText, style: TextStyles.white24Bold),
          ],
        ),
        const Spacer(),
        WalletIconCircle(
          icon: icon,
          backgroundIcon: ColorsManager.gray,
          onTapIcon: onTapIcon,
        ),
      ],
    );
  }
}
