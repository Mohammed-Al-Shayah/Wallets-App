import 'package:equatable/equatable.dart';
import 'package:wallets/features/home/data/models/wallets_model.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final Wallets? wallets;

  const HomeState({
    this.isLoading = false,
    this.errorMessage,
    this.wallets,
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    Wallets? wallets,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      wallets: wallets ?? this.wallets,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, wallets];
}
