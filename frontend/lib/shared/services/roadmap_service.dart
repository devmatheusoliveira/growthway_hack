import 'package:frontend/shared/models/roadmap_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoadmapService {
  final _supabase = Supabase.instance.client;

  Future<List<RoadmapStage>> getRoadmap() async {
    final userId = _supabase.auth.currentUser?.id;

    final stagesResponse = await _supabase
        .from('roadmap_stages')
        .select('*, roadmap_tasks(*)')
        .order('order_index', ascending: true);

    // Busca as respostas do diagnóstico do usuário
    final List<dynamic> responsesResponse = userId != null
        ? await _supabase
              .from('user_diagnostic_responses')
              .select(
                'node_id, diagnostic_nodes(content), diagnostic_edges(label)',
              )
              .eq('user_id', userId)
        : [];

    final Map<String, Map<String, String>> responsesMap = {};
    for (var r in responsesResponse) {
      final nodeId = r['node_id'] as String;
      final question = r['diagnostic_nodes']?['content'] as String?;
      final answer = r['diagnostic_edges']?['label'] as String?;
      if (question != null && answer != null) {
        responsesMap[nodeId] = {'question': question, 'answer': answer};
      }
    }

    final List<dynamic> data = stagesResponse;

    return data.map((stageJson) {
      final tasksJson = stageJson['roadmap_tasks'] as List<dynamic>? ?? [];
      final orderIndex = stageJson['order_index'] as int;
      final diagnosticNodeId = stageJson['diagnostic_node_id'] as String?;

      const currentActiveOrderIndex = 3;

      bool isCompleted = orderIndex < currentActiveOrderIndex;
      bool isActive = orderIndex == currentActiveOrderIndex;
      bool isLocked = orderIndex > currentActiveOrderIndex;

      final tasks = tasksJson.map((taskJson) {
        final taskOrder = taskJson['order_index'] as int;
        String state = 'locked';

        if (isActive) {
          if (taskOrder < 3) {
            state = 'completed';
          } else if (taskOrder == 3) {
            state = 'active';
          } else {
            state = 'locked';
          }
        } else if (isCompleted) {
          state = 'completed';
        } else {
          state = 'locked';
        }

        return RoadmapTask.fromJson(taskJson, state: state);
      }).toList();

      final qa = diagnosticNodeId != null
          ? responsesMap[diagnosticNodeId]
          : null;

      final stageJsonWithQA = Map<String, dynamic>.from(stageJson);
      stageJsonWithQA['question'] = qa?['question'];
      stageJsonWithQA['answer'] = qa?['answer'];

      return RoadmapStage.fromJson(
        stageJsonWithQA,
        isCompleted: isCompleted,
        isActive: isActive,
        isLocked: isLocked,
        tasks: tasks,
      );
    }).toList();
  }
}
