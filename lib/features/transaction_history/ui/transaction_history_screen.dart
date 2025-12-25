import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/helper/utils/transaction_utils.dart';
import 'package:wallets/core/theming/colors.dart';
import 'package:wallets/core/theming/styles.dart';
import 'package:wallets/features/home/data/models/wallet_transactions_model.dart';
import 'package:wallets/features/home/logic/cubit/home_cubit.dart';
import 'package:wallets/features/home/logic/cubit/home_state.dart';
import 'package:wallets/features/home/ui/widgets/transaction_item_card.dart';
import 'package:wallets/features/transaction_history/ui/widgets/transaction_search_filterbar.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History', style: TextStyles.blue16bold),
        backgroundColor: Colors.white,
      ),
      backgroundColor: ColorsManager.primaryColor,
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          final transaction = state.transactions;
          final hasData = transaction != null;

          if (state.isLoading && !hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && !hasData) {
            return Center(child: Text(state.errorMessage!));
          }

          if (transaction == null) {
            return const SizedBox.shrink();
          }

          final List<TransactionItem> es =
              transaction.data?.transactions?.data ?? const [];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TransactionSearchFilterBar(
                  searchController: _searchController,
                  onSearchChanged: (q) {
                    // TODO: filter list / call cubit
                  },
                  onFiltersTap: () {
                    // TODO: open filters sheet
                  },
                  onDateRangeTap: () {
                    // TODO: open date range picker
                  },
                ),
                SizedBox(height: 21.h),
                Text('All Transactions', style: TextStyles.black16Medium),
                SizedBox(height: 16.h),
                Expanded(
                  child: es.isEmpty
                      ? Center(
                          child: Text(
                            'No transactions found',
                            style: TextStyles.gray14,
                          ),
                        )
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: es.length,
                          separatorBuilder: (_, __) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final e = es[index];
                            final currency =
                                transaction.data?.wallet?.currency ?? '';
                            final pres = mapTransactionToPresentation(
                              e,
                              currency: currency,
                            );

                            return TransactionItemCard(
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
                            );
                          },
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
