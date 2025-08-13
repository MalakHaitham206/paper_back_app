class Chapter {
  final String id;
  final String title;
  final String content;
  final String duration;

  Chapter({
    required this.id,
    required this.title,
    required this.content,
    required this.duration,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'content': content, 'duration': duration};
  }
}
