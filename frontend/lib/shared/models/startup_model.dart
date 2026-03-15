import 'package:flutter/foundation.dart';

@immutable
class StartupModel {
  final String id;
  final String ownerId;
  final String name;
  final String? description;
  final String? locationState;
  final String? websiteUrl;
  final String? logoUrl;
  final DateTime? foundedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const StartupModel({
    required this.id,
    required this.ownerId,
    required this.name,
    this.description,
    this.locationState,
    this.websiteUrl,
    this.logoUrl,
    this.foundedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory StartupModel.fromJson(Map<String, dynamic> json) {
    return StartupModel(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      locationState: json['location_state'] as String?,
      websiteUrl: json['website_url'] as String?,
      logoUrl: json['logo_url'] as String?,
      foundedAt: json['founded_at'] != null 
          ? DateTime.parse(json['founded_at'] as String)
          : null,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'name': name,
      'description': description,
      'location_state': locationState,
      'website_url': websiteUrl,
      'logo_url': logoUrl,
      'founded_at': foundedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
