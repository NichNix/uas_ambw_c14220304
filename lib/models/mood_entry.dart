class MoodEntry {
  final String id;
  final String emoji;
  final String? note;
  final DateTime createdAt;

  MoodEntry({
    required this.id,
    required this.emoji,
    this.note,
    required this.createdAt,
  });

  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      id: map['id'],
      emoji: map['emoji'],
      note: map['note'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
