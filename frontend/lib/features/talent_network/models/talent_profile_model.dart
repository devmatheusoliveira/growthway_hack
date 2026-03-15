class TalentProfileModel {
  final String id;
  final String name;
  final String role;
  final String bio;
  final List<String> skills;
  final String? linkedinUrl;
  final int completedProjects;
  final double rating;
  final String avatarInitials;

  const TalentProfileModel({
    required this.id,
    required this.name,
    required this.role,
    required this.bio,
    required this.skills,
    this.linkedinUrl,
    required this.completedProjects,
    required this.rating,
    required this.avatarInitials,
  });

  factory TalentProfileModel.fromJson(Map<String, dynamic> json) {
    final rawSkills = json['talent_skills'] as List<dynamic>? ?? [];
    final skills = rawSkills
        .map((s) => s['skill'] as String)
        .toList();

    return TalentProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      bio: json['bio'] as String? ?? '',
      skills: skills,
      linkedinUrl: json['linkedin_url'] as String?,
      completedProjects: json['completed_projects'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      avatarInitials: json['avatar_initials'] as String,
    );
  }
}
