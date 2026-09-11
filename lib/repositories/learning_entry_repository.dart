import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/learning_entry.dart';

class LearningEntryRepository {
  LearningEntryRepository({SharedPreferences? preferences})
    : _preferences = preferences;

  static const String _entriesKey = 'learning_entries';

  SharedPreferences? _preferences;
  final List<LearningEntry> _entries = [];

  Future<void> loadEntries() async {
    final SharedPreferences preferences = await _getPreferences();
    final List<String> savedEntries = preferences.getStringList(_entriesKey) ?? [];

    _entries
      ..clear()
      ..addAll(savedEntries.map(_decodeEntry));
  }

  List<LearningEntry> getEntries() {
    return List.unmodifiable(_entries);
  }

  Future<void> addEntry(LearningEntry entry) async {
    _entries.insert(0, entry);
    await _saveEntries();
  }

  Future<void> deleteEntry(int index) async {
    _entries.removeAt(index);
    await _saveEntries();
  }

  Future<SharedPreferences> _getPreferences() async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }

  Future<void> _saveEntries() async {
    final SharedPreferences preferences = await _getPreferences();
    final List<String> encodedEntries = _entries.map((entry) {
      return jsonEncode(entry.toJson());
    }).toList();

    await preferences.setStringList(_entriesKey, encodedEntries);
  }

  LearningEntry _decodeEntry(String value) {
    final Object? decodedValue = jsonDecode(value);
    if (decodedValue is Map<String, dynamic>) {
      return LearningEntry.fromJson(decodedValue);
    }

    return LearningEntry(
      topic: 'Untitled learning session',
      minutes: 0,
      notes: '',
      date: DateTime.now(),
    );
  }
}
