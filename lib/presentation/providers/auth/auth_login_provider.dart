import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/domain/repositories/signup_login_repository.dart';
import 'package:twitter_cosmos_db/infrastructure/repositories/azure_signup_login_repository_impl.dart';

final loginSignupProvider = Provider<SignupLoginRepository>((ref) {
  return AzureSignupLoginRepositoryImpl();
});