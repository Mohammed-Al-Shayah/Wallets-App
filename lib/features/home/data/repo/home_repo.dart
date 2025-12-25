import 'package:wallets/features/home/data/models/wallets_model.dart';
import 'package:wallets/features/home/data/models/wallet_transactions_model.dart';

abstract class HomeRepo {
  Future<Wallets> getWallets();
  Future<Wallets> createWallets({
    required String type,
    required String currency,
  });

  Future<WalletTransactions> getAllTransactions();

}
