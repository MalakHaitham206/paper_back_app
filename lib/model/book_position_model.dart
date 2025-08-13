class BookPosition {
  final int chapterIndex;
  final int timePosition;

  BookPosition({required this.chapterIndex, required this.timePosition});

  factory BookPosition.fromJson(Map<String, dynamic> json) {
    return BookPosition(
      chapterIndex: json['chapterIndex'],
      timePosition: json['timePosition'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'chapterIndex': chapterIndex, 'timePosition': timePosition};
  }
}
