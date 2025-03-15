import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String comosDBMasterKey =
      dotenv.env['COSMOS_DB_MASTER_KEY'] ?? "No CosmosDB Master Key found";
  static final String azureClientId =
      dotenv.env['AZURE_AUTH_CLIENT_ID'] ?? "No Azure Auth Client ID found";
  static final String azureTenantId =
      dotenv.env['AZURE_AUTH_TENANT_ID'] ?? "No Azure Auth Tenant ID found";
}
