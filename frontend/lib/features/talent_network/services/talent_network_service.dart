import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:frontend/features/talent_network/models/talent_profile_model.dart';

class TalentNetworkService {
  final _supabase = Supabase.instance.client;

  Future<List<TalentProfileModel>> getTalents() async {
    final response = await _supabase
        .from('talent_profiles')
        .select('*, talent_skills(skill, order_index)')
        .eq('is_active', true)
        .order('name', ascending: true);

    return (response as List<dynamic>)
        .map((json) => TalentProfileModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> sendConnectionRequest({
    required String talentProfileId,
    String? message,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    await _supabase.from('talent_connection_requests').upsert({
      'requester_id': userId,
      'talent_profile_id': talentProfileId,
      'message': message,
      'status': 'pending',
    });
  }
}
