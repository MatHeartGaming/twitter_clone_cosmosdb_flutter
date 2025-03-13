import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String comosDBMasterKey =
      dotenv.env['COSMOS_DB_MASTER_KEY'] ??
          "No CosmosDB Master Key found";
}
