import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/home/logic/cubit/home_cubit.dart';
import 'package:wallets/features/home/logic/cubit/home_state.dart';
import 'package:wallets/features/wallets/widgets/add_wallet_tile.dart';
import 'package:wallets/features/wallets/widgets/total_balance_card.dart';
import 'package:wallets/features/wallets/widgets/wallet_item_tile.dart';

class WalletsSCreen extends StatelessWidget {
  const WalletsSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      appBar: AppBar(
        title: Text('Wallets', style: TextStyles.blue20Bold),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2) Error (اختياري تعرض صفحة خطأ بدل SnackBar فقط)
          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }

          // 3) Data
          final walletsResponse = state.wallets;
          if (walletsResponse == null) {
            return const SizedBox.shrink();
          }

          final data = walletsResponse.data;
          if (data == null || data.wallets.isEmpty) {
            return const Center(child: Text('No wallets found'));
          }

          final total = data.totalBalanceUSD ?? 0.0;
          final trans = data.monthlyTransfersUsd ?? 0.0;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                children: [
                  TotalBalanceCard(
                    title: 'Total Balance',
                    totalText: '\$ ${total.toStringAsFixed(2)}',
                    changeText: '+${trans.toStringAsFixed(2)}%',
                    compareText: 'vs last month',
                    icon: Icons.trending_up,
                  ),

                  SizedBox(height: 24.h),

                  ...data.wallets.map((w) {
                    final name = w.currencyName ?? 'Wallet';
                    final code = w.currency ?? '';
                    final amount = w.balance ?? 0.0;
                    final lastAmount = w.lastIncomingTransfer;
                    final changeText = lastAmount == null
                        ? ''
                        : '+$lastAmount%';
                    return Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: WalletItemTile(
                        name: name,
                        code: code,
                        amountText: '$code ${amount.toStringAsFixed(2)}',
                        changeText: changeText,
                        icon: Icons.attach_money,
                        iconBg: ColorsManager.blueblode,
                      ),
                    );
                  }),

                  SizedBox(height: 24.h),

                  AddWalletTile(title: 'Add Wallet', onTap: () {}),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
