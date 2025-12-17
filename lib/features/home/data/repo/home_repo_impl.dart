import 'package:wallets/core/networking/api_constants.dart';
import 'package:wallets/core/networking/api_service.dart';
import 'package:wallets/features/home/data/models/wallets_model.dart';
import 'package:wallets/features/home/data/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final ApiService _apiService;
  HomeRepoImpl(this._apiService);

  @override
  Future<Wallets> getWallets() async {
    final repo = await _apiService.get(
      '${ApiConstants.baseApiUrl}/api/v1/wallets',
    );
    return Wallets.fromJson(repo);
  }
}
