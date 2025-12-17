import 'package:wallets/features/home/data/models/wallets_model.dart';

abstract class HomeRepo {
  Future<Wallets> getWallets();
}
