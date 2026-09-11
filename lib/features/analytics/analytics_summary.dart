import 'package:flutter/material.dart';

import '../../widgets/metric_tile.dart';

class AnalyticsSummary extends StatelessWidget {
  const AnalyticsSummary({
    super.key,
    required this.todayMinutes,
    required this.weekMinutes,
    required this.streakDays,
    required this.dailyGoalMinutes,
    required this.progress,
  });

  final int todayMinutes;
  final int weekMinutes;
  final int streakDays;
  final int dailyGoalMinutes;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Keep your learning streak alive',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: colorScheme.surface,
            ),
          ),
          const SizedBox(height: 8),
          Text('$todayMinutes of $dailyGoalMinutes minutes completed today'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: MetricTile(
                  label: 'Today',
                  value: '$todayMinutes min',
                  icon: Icons.today,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MetricTile(
                  label: '7 days',
                  value: '$weekMinutes min',
                  icon: Icons.calendar_view_week,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MetricTile(
                  label: 'Streak',
                  value: '$streakDays days',
                  icon: Icons.local_fire_department,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
