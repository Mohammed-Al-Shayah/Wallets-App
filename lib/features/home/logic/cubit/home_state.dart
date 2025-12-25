import 'package:equatable/equatable.dart';
import 'package:wallets/features/home/data/models/wallet_transactions_model.dart';
import 'package:wallets/features/home/data/models/wallets_model.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final Wallets? wallets;
  final WalletTransactions? transactions;

  const HomeState({
    this.isLoading = false,
    this.errorMessage,
    this.wallets,
    this.transactions,
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    Wallets? wallets,
    WalletTransactions? transactions,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      wallets: wallets ?? this.wallets,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, wallets, transactions];
}
