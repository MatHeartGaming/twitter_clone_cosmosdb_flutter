// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/domain/repositories/repositories.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';

final searchSreenSearchBarProvider = StateNotifierProvider.autoDispose<
  UsersSearchScreenSearchBarNotifier,
  UsersSearchScreenSearchBarState
>((ref) {
  final usersRepository = ref.watch(usersRepositoryProvider);
  final searchNotifier = UsersSearchScreenSearchBarNotifier(usersRepository);
  return searchNotifier;
});

class UsersSearchScreenSearchBarNotifier
    extends StateNotifier<UsersSearchScreenSearchBarState> {
  final UsersRepository _usersRepository;

  UsersSearchScreenSearchBarNotifier(UsersRepository userRepo)
    : _usersRepository = userRepo,
      super(
        UsersSearchScreenSearchBarState(
          searchText: '',
          searchedUsers: [],
          searchTextController: TextEditingController(),
        ),
      );

  @override
  void dispose() {
    state.searchTextController?.dispose();
    super.dispose();
  }

  void initSearch({required List<User> users}) {
    state = state.copyWith(searchedUsers: users);
  }

  Future<List<User>> searchProductsBy() async {
    final searchText = state.searchText.toLowerCase().trim();
    List<User> users = await _usersRepository.searchUsersById(searchText);
    state = state.copyWith(searchedUsers: users);
    return users;
  }

  void onSearchTextChange(String value) {
    state = state.copyWith(searchText: value);
  }

  void clearSearchText() {
    state.searchTextController?.clear();
    state = state.copyWith(
      searchText: '',
      searchTextController: state.searchTextController,
    );
  }
}

class UsersSearchScreenSearchBarState {
  final String searchText;
  final TextEditingController? searchTextController;
  final List<User> searchedUsers;

  UsersSearchScreenSearchBarState({
    required this.searchText,
    required this.searchedUsers,
    this.searchTextController,
  });

  @override
  bool operator ==(covariant UsersSearchScreenSearchBarState other) {
    if (identical(this, other)) return true;

    return other.searchText == searchText &&
        other.searchTextController == searchTextController &&
        listEquals(other.searchedUsers, searchedUsers);
  }

  @override
  int get hashCode =>
      searchText.hashCode ^
      searchTextController.hashCode ^
      searchedUsers.hashCode;

  UsersSearchScreenSearchBarState copyWith({
    String? searchText,
    TextEditingController? searchTextController,
    List<User>? searchedUsers,
  }) {
    return UsersSearchScreenSearchBarState(
      searchText: searchText ?? this.searchText,
      searchTextController: searchTextController ?? this.searchTextController,
      searchedUsers: searchedUsers ?? this.searchedUsers,
    );
  }
}
