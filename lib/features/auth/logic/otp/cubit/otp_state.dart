import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final bool isLoading;
  final String? erorrMesseage;
  final bool isSuccess;

  const OtpState({
    this.isLoading = false,
    this.erorrMesseage,
    this.isSuccess = false,
  });

  OtpState copyWith({bool? isLoading, String? erorrMesseage, bool? isSuccess}) {
    return OtpState(
      erorrMesseage: erorrMesseage ?? this.erorrMesseage,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, erorrMesseage, isSuccess];
}
