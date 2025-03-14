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
    final database = await _cosmosDB.databases.open('twitter_db');

    final usersCollection = await database.containers.openOrCreate(
      'Users',
      partitionKey: PartitionKeySpec.id,
      //indexingPolicy: indexingPolicy,
    );

    usersCollection.registerBuilder(User.fromJson);

    final userToInsert = await usersCollection.add(user);

    logger.i('Users prova: $usersCollection');

    return userToInsert;
  }

  @override
  Future<List<User>> getAllUsers() async {
    // connect to the database, create it if necessary
    final database = await _cosmosDB.databases.openOrCreate('twitter_db');

    // open or create a container with a specific indexing policy
    /*final indexingPolicy =
        IndexingPolicy(indexingMode: IndexingMode.consistent)
          ..excludedPaths.add(IndexPath('/*'))
          //..includedPaths.add(IndexPath('/"due-date"/?'))
          ..compositeIndexes.add([
            IndexPath('/email', order: IndexOrder.ascending),
            IndexPath('/"username"', order: IndexOrder.descending),
          ]);*/*/

    final usersCollection = await database.containers.openOrCreate(
      'Users',
      partitionKey: PartitionKeySpec.id,
      //indexingPolicy: indexingPolicy,
    );

    usersCollection.registerBuilder(User.fromJson);

    final allUsers = await usersCollection.query<User>(
      Query(
        'SELECT * FROM c',
      ),
    );

    return allUsers.toList();
  }

  @override
  Future<List<User>?> getFollwedByUserUsingId(String username) async {
    final database = await _cosmosDB.databases.open('twitter_db');

    final usersCollection = await database.containers.openOrCreate(
      'Users',
      partitionKey: PartitionKeySpec.id,
    );

    usersCollection.registerBuilder(User.fromJson);

    final usersFollowing = await usersCollection.query<User>(
      Query(
        'SELECT * FROM c WHERE c.username = @username',
        params: {'@username': username},
      ),
    );

    return usersFollowing.toList();
  }

  @override
  Future<User?> getUserById(String username) async {
    // connect to the database, create it if necessary
    final database = await _cosmosDB.databases.open('twitter_db');

    final usersCollection = await database.containers.openOrCreate(
      'Users',
      partitionKey: PartitionKeySpec.id,
    );

    usersCollection.registerBuilder(User.fromJson);

    final userByUsername = await usersCollection.query<User>(
      Query(
        'SELECT * FROM c WHERE c.username = @username',
        params: {'@username': username},
      ),
    );

    if (userByUsername.isEmpty) return null;

    return userByUsername.first;
  }

  @override
  Future<List<User>> searchUsersById(String username) async {
    if (username.isEmpty) return [];

    final database = await _cosmosDB.databases.open('twitter_db');

    final usersCollection = await database.containers.openOrCreate(
      'Users',
      partitionKey: PartitionKeySpec.id,
    );

    usersCollection.registerBuilder(User.fromJson);

    final userByUsername = await usersCollection.query<User>(
      Query(
        'SELECT * FROM c WHERE CONTAINS(LOWER(c.username), LOWER(@username)) OR CONTAINS(LOWER(c.nome), LOWER(@username)) OR CONTAINS(LOWER(c.cognome), LOWER(@username))',
        params: {'@username': username},
      ),
    );

    return userByUsername.toList();
  }

  @override
  Future<User?> updateUser(User user) async {
    final database = await _cosmosDB.databases.open('twitter_db');

    final usersCollection = await database.containers.openOrCreate(
      'Users',
      partitionKey: PartitionKeySpec.id,
      //indexingPolicy: indexingPolicy,
    );

    usersCollection.registerBuilder(User.fromJson);

    final userToUpdate = await usersCollection.upsert(user);

    logger.i('User to update: $userToUpdate');

    return userToUpdate;
  }
}
