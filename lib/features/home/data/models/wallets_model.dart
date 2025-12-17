class Wallets {
  final bool? status;
  final String? message;
  final String? code;
  final Data? data;

  const Wallets({this.status, this.message, this.code, this.data});

  factory Wallets.fromJson(Map<String, dynamic> json) {
    return Wallets(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  final List<WalletsModel> wallets;
  final int? defaultWalletId;
  final double? totalBalanceUSD;
  final double? monthlyTransfersUsd;

  const Data({
    required this.wallets,
    this.defaultWalletId,
    this.totalBalanceUSD,
    this.monthlyTransfersUsd,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      wallets: (json['wallets'] as List? ?? [])
          .map((e) => WalletsModel.fromJson(e))
          .toList(),
      defaultWalletId: json['default_wallet_id'],
      totalBalanceUSD: (json['total_balance_usd'] as num?)?.toDouble(),
      monthlyTransfersUsd: (json['monthly_transfers_usd'] as num?)?.toDouble(),
    );
  }
}

class WalletsModel {
  final int? id;
  final int? userId;
  final String? type;
  final String? currency;
  final double? balance;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  // ✅ new fields
  final String? currencyName;
  final dynamic lastIncomingTransfer;

  const WalletsModel({
    this.id,
    this.userId,
    this.type,
    this.currency,
    this.balance,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.currencyName,
    this.lastIncomingTransfer,
  });

  factory WalletsModel.fromJson(Map<String, dynamic> json) {
    return WalletsModel(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      currency: json['currency'],
      balance: (json['balance'] as num?)?.toDouble(),
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      currencyName: json['currency_name'],
      lastIncomingTransfer: json['last_incoming_transfer'],
    );
  }
}
