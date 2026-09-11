import '../core/utils/date_formatter.dart';
import '../models/learning_entry.dart';

class LearningStatsService {
  const LearningStatsService();

  int minutesToday(List<LearningEntry> entries) {
    final DateTime today = DateTime.now();
    return entries
        .where((entry) => DateFormatter.isSameDay(entry.date, today))
        .fold(0, (total, entry) => total + entry.minutes);
  }

  int minutesThisWeek(List<LearningEntry> entries) {
    final DateTime weekStart = DateFormatter.startOfDay(
      DateTime.now().subtract(const Duration(days: 6)),
    );

    return entries
        .where((entry) => !entry.date.isBefore(weekStart))
        .fold(0, (total, entry) => total + entry.minutes);
  }

  int streakDays(List<LearningEntry> entries) {
    int streak = 0;
    DateTime day = DateFormatter.startOfDay(DateTime.now());

    while (entries.any((entry) => DateFormatter.isSameDay(entry.date, day))) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    }

    return streak;
  }
}
