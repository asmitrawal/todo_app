class Todo {
  String? title;

  Todo({required this.title});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(title: json["title"]);
  }

  Todo copywith({String? title}) {
    return Todo(title: title ?? this.title);
  }

  Map<String, dynamic> toJson() {
    return {"title": this.title};
  }
}
