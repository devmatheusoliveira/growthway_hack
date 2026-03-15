class DiagnosticNode {
  final String id;
  final String type; // 'question' or 'result'
  final String title;
  final String content;
  final bool isRoot;

  DiagnosticNode({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    required this.isRoot,
  });

  factory DiagnosticNode.fromJson(Map<String, dynamic> json) {
    return DiagnosticNode(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      content: json['content'],
      isRoot: json['is_root'] ?? false,
    );
  }
}

class DiagnosticEdge {
  final String id;
  final String fromNodeId;
  final String toNodeId;
  final String label;
  final String? description;
  final int orderIndex;
  final String? toNodeType;

  DiagnosticEdge({
    required this.id,
    required this.fromNodeId,
    required this.toNodeId,
    required this.label,
    this.description,
    required this.orderIndex,
    this.toNodeType,
  });

  factory DiagnosticEdge.fromJson(Map<String, dynamic> json) {
    return DiagnosticEdge(
      id: json['id'],
      fromNodeId: json['from_node_id'],
      toNodeId: json['to_node_id'],
      label: json['label'],
      description: json['description'],
      orderIndex: json['order_index'] ?? 0,
      toNodeType: json['to_node'] != null ? json['to_node']['type'] : null,
    );
  }
}
