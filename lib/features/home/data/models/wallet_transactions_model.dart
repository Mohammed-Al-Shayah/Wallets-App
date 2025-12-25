import 'package:wallets/features/home/data/models/wallets_model.dart';

class WalletTransactions {
  final bool? status;
  final String? message;
  final String? code;
  final WalletTransactionsData? data;

  const WalletTransactions({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory WalletTransactions.fromJson(Map<String, dynamic> json) {
    return WalletTransactions(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      code: json['code'] as String?,
      data: json['data'] != null
          ? WalletTransactionsData.fromJson(
              json['data'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class WalletTransactionsData {
  final WalletsModel? wallet;
  final TransactionsPage? transactions;

  const WalletTransactionsData({
    this.wallet,
    this.transactions,
  });

  factory WalletTransactionsData.fromJson(Map<String, dynamic> json) {
    return WalletTransactionsData(
      wallet: json['wallet'] != null
          ? WalletsModel.fromJson(json['wallet'] as Map<String, dynamic>)
          : null,
      transactions: json['transactions'] != null
          ? TransactionsPage.fromJson(
              json['transactions'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class TransactionsPage {
  final int? currentPage;
  final List<TransactionItem> data;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final int? lastPage;
  final int? total;

  const TransactionsPage({
    this.currentPage,
    required this.data,
    this.nextPageUrl,
    this.prevPageUrl,
    this.lastPage,
    this.total,
  });

  factory TransactionsPage.fromJson(Map<String, dynamic> json) {
    final list = (json['data'] as List? ?? [])
        .map((e) => TransactionItem.fromJson(e as Map<String, dynamic>))
        .toList();
    return TransactionsPage(
      currentPage: json['current_page'] as int?,
      data: list,
      nextPageUrl: json['next_page_url'] as String?,
      prevPageUrl: json['prev_page_url'] as String?,
      lastPage: json['last_page'] as int?,
      total: json['total'] as int?,
    );
  }
}

class TransactionItem {
  final int? id;
  final int? userId;
  final int? walletId;
  final String? type;
  final double? amount;
  final double? fee;
  final double? totalAmount;
  final double? balanceBefore;
  final double? balanceAfter;
  final String? status;
  final String? description;
  final String? reference;
  final Map<String, dynamic>? meta;
  final String? createdAt;
  final String? updatedAt;

  const TransactionItem({
    this.id,
    this.userId,
    this.walletId,
    this.type,
    this.amount,
    this.fee,
    this.totalAmount,
    this.balanceBefore,
    this.balanceAfter,
    this.status,
    this.description,
    this.reference,
    this.meta,
    this.createdAt,
    this.updatedAt,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    double? toDoubleValue(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v);
      return null;
    }

    return TransactionItem(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      walletId: json['wallet_id'] as int?,
      type: json['type'] as String?,
      amount: toDoubleValue(json['amount']),
      fee: toDoubleValue(json['fee']),
      totalAmount: toDoubleValue(json['total_amount']),
      balanceBefore: toDoubleValue(json['balance_before']),
      balanceAfter: toDoubleValue(json['balance_after']),
      status: json['status'] as String?,
      description: json['description'] as String?,
      reference: json['reference']?.toString(),
      meta: (json['meta'] as Map?)?.map(
        (key, value) => MapEntry(key.toString(), value),
      ),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
