import 'package:flutter/material.dart';

class WalletBalanceCardData {
  const WalletBalanceCardData({
    required this.currencyCode,
    required this.amountText,
    required this.icon,
  });

  final String currencyCode;
  final String amountText;
  final IconData icon;
}
