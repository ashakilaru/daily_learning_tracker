import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../features/analytics/analytics_summary.dart';
import '../../features/calendar/calendar_summary.dart';
import '../../features/entries/add_entry/add_entry_form.dart';
import '../../features/entries/entry_list.dart';
import '../../features/settings/settings_panel.dart';
import '../../models/learning_entry.dart';
import '../../repositories/learning_entry_repository.dart';
import '../../services/learning_stats_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final LearningEntryRepository _repository = LearningEntryRepository();
  final LearningStatsService _statsService = const LearningStatsService();

  int _dailyGoalMinutes = AppConstants.defaultDailyGoalMinutes;
  List<LearningEntry> _entries = [];
  bool _isLoading = true;

  int get _todayMinutes => _statsService.minutesToday(_entries);
  int get _weekMinutes => _statsService.minutesThisWeek(_entries);
  int get _streakDays => _statsService.streakDays(_entries);

  double get _goalProgress {
    return (_todayMinutes / _dailyGoalMinutes).clamp(0, 1).toDouble();
  }

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    await _repository.loadEntries();

    if (!mounted) {
      return;
    }

    setState(() {
      _entries = _repository.getEntries();
      _isLoading = false;
    });
  }

  Future<void> _addEntry(LearningEntry entry) async {
    await _repository.addEntry(entry);

    if (!mounted) {
      return;
    }

    setState(() {
      _entries = _repository.getEntries();
    });
  }

  Future<void> _deleteEntry(int index) async {
    await _repository.deleteEntry(index);

    if (!mounted) {
      return;
    }

    setState(() {
      _entries = _repository.getEntries();
    });
  }

  void _changeGoal(int minutes) {
    setState(() {
      _dailyGoalMinutes = minutes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  AnalyticsSummary(
                    todayMinutes: _todayMinutes,
                    weekMinutes: _weekMinutes,
                    streakDays: _streakDays,
                    dailyGoalMinutes: _dailyGoalMinutes,
                    progress: _goalProgress,
                  ),
                  const SizedBox(height: 16),
                  SettingsPanel(
                    dailyGoalMinutes: _dailyGoalMinutes,
                    onGoalChanged: _changeGoal,
                  ),
                  const SizedBox(height: 16),
                  CalendarSummary(entries: _entries),
                  const SizedBox(height: 16),
                  AddEntryForm(onEntryAdded: _addEntry),
                  const SizedBox(height: 16),
                  EntryList(entries: _entries, onDelete: _deleteEntry),
                ],
              ),
      ),
    );
  }
}
