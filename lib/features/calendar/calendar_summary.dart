import 'package:flutter/material.dart';

import '../../core/utils/date_formatter.dart';
import '../../models/learning_entry.dart';

class CalendarSummary extends StatelessWidget {
  const CalendarSummary({super.key, required this.entries});

  final List<LearningEntry> entries;

  @override
  Widget build(BuildContext context) {
    final List<DateTime> days = List.generate(
      7,
      (index) => DateFormatter.startOfDay(
        DateTime.now().subtract(Duration(days: 6 - index)),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5DDD1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This week',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: days.map((day) {
              final int minutes = entries
                  .where((entry) => DateFormatter.isSameDay(entry.date, day))
                  .fold(0, (total, entry) => total + entry.minutes);

              return Expanded(
                child: _DayPill(day: day, minutes: minutes),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _DayPill extends StatelessWidget {
  const _DayPill({required this.day, required this.minutes});

  final DateTime day;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    final bool hasLearning = minutes > 0;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        constraints: const BoxConstraints(minHeight: 72),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: hasLearning ? colorScheme.tertiaryContainer : const Color(0xFFF3EEE7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weekday(day), style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(
              minutes == 0 ? '-' : '$minutes',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String _weekday(DateTime date) {
    return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
  }
}
