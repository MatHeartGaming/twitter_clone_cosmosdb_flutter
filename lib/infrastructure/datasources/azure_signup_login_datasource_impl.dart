import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/config/constants/environment.dart';
import 'package:twitter_cosmos_db/domain/datasources/signup_login_datasource.dart';

class AzureSignupLoginDatasourceImpl implements SignupLoginDatasource {
  final FlutterAppAuth _appAuth = FlutterAppAuth();

  @override
  Future<bool> login() async {
    try {
      final AuthorizationTokenResponse
      result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          Environment.azureClientId,
          'twitterCosmosDB://auth',
          discoveryUrl: 'https://login.microsoftonline.com/${Environment.azureTenantId}/v2.0/.well-known/openid-configuration',
          scopes: ['openid', 'profile'],
        ),
      );

      logger.i('Azure Auth: $result');
    } catch (e) {
      logger.e(e.toString());
    }

    return false;
  }

  @override
  Future<bool> signup() async {
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() async {
    try {
      final result = await _appAuth.endSession(
        EndSessionRequest(
          discoveryUrl:
              'https://login.microsoftonline.com/${Environment.azureTenantId}/v2.0/.well-known/openid-configuration',
        ),
      );
      logger.i('Azure Auth: $result');
    } catch (e) {
      logger.e(e.toString());
    }
    return true;
  }
}
