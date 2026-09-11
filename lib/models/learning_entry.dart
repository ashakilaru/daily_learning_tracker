class LearningEntry {
  const LearningEntry({
    required this.topic,
    required this.minutes,
    required this.notes,
    required this.date,
  });

  factory LearningEntry.fromJson(Map<String, dynamic> json) {
    return LearningEntry(
      topic: json['topic'] as String? ?? '',
      minutes: json['minutes'] as int? ?? 0,
      notes: json['notes'] as String? ?? '',
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
    );
  }

  final String topic;
  final int minutes;
  final String notes;
  final DateTime date;

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'minutes': minutes,
      'notes': notes,
      'date': date.toIso8601String(),
    };
  }
}
