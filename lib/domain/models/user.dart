// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:azure_cosmosdb/azure_cosmosdb.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class User extends BaseDocumentWithEtag {
  @override
  final String id;

  final String nome;
  final String cognome;
  final String username;
  final String email;
  final DateTime dateCreated;
  final String phoneNumber;
  final String profileImageUrl;
  final List<String> followed;
  final List<String> postLiked;
  final List<String> posted;

  User({
    id,
    required this.nome,
    required this.cognome,
    required this.username,
    required this.dateCreated,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.email,
    this.followed = const [],
    this.postLiked = const [],
    this.posted = const [],
  }) : id = const Uuid().v6();

  User.empty({
    id,
    this.nome = '',
    this.cognome = '',
    this.username = '',
    required this.dateCreated,
    this.phoneNumber = '',
    this.email = '',
    this.profileImageUrl = '',
    this.followed = const [],
    this.postLiked = const [],
    this.posted = const [],
  }) : id = const Uuid().v6();

  String get completeName => '$nome $cognome';

  bool get isProfileUrlValid => profileImageUrl.isNotEmpty;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'cognome': cognome,
      'username': username,
      'email': email,
      'dateCreated': dateCreated,
      'phoneNumber': phoneNumber,
      'followed': followed,
      'postLiked': postLiked,
      'posted': posted,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      nome: map['nome'] as String,
      cognome: map['cognome'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      dateCreated:
          DateTime.tryParse(map['dateCreated'] ?? '')?.toLocal() ??
          DateTime.now().toLocal(),
      phoneNumber: map['phoneNumber'] as String,
      profileImageUrl: map['profileImageUrl'],
      followed:
          map.containsKey('followed')
              ? (map['followed'] as List).map((e) => e.toString()).toList()
              : [],
      postLiked:
          map.containsKey('postLiked')
              ? (map['postLiked'] as List).map((e) => e.toString()).toList()
              : [],
      posted:
          map.containsKey('posted')
              ? (map['posted'] as List).map((e) => e.toString()).toList()
              : [],
    );
  }

  String toJsonMap() => json.encode(toMap());

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'cognome': cognome,
    'username': username,
    'email': email,
    'dateCreated': dateCreated.toUtc().toIso8601String(),
    'phoneNumber': phoneNumber,
    'followed': followed,
    'postLiked': postLiked,
    'posted': posted,
    'profileImageUrl': profileImageUrl,
  };

  static User fromJson(Map map) {
    final user = User(
      id: map['id'] as String,
      nome: map['nome'] as String,
      cognome: map['cognome'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      dateCreated:
          DateTime.tryParse(map['dateCreated'] ?? '')?.toLocal() ??
          DateTime.now().toLocal(),
      phoneNumber: map['phoneNumber'] as String,
      profileImageUrl: map['profileImageUrl'],
      followed:
          map.containsKey('followed')
              ? (map['followed'] as List).map((e) => e.toString()).toList()
              : [],
      postLiked:
          map.containsKey('postLiked')
              ? (map['postLiked'] as List).map((e) => e.toString()).toList()
              : [],
      posted:
          map.containsKey('posted')
              ? (map['posted'] as List).map((e) => e.toString()).toList()
              : [],
    );
    user.setEtag(map);
    return user;
  }

  factory User.fromJsonString(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? nome,
    String? cognome,
    String? username,
    String? email,
    DateTime? dateCreated,
    String? phoneNumber,
    String? profileImageUrl,
    List<String>? followed,
    List<String>? postLiked,
    List<String>? posted,
  }) {
    return User(
      nome: nome ?? this.nome,
      cognome: cognome ?? this.cognome,
      username: username ?? this.username,
      email: email ?? this.email,
      dateCreated: dateCreated ?? this.dateCreated,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      followed: followed ?? this.followed,
      postLiked: postLiked ?? this.postLiked,
      posted: posted ?? this.posted,
    );
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.nome == nome &&
        other.cognome == cognome &&
        other.username == username &&
        other.email == email &&
        other.dateCreated == dateCreated &&
        other.phoneNumber == phoneNumber &&
        other.profileImageUrl == profileImageUrl &&
        listEquals(other.followed, followed) &&
        listEquals(other.postLiked, postLiked) &&
        listEquals(other.posted, posted);
  }

  @override
  int get hashCode {
    return nome.hashCode ^
        cognome.hashCode ^
        username.hashCode ^
        email.hashCode ^
        dateCreated.hashCode ^
        phoneNumber.hashCode ^
        profileImageUrl.hashCode ^
        followed.hashCode ^
        postLiked.hashCode ^
        posted.hashCode;
  }
}
