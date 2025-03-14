// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Post {
  final String userId;
  final String? id;
  final String body;
  final String? urlImage;
  final List<String> comments;
  final List<String> likes;

  Post({
    required this.userId,
    id,
    required this.body,
    this.urlImage,
    this.comments = const [],
    this.likes = const [],
  }) : id = id ?? const Uuid().v6();

  Post.empty({
    this.userId = '',
    id,
    this.body = '',
    this.urlImage,
    this.comments = const [],
    this.likes = const [],
  }) : id = id ?? const Uuid().v6();

  bool get isUrlImageValid => urlImage != null && urlImage!.isNotEmpty;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'body': body,
      'urlImage': urlImage,
      'comments': comments,
      'likes': likes,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userId: map['userId'] as String,
      id: map['id'] != null ? map['id'] as String : null,
      body: map['body'] as String,
      urlImage: map['urlImage'] != null ? map['urlImage'] as String : null,
      comments: List<String>.from(map['comments'] as List<String>),
      likes: List<String>.from(map['likes'] as List<String>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);

  Post copyWith({
    String? userId,
    String? id,
    String? body,
    String? urlImage,
    List<String>? comments,
    List<String>? likes,
  }) {
    return Post(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      body: body ?? this.body,
      urlImage: urlImage ?? this.urlImage,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
    );
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.id == id &&
      other.body == body &&
      other.urlImage == urlImage &&
      listEquals(other.comments, comments) &&
      listEquals(other.likes, likes);
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      id.hashCode ^
      body.hashCode ^
      urlImage.hashCode ^
      comments.hashCode ^
      likes.hashCode;
  }
}
