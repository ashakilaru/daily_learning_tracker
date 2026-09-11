import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({
    super.key,
    required this.dailyGoalMinutes,
    required this.onGoalChanged,
  });

  final int dailyGoalMinutes;
  final ValueChanged<int> onGoalChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5DDD1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.flag_outlined, size: 20),
          const SizedBox(width: 8),
          const Text('Daily goal'),
          Expanded(
            child: Slider(
              value: dailyGoalMinutes.toDouble(),
              min: AppConstants.minimumGoalMinutes.toDouble(),
              max: AppConstants.maximumGoalMinutes.toDouble(),
              divisions: 11,
              label: '$dailyGoalMinutes min',
              onChanged: (value) => onGoalChanged(value.round()),
            ),
          ),
        ],
      ),
    );
  }
}
