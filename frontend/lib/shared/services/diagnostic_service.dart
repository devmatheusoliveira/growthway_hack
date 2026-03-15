import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:frontend/shared/models/diagnostic_model.dart';

class DiagnosticService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<DiagnosticNode?> getRootNode() async {
    final response = await _client
        .from('diagnostic_nodes')
        .select()
        .eq('is_root', true)
        .maybeSingle();

    if (response == null) return null;
    return DiagnosticNode.fromJson(response);
  }

  Future<List<DiagnosticEdge>> getEdgesForNode(String nodeId) async {
    final response = await _client
        .from('diagnostic_edges')
        .select('*, to_node:diagnostic_nodes!to_node_id(type)')
        .eq('from_node_id', nodeId)
        .order('order_index');

    return (response as List).map((e) => DiagnosticEdge.fromJson(e)).toList();
  }

  Future<DiagnosticNode?> getNodeById(String nodeId) async {
    final response = await _client
        .from('diagnostic_nodes')
        .select()
        .eq('id', nodeId)
        .maybeSingle();

    if (response == null) return null;
    return DiagnosticNode.fromJson(response);
  }

  Future<void> saveResponse({
    required String nodeId,
    required String edgeId,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return;

    await _client.from('user_diagnostic_responses').insert({
      'user_id': userId,
      'node_id': nodeId,
      'edge_id': edgeId,
    });
  }
}
