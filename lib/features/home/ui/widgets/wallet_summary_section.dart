import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/features/home/data/models/wallet_balance_card_data.dart';
import 'package:wallets/features/home/ui/widgets/wallet_summary_header.dart';
import 'package:wallets/features/home/ui/widgets/walletbalance_card.dart';

class WalletSummarySection extends StatelessWidget {
  const WalletSummarySection({
    super.key,
    required this.title,
    required this.totalAmountText,
    required this.totalIcon,
    required this.cards,
    this.padding,
    this.gradientColors,
    this.gradientRotation,
    this.onTapIcon,
  });

  final String title;
  final String totalAmountText;
  final IconData totalIcon;
  final List<WalletBalanceCardData> cards;

  final EdgeInsetsGeometry? padding;
  final List<Color>? gradientColors;
  final double? gradientRotation;
  final VoidCallback? onTapIcon;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors =
        gradientColors ??
        const [Color(0xff181818), Color.fromARGB(255, 43, 43, 43)];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          transform: GradientRotation(gradientRotation ?? 5),
        ),
      ),
      child: Padding(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          children: [
            WalletSummaryHeader(
              title: title,
              amountText: totalAmountText,
              icon: totalIcon,
              onTapIcon: onTapIcon,
            ),
            SizedBox(height: 24.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: cards
                    .map(
                      (c) => Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: SizedBox(
                          width: 300.w,
                          child: WalletBalanceCard(
                            currencyCode: c.currencyCode,
                            amountText: c.amountText,
                            icon: c.icon,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
