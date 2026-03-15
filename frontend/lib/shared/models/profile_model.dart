import 'package:flutter/foundation.dart';

@immutable
class ProfileModel {
  final String id;
  final String? fullName;
  final int xp;
  final int level;
  final String? avatarUrl;
  final DateTime? updatedAt;

  const ProfileModel({
    required this.id,
    this.fullName,
    this.xp = 0,
    this.level = 1,
    this.avatarUrl,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String?,
      xp: json['xp'] as int? ?? 0,
      level: json['level'] as int? ?? 1,
      avatarUrl: json['avatar_url'] as String?,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'xp': xp,
      'level': level,
      'avatar_url': avatarUrl,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
