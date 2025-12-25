import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/helper/extensions.dart';
import 'package:wallets/core/routing/route.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/home/data/models/wallets_model.dart';
import 'package:wallets/features/home/data/models/wallet_transactions_model.dart';
import 'package:wallets/features/home/data/models/wallet_balance_card_data.dart';
import 'package:wallets/features/home/logic/cubit/home_cubit.dart';
import 'package:wallets/features/home/logic/cubit/home_state.dart';
import 'package:wallets/features/home/ui/widgets/appbar_home.dart';
import 'package:wallets/features/home/ui/widgets/drawer_home.dart';
import 'package:wallets/features/home/ui/widgets/quick_action_card.dart';
import 'package:wallets/features/home/ui/widgets/transaction_item_card.dart';
import 'package:wallets/core/helper/utils/transaction_utils.dart';
import 'package:wallets/features/home/ui/widgets/wallet_summary_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      drawer: DrawerHome(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: const AppBarHome(),
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
          final walletsResponse = state.wallets;
          final transaction = state.transactions;
          final hasData = walletsResponse != null || transaction != null;

          if (state.isLoading && !hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && !hasData) {
            return Center(child: Text(state.errorMessage!));
          }

          if (walletsResponse == null && transaction == null) {
            return const SizedBox.shrink();
          }

          final total = walletsResponse?.data?.totalBalanceUSD ?? 0.0;
          final wallets =
              walletsResponse?.data?.wallets ?? const <WalletsModel>[];
          final List<TransactionItem> txs =
              transaction?.data?.transactions?.data ?? const [];
          final cards = wallets.map((wallet) {
            final currency = wallet.currency ?? '';
            final balance = wallet.balance ?? 0;
            return WalletBalanceCardData(
              currencyCode: currency,
              amountText: '$currency ${balance.toStringAsFixed(2)}',
              icon: Icons.wallet,
            );
          }).toList();

          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WalletSummarySection(
                  title: 'Total Balance',
                  totalAmountText: '\$ ${total.toStringAsFixed(2)}',
                  totalIcon: Icons.account_balance_wallet_outlined,
                  cards: cards,
                  onTapIcon: () async {
                    await context.pushNamed(Routes.walletsScreen);
                    context.read<HomeCubit>()
                      ..getWallets()
                      ..getAllTransactions();
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 24.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quick Actions', style: TextStyles.black16Bold),
                      SizedBox(height: 18),
                      QuickActionCard(
                        title: 'Top Up',
                        icon: Icons.arrow_circle_up_rounded,
                      ),
                      SizedBox(height: 16.h),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 2.4,
                        children: [
                          QuickActionCard(
                            title: 'Transfer',
                            icon: Icons.arrow_downward,
                            backgroundColor: Colors.white,
                            textStyle: TextStyles.black16Bold,
                            iconBackgroundColor: ColorsManager.orange.withAlpha(
                              100,
                            ),
                            iconColor: ColorsManager.orange,
                          ),
                          QuickActionCard(
                            title: 'Withdraw',
                            icon: Icons.credit_card,
                            backgroundColor: Colors.white,
                            textStyle: TextStyles.black16Bold,
                            iconBackgroundColor: ColorsManager.orange.withAlpha(
                              100,
                            ),
                            iconColor: ColorsManager.orange,
                          ),
                          QuickActionCard(
                            title: 'Exchange',
                            icon: Icons.sync,
                            backgroundColor: Colors.white,
                            textStyle: TextStyles.black16Bold,
                            iconBackgroundColor: ColorsManager.orange.withAlpha(
                              100,
                            ),
                            iconColor: ColorsManager.orange,
                          ),
                          QuickActionCard(
                            title: 'Bill Payment',
                            icon: Icons.attach_money,
                            backgroundColor: Colors.white,
                            textStyle: TextStyles.black16Bold,
                            iconBackgroundColor: ColorsManager.orange.withAlpha(
                              100,
                            ),
                            iconColor: ColorsManager.orange,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Recent Transactions',
                            style: TextStyles.black16Bold,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              context.pushNamed(
                                Routes.transactionHistoryScreen,
                              );
                            },
                            child: Text(
                              'View All',
                              style: TextStyles.orange16SemiBold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      if (txs.isEmpty)
                        Center(
                          child: Text(
                            'No transactions found',
                            style: TextStyles.gray14,
                          ),
                        )
                      else
                        ...txs.take(5).map((tx) {
                          final currency =
                              transaction?.data?.wallet?.currency ?? '';
                          final pres = mapTransactionToPresentation(
                            tx,
                            currency: currency,
                          );
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: TransactionItemCard(
                              title: pres.title,
                              subtitle: pres.subtitle,
                              dateTime: pres.dateText,
                              amountText: pres.amountText,
                              icon: pres.icon,
                              iconBackgroundColor: pres.iconBackgroundColor,
                              amountTextStyle: pres.amountTextStyle,
                              showStatusIcon: true,
                              statusIcon: pres.statusIcon,
                              statusIconColor: pres.statusIconColor,
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
