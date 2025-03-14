// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
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
  });

  User.empty({
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
  });

  String get completeName => '$nome $cognome';

  bool get isProfileUrlValid => profileImageUrl.isNotEmpty;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
      nome: map['nome'] as String,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
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
  
    return 
      other.nome == nome &&
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
