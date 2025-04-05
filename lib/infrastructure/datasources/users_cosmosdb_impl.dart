import 'package:azure_cosmosdb/azure_cosmosdb.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/config/constants/environment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:twitter_cosmos_db/domain/datasources/users_datasource.dart';
import 'package:twitter_cosmos_db/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersCosmosdbImpl implements UsersDatasource {
  final _cosmosDB = CosmosDbServer(
    'https://matsub.documents.azure.com:443/',
    masterKey: Environment.comosDBMasterKey,
  );
  final String baseUrl =
      'https://new-twitter-clone-function.azurewebsites.net/api';

  @override
  Future<String?> login(String email, String password) async {
    logger.i('Email: $email');
    final url = Uri.parse('$baseUrl/loginfunction');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      logger.i('Login Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        logger.i('Login Success Response: $decoded');

        // Save token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', decoded['token']);

        return decoded['token'];
      } else {
        logger.e('Login Error: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      logger.e('Login Exception: $e');
      return null;
    }
  }

  @override
  Future<User?> createNewUser(User user) async {
    logger.i('Creating new user: ${user.toJson()}');
    final url = Uri.parse('$baseUrl/signupfunction');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': user.email,
        'password': user.password,
        'nome': user.nome,
        'cognome': user.cognome,
        'username': user.username,
        'profileImageUrl': user.profileImageUrl,
      }),
    );
    logger.i('Response after: ${response.statusCode} ${response.body}');
    if (response.statusCode == 201) {
      final newUser = json.decode(response.body);
      logger.i(newUser);
      return user;
    } else {
      logger.e('Error: ${response.statusCode}');
      return null;
    }
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
  Future<User?> getUserByEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) {
      logger.i('No token found. User might not be logged in.');
      return null;
    }

    final url = Uri.parse('$baseUrl/GetUserByEmail?email=$email');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Add the token here
        },
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty &&
            response.body != "null" &&
            response.body != "1") {
          return User.fromJson(json.decode(response.body));
        } else {
          // No user found
          return null;
        }
      } else {
        logger.e('Error: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      logger.e('Exception during getUserByEmail: $e');
      return null;
    }
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
