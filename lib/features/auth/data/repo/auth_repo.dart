abstract class AuthRepo {
  Future<void> login({required String phone, required String password});
  Future<void> register({
    required String name,
    required String phone,
    required String password,
    required String email,
  });

  Future<void> otp({required String phone,required String code,required String purpose});
}
