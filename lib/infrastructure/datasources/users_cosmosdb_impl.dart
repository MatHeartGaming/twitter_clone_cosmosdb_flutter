import 'package:azure_cosmosdb/azure_cosmosdb.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/config/constants/environment.dart';
import 'package:twitter_cosmos_db/domain/datasources/users_datasource.dart';
import 'package:twitter_cosmos_db/domain/models/user.dart';

class UsersCosmosdbImpl implements UsersDatasource {
  final _cosmosDB = CosmosDbServer(
    'https://matsub.documents.azure.com:443/',
    masterKey: Environment.comosDBMasterKey,
  );

  @override
  Future<User?> createNewUser(User user) async {
    // connect to the database, create it if necessary
    final database = await _cosmosDB.databases.open(
      'twitter_db',
    );

    return User.empty(dateCreated: DateTime.now());
  }

  @override
  Future<List<User>> getAllUsers() async {
    // connect to the database, create it if necessary
    final database = await _cosmosDB.databases.open(
      'twitter_db',
    );
    return [];
  }

  @override
  Future<List<User>?> getFollwedByUserUsingId(String username) async {
    // connect to the database, create it if necessary
    final database = await _cosmosDB.databases.open('twitter_db');
    return [];
  }

  @override
  Future<User?> getUserById(String username) async {
    // connect to the database, create it if necessary
    final database = await _cosmosDB.databases.open('twitter_db');
    final lists = await database.containers.list();
    logger.i('Containers: ${lists.toList()[1]}');
    return User.empty(dateCreated: DateTime.now());
  }

  @override
  Future<List<User>> searchUsersById(String username) async {
    // connect to the database, create it if necessary
    final database = await _cosmosDB.databases.open('twitter_db');
    final lists = await database.containers.list();
    logger.i('Containers: ${lists.first.id}');
    return [];
  }

  @override
  Future<User?> updateUser(User user) async {
    // connect to the database, create it if necessary
    final database = await _cosmosDB.databases.open('twitter_db');
    return User.empty(dateCreated: DateTime.now());
  }
}
