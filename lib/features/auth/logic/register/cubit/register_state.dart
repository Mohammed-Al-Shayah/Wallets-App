import 'package:equatable/equatable.dart';

 class RegisterState extends Equatable {
  final bool isLoading;
  final String? erorrMesseage;
  final bool isSuccess;

  const RegisterState({
    this.isLoading = false,
    this.erorrMesseage,
    this.isSuccess = false,
  });

  RegisterState copyWith({
    bool? isLoading,
    String? erorrMesseage,
    bool? isSuccess,
  }) {
    return RegisterState(
      erorrMesseage: erorrMesseage ?? this.erorrMesseage,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, erorrMesseage, isSuccess];
}
