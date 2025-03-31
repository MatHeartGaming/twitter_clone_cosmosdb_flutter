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
  final String password; // Added password field

  User({
    id,
    required this.nome,
    required this.cognome,
    required this.username,
    required this.dateCreated,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.email,
    required this.password, // Initialize password
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
    this.password = '', // Initialize password with an empty string
    this.followed = const [],
    this.postLiked = const [],
    this.posted = const [],
  }) : id = const Uuid().v6();

  String get completeName => '$nome $cognome';

  bool get isProfileUrlValid => profileImageUrl.isNotEmpty;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': nome,
      'cognome': cognome,
      'username': username,
      'email': email,
      'dateCreated': dateCreated,
      'phoneNumber': phoneNumber,
      'followed': followed,
      'postLiked': postLiked,
      'posted': posted,
      'profileImageUrl': profileImageUrl,
      'password': password, // Include password in toMap
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      nome: map['name'] as String,
      cognome: map['cognome'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      dateCreated: DateTime.fromMillisecondsSinceEpoch(
        map['dateCreated'] as int,
      ),
      phoneNumber: map['phoneNumber'] as String,
      profileImageUrl: map['profileImageUrl'],
      followed: List<String>.from(map['followed'] as List<String>),
      postLiked: List<String>.from(map['postLiked'] as List<String>),
      posted: List<String>.from(map['posted'] as List<String>),
      password: map['password'] as String, // Extract password from map
    );
  }

  @override
  Map<String, dynamic> toJson() => toMap();

  // ...existing code...

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      nome: json['name'] as String? ?? '', // or just `as String?` if nullable
      cognome: json['cognome'] as String? ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      dateCreated:
          DateTime.tryParse(json['dateCreated'] ?? '') ?? DateTime.now(),
      phoneNumber: json['phoneNumber'] as String? ??
          '', // Provide a default empty string if null
      profileImageUrl: json['profileImageUrl'] as String? ??
          '', // Provide a default empty string if null
      password: json['password'] ?? '',
      followed: List<String>.from(json['followed'] ?? []),
      postLiked: List<String>.from(json['postLiked'] ?? []),
      posted: List<String>.from(json['posted'] ?? []),
    );
  }
  // ...existing code...

  User copyWith({
    String? nome,
    String? cognome,
    String? username,
    String? email,
    DateTime? dateCreated,
    String? phoneNumber,
    String? profileImageUrl,
    String? password, // Add password field in copyWith
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
      password: password ?? this.password, // Ensure password is copied as well
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

    return other.nome == nome &&
        other.cognome == cognome &&
        other.username == username &&
        other.email == email &&
        other.dateCreated == dateCreated &&
        other.phoneNumber == phoneNumber &&
        other.profileImageUrl == profileImageUrl &&
        other.password == password && // Compare password for equality
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
    cognome.hashCode ^
        username.hashCode ^
        email.hashCode ^
        dateCreated.hashCode ^
        phoneNumber.hashCode ^
        profileImageUrl.hashCode ^
        password.hashCode ^ // Include password in hashCode
        followed.hashCode ^
        postLiked.hashCode ^
        posted.hashCode;
  }
}
