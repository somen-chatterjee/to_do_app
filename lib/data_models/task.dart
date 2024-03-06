class Task {
  int? id;
  String? title;
  int? isCompleted;

  Task({this.id, this.title, this.isCompleted});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['isCompleted'] = isCompleted;
    return data;
  }
}
