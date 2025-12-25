import 'package:flutter/material.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/home/data/models/wallet_transactions_model.dart';

class TransactionPresentation {
  final String title;
  final String subtitle;
  final String dateText;
  final String amountText;
  final IconData icon;
  final Color iconBackgroundColor;
  final TextStyle amountTextStyle;
  final IconData statusIcon;
  final Color statusIconColor;

  const TransactionPresentation({
    required this.title,
    required this.subtitle,
    required this.dateText,
    required this.amountText,
    required this.icon,
    required this.iconBackgroundColor,
    required this.amountTextStyle,
    required this.statusIcon,
    required this.statusIconColor,
  });
}

TransactionPresentation mapTransactionToPresentation(
  TransactionItem tx, {
  required String currency,
}) {
  final isCredit = tx.type == 'credit';
  final amount = tx.totalAmount ?? tx.amount ?? 0;
  final amountText =
      '${isCredit ? '+' : '-'}$currency ${amount.toStringAsFixed(2)}';

  final icon = isCredit ? Icons.arrow_downward : Icons.arrow_outward_rounded;
  final bgColor = isCredit
      ? ColorsManager.lightGreen.withAlpha(70)
      : ColorsManager.orange.withAlpha(70);
  final textStyle =
      isCredit ? TextStyles.green16Medium : TextStyles.black16Medium;

  final statusOk = (tx.status ?? '').toLowerCase() == 'completed';
  final statusIcon = statusOk ? Icons.check_circle_outline : Icons.access_time;
  final statusColor =
      statusOk ? ColorsManager.lightGreen : ColorsManager.orange;

  final title = tx.description ?? 'Transaction';
  final subtitle = tx.reference ?? '';
  final dateText = formatTransactionDate(tx.createdAt);

  return TransactionPresentation(
    title: title,
    subtitle: subtitle,
    dateText: dateText,
    amountText: amountText,
    icon: icon,
    iconBackgroundColor: bgColor,
    amountTextStyle: textStyle,
    statusIcon: statusIcon,
    statusIconColor: statusColor,
  );
}

String formatTransactionDate(String? raw) {
  if (raw == null || raw.isEmpty) return '';
  try {
    final dt = DateTime.parse(raw);
    String two(int v) => v.toString().padLeft(2, '0');
    return '${dt.year}-${two(dt.month)}-${two(dt.day)} ${two(dt.hour)}:${two(dt.minute)}';
  } catch (_) {
    return raw.replaceAll('T', ' ').split('.').first;
  }
}
