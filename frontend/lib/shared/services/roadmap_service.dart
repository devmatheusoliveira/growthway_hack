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

    // Busca tarefas concluídas pelo usuário
    final List<dynamic> completedTasksResponse = userId != null
        ? await _supabase
              .from('user_completed_tasks')
              .select('task_id')
              .eq('user_id', userId)
        : [];
    
    final Set<String> completedTaskIds = completedTasksResponse
        .map((t) => t['task_id'] as String)
        .toSet();

    final List<dynamic> data = stagesResponse;
    List<RoadmapStage> stages = [];
    bool foundActive = false;

    for (var stageJson in data) {
      final tasksJson = stageJson['roadmap_tasks'] as List<dynamic>? ?? [];
      final diagnosticNodeId = stageJson['diagnostic_node_id'] as String?;

      bool allTasksCompleted = tasksJson.isNotEmpty;
      List<RoadmapTask> tasks = [];
      
      for (var taskJson in tasksJson) {
        final taskId = taskJson['id'] as String;
        final isTaskDone = completedTaskIds.contains(taskId);
        
        if (!isTaskDone) allTasksCompleted = false;
        
        tasks.add(RoadmapTask.fromJson(
          taskJson, 
          state: isTaskDone ? 'completed' : 'active',
        ));
      }

      bool isCompleted = allTasksCompleted && tasksJson.isNotEmpty;
      bool isActive = false;
      bool isLocked = false;

      if (!isCompleted && !foundActive) {
        isActive = true;
        foundActive = true;
      } else if (!isCompleted && foundActive) {
        isLocked = true;
      } else if (isCompleted) {
        // Já está marcado como complete
      }

      // Se todas as anteriores estão completas e esta não tem tarefas, ela fica ativa ou locked?
      // Por simplicidade, se for a primeira não completa, é ativa.

      final qa = diagnosticNodeId != null
          ? responsesMap[diagnosticNodeId]
          : null;

      final stageJsonWithQA = Map<String, dynamic>.from(stageJson);
      stageJsonWithQA['question'] = qa?['question'];
      stageJsonWithQA['answer'] = qa?['answer'];

      stages.add(RoadmapStage.fromJson(
        stageJsonWithQA,
        isCompleted: isCompleted,
        isActive: isActive,
        isLocked: isLocked,
        tasks: tasks,
      ));
    }

    return stages;
  }

  Future<void> toggleTaskCompletion(String taskId, bool completed) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    if (completed) {
      await _supabase.from('user_completed_tasks').upsert({
        'user_id': userId,
        'task_id': taskId,
      });
    } else {
      await _supabase
          .from('user_completed_tasks')
          .delete()
          .eq('user_id', userId)
          .eq('task_id', taskId);
    }
  }
}
