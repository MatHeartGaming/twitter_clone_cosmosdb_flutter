// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:twitter_cosmos_db/domain/models/user.dart';
import 'package:twitter_cosmos_db/domain/repositories/users_repository.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';

final loadUsersProvider =
    StateNotifierProvider<LoadUsersNotifier, LoadUsersState>((ref) {
      final usersRepo = ref.watch(usersRepositoryProvider);
      return LoadUsersNotifier(usersRepo);
    });

class LoadUsersNotifier extends StateNotifier<LoadUsersState> {
  final UsersRepository _usersRepository;

  LoadUsersNotifier(UsersRepository usersRepository)
    : _usersRepository = usersRepository,
      super(LoadUsersState(allUsers: []));

  Future<List<User>> fetchAllUsers() async {
    if (state.isLoading) return state.allUsers;
    _startLoading();
    final allUsers = await _usersRepository.getAllUsers();
    state = state.copyWith(isLoading: false, allUsers: allUsers);
    return state.allUsers;
  }

  Future<User?> fetchUsersById(String username) async {
    final user = await _usersRepository.getUserById(username);
    return user;
  }

  Future<List<User>?> fetchFollowedUsersById(String username) async {
    final users = await _usersRepository.getFollwedByUserUsingId(username);
    return users;
  }

  Future<User?> updateUser(User user) async {
    return await _usersRepository.updateUser(user);
  }

  void _startLoading() {
    state = state.copyWith(isLoading: true);
  }
}

class LoadUsersState {
  final bool isLoading;
  final List<User> allUsers;

  LoadUsersState({this.isLoading = false, required this.allUsers});

  @override
  bool operator ==(covariant LoadUsersState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading && listEquals(other.allUsers, allUsers);
  }

  @override
  int get hashCode => isLoading.hashCode ^ allUsers.hashCode;

  LoadUsersState copyWith({bool? isLoading, List<User>? allUsers}) {
    return LoadUsersState(
      isLoading: isLoading ?? this.isLoading,
      allUsers: allUsers ?? this.allUsers,
    );
  }
}
