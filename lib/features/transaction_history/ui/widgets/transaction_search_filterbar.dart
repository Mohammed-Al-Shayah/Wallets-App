
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/features/transaction_history/ui/widgets/action_chip_button.dart';
import 'package:wallets/features/transaction_history/ui/widgets/search_field.dart';

class TransactionSearchFilterBar extends StatelessWidget {
  const TransactionSearchFilterBar({
    super.key,
    required this.searchController,
    this.onSearchChanged,
    this.onFiltersTap,
    this.onDateRangeTap,
    this.searchHint = 'Search transactions...',
    this.filtersLabel = 'Filters',
    this.dateRangeLabel = 'Date Range',
    this.padding,
  });

  final TextEditingController searchController;
  final ValueChanged<String>? onSearchChanged;

  final VoidCallback? onFiltersTap;
  final VoidCallback? onDateRangeTap;

  final String searchHint;
  final String filtersLabel;
  final String dateRangeLabel;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchField(
            controller: searchController,
            hintText: searchHint,
            onChanged: onSearchChanged,
          ),
           SizedBox(height: 12.h),
          Row(
            children: [
              ActionChipButton(
                icon: Icons.filter_list,
                label: filtersLabel,
                onTap: onFiltersTap,
              ),
               SizedBox(width: 10.w),
              ActionChipButton(
                icon: Icons.calendar_month,
                label: dateRangeLabel,
                onTap: onDateRangeTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
