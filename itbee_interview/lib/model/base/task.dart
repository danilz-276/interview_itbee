class Task {
  final int? id;
  final String title;
  final String? description;
  final int status;
  final String? dueDate;
  final String? startDate;
  final String createdAt;
  final String updatedAt;

  Task({
    this.id,
    required this.title,
    this.description,
    this.status = 0,
    this.dueDate,
    this.startDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    status: json['status'],
    dueDate: json['due_date'],
    startDate: json['start_date'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'status': status,
    'due_date': dueDate,
    'start_date': startDate,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
