import 'package:intl/intl.dart';

import '../domain/models/habit.dart';
import 'const.dart';

String formatDate(DateTime date) {
  return DateFormat('dd.MM.yyyy').format(date);
}

double calculateCompletionPercentage(int completedTasks, int totalTasks) {
  if (totalTasks == 0) {
    return 0;
  }
  return (completedTasks / totalTasks) * 100;
}

String getCategoryAsset(HabitCategory category) {
  switch (category) {
    case HabitCategory.sport:
      return categoryImagePath[0];
    case HabitCategory.nutrition:
      return categoryImagePath[1];
    case HabitCategory.sleep:
      return categoryImagePath[2];
    case HabitCategory.meditation:
      return categoryImagePath[3];
    case HabitCategory.reading:
      return categoryImagePath[4];
    case HabitCategory.creativity:
      return categoryImagePath[5];
    case HabitCategory.other:
      return categoryImagePath[6];
  }
}

int findTypeIndex(HabitType type) {
  return switch (type) {
    HabitType.daily => 0,
    HabitType.weekly => 1,
  };
}

int findCategoryIndex(HabitCategory category) {
  return switch (category) {
    HabitCategory.sport => 0,
    HabitCategory.nutrition => 1,
    HabitCategory.sleep => 2,
    HabitCategory.meditation => 3,
    HabitCategory.reading => 4,
    HabitCategory.creativity => 5,
    HabitCategory.other => 6,
  };
}

List<DateTime> getWeekDays(DateTime date) {
  int dayOfWeek = date.weekday;

  DateTime startOfWeek = date.subtract(Duration(days: dayOfWeek - 1));

  List<DateTime> weekDays = List.generate(7, (index) {
    return startOfWeek.add(Duration(days: index));
  });

  return weekDays;
}

int getWeekOfYear(DateTime date) {
  DateTime firstDayOfYear = DateTime(date.year, 1, 1);

  int weekdayOfFirstDay = firstDayOfYear.weekday;

  DateTime adjustedFirstDay = weekdayOfFirstDay <= DateTime.monday
      ? firstDayOfYear.subtract(Duration(days: weekdayOfFirstDay - 1))
      : firstDayOfYear.add(Duration(days: DateTime.daysPerWeek - weekdayOfFirstDay + 1));

  int differenceInDays = date.difference(adjustedFirstDay).inDays;

  int weekNumber = (differenceInDays / 7).floor() + 1;
  return weekNumber;
}

double calculatePercentage(int currentAttempts, int maxAttempts) {
  if (maxAttempts == 0) return 0;
  return (currentAttempts / maxAttempts);
}

bool isCompletedToday(List<DateTime> completedDays) {
  // if(completedDays.isEmpty) return false;
  final today = DateTime.now();
  return completedDays.any(
    (elem) => elem.year == today.year && elem.month == today.month && elem.day == today.day,
  );
}

bool isCompletedThisWeek(List<int> completedWeek) {
  final currentWeek = getWeekOfYear(DateTime.now());
  return completedWeek.any(
    (elem) => elem == currentWeek,
  );
}

int getCurrentStreak(List<DateTime> completedDays) {
  if (completedDays.isEmpty) return 0;

  completedDays = completedDays.map((date) => DateTime(date.year, date.month, date.day)).toList()..sort();

  DateTime today = DateTime.now();
  DateTime currentDay = DateTime(today.year, today.month, today.day);
  int streak = 0;

  for (int i = completedDays.length - 1; i >= 0; i--) {
    if (completedDays[i] == currentDay) {
      streak++;
      currentDay = currentDay.subtract(const Duration(days: 1));
    } else if (completedDays[i].isBefore(currentDay)) {
      break;
    }
  }

  return streak;
}

int getMaxStreak(List<DateTime> completedDays) {
  if (completedDays.isEmpty) return 0;

  completedDays = completedDays.map((date) => DateTime(date.year, date.month, date.day)).toList()..sort();

  int maxStreak = 1;
  int currentStreak = 1;

  for (int i = 1; i < completedDays.length; i++) {
    if (completedDays[i].difference(completedDays[i - 1]).inDays == 1) {
      currentStreak++;
      maxStreak = maxStreak < currentStreak ? currentStreak : maxStreak;
    } else if (completedDays[i] != completedDays[i - 1]) {
      currentStreak = 1;
    }
  }

  return maxStreak;
}

int getCurrentStreakWeek(List<int> completedWeeks) {
  if (completedWeeks.isEmpty) return 0;

  completedWeeks.sort();

  int currentStreak = 1;
  int lastCompletedWeek = completedWeeks[0];

  for (int i = 1; i < completedWeeks.length; i++) {
    if (completedWeeks[i] == lastCompletedWeek + 1) {
      currentStreak++;
    } else if (completedWeeks[i] > lastCompletedWeek + 1) {
      break;
    }
    lastCompletedWeek = completedWeeks[i];
  }

  return currentStreak;
}

int getMaxStreakWeeks(List<int> completedWeeks) {
  if (completedWeeks.isEmpty) return 0;

  completedWeeks.sort();

  int maxStreak = 1;
  int currentStreak = 1;

  for (int i = 1; i < completedWeeks.length; i++) {
    if (completedWeeks[i] == completedWeeks[i - 1] + 1) {
      currentStreak++;
      maxStreak = maxStreak < currentStreak ? currentStreak : maxStreak;
    } else if (completedWeeks[i] != completedWeeks[i - 1]) {
      currentStreak = 1;
    }
  }

  return maxStreak;
}

int getWeekNumber(DateTime date) {
  int dayOfYear = int.parse(DateFormat('D').format(date));
  DateTime startOfYear = DateTime(date.year, 1, 1);
  int daysSinceStartOfYear = dayOfYear - startOfYear.weekday + 1;
  return (daysSinceStartOfYear / 7).ceil();
}

int countDaysInCurrentWeek(List<DateTime> dates) {
  final today = DateTime.now();
  final startOfWeek = DateTime(today.year, today.month, today.day).subtract(Duration(days: today.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 6));
  final daysInCurrentWeek = dates.where((date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return normalizedDate.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        normalizedDate.isBefore(endOfWeek.add(const Duration(days: 1)));
  }).toList();
  return daysInCurrentWeek.length;
}

List<int> getIndicesOfCurrentWeekDates(List<DateTime> dates) {
  final today = DateTime.now();

  final startOfWeek = DateTime(today.year, today.month, today.day).subtract(Duration(days: today.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 6));

  final indices = <int>[];
  for (int i = 0; i < dates.length; i++) {
    final date = DateTime(dates[i].year, dates[i].month, dates[i].day);
    if (date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        date.isBefore(endOfWeek.add(const Duration(days: 1)))) {
      final dayIndex = date.weekday - 1;
      indices.add(dayIndex);
    }
  }

  return indices;
}

int getIndexOfTodayInCurrentWeek() {
  final today = DateTime.now();
  final startOfWeek = DateTime(today.year, today.month, today.day).subtract(Duration(days: today.weekday - 1));
  return today.weekday - 1;
}
