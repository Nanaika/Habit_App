import 'package:intl/intl.dart';

import '../domain/models/habit.dart';
import 'const.dart';

String formatDate(DateTime date) {
  return DateFormat('dd.MM.yyyy').format(date);
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
  // Находим день недели для текущей даты
  int dayOfWeek = date.weekday;

  // Вычисляем начало недели (понедельник)
  DateTime startOfWeek = date.subtract(Duration(days: dayOfWeek - 1));

  // Создаём список всех дней недели
  List<DateTime> weekDays = List.generate(7, (index) {
    return startOfWeek.add(Duration(days: index)); // Добавляем дни к началу недели
  });

  return weekDays;
}

int getWeekOfYear(DateTime date) {
  // Получаем первый день года
  DateTime firstDayOfYear = DateTime(date.year, 1, 1);

  // Вычисляем день недели для первого дня года
  int weekdayOfFirstDay = firstDayOfYear.weekday;

  // Если первый день года не понедельник, сдвигаем дату на ближайший понедельник
  DateTime adjustedFirstDay = weekdayOfFirstDay <= DateTime.monday
      ? firstDayOfYear.subtract(Duration(days: weekdayOfFirstDay - 1))
      : firstDayOfYear.add(Duration(days: DateTime.daysPerWeek - weekdayOfFirstDay + 1));

  // Вычисляем разницу в днях между датой и первым понедельником
  int differenceInDays = date.difference(adjustedFirstDay).inDays;

  // Вычисляем номер недели
  int weekNumber = (differenceInDays / 7).floor() + 1;
  print('WEEK number -------${weekNumber}');
  return weekNumber;
}

double calculatePercentage(int currentAttempts, int maxAttempts) {
  if (maxAttempts == 0) return 0; // защита от деления на ноль
  return (currentAttempts / maxAttempts);
}

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any(
    (elem) => elem.year == today.year && elem.month == today.month && elem.day == today.day,
  );
}

int getCurrentStreak(List<DateTime> completedDays) {
  if (completedDays.isEmpty) return 0;

  // Приводим все даты к формату "год, месяц, день"
  completedDays = completedDays.map((date) => DateTime(date.year, date.month, date.day)).toList()
    ..sort(); // Сортируем даты по порядку

  DateTime today = DateTime.now();
  DateTime currentDay = DateTime(today.year, today.month, today.day);
  int streak = 0;

  // Идём от текущей даты назад
  for (int i = completedDays.length - 1; i >= 0; i--) {
    if (completedDays[i] == currentDay) {
      streak++; // Увеличиваем streak, если текущий день выполнен
      currentDay = currentDay.subtract(const Duration(days: 1)); // Проверяем вчера
    } else if (completedDays[i].isBefore(currentDay)) {
      break; // Прерываем, если дни не подряд
    }
  }

  return streak;
}

int getMaxStreak(List<DateTime> completedDays) {
  if (completedDays.isEmpty) return 0;

  // Приводим все даты к формату "год, месяц, день"
  completedDays = completedDays.map((date) => DateTime(date.year, date.month, date.day)).toList()
    ..sort(); // Сортируем даты по порядку

  int maxStreak = 1;
  int currentStreak = 1;

  for (int i = 1; i < completedDays.length; i++) {
    if (completedDays[i].difference(completedDays[i - 1]).inDays == 1) {
      currentStreak++; // Увеличиваем streak, если дни подряд
      maxStreak = maxStreak < currentStreak ? currentStreak : maxStreak;
    } else if (completedDays[i] != completedDays[i - 1]) {
      currentStreak = 1; // Сбрасываем streak, если дни не подряд
    }
  }

  return maxStreak;
}


int getCurrentStreakWeek(List<DateTime> completedDays) {
  if (completedDays.isEmpty) return 0;

  // Приводим все даты к формату "год, месяц, день"
  completedDays = completedDays
      .map((date) => DateTime(date.year, date.month, date.day))
      .toList()
    ..sort(); // Сортируем даты по порядку

  int currentStreak = 1;
  DateTime lastCompletedDay = completedDays[0];

  for (int i = 1; i < completedDays.length; i++) {
    // Проверяем, попадают ли две даты в одну неделю
    if (getWeekNumber(lastCompletedDay) == getWeekNumber(completedDays[i])) {
      currentStreak++; // Увеличиваем streak, если дата в той же неделе
    } else {
      break; // Если день не в той же неделе, завершить streak
    }
    lastCompletedDay = completedDays[i];
  }

  return currentStreak;
}



int getMaxStreakWeek(List<DateTime> completedDays) {
  if (completedDays.isEmpty) return 0;

  // Приводим все даты к формату "год, месяц, день"
  completedDays = completedDays
      .map((date) => DateTime(date.year, date.month, date.day))
      .toList()
    ..sort(); // Сортируем даты по порядку

  int maxStreak = 1;
  int currentStreak = 1;
  DateTime lastCompletedDay = completedDays[0];

  for (int i = 1; i < completedDays.length; i++) {
    // Проверяем, попадают ли две даты в одну неделю
    if (getWeekNumber(lastCompletedDay) == getWeekNumber(completedDays[i])) {
      currentStreak++; // Увеличиваем streak, если дата в той же неделе
    } else {
      maxStreak = currentStreak > maxStreak ? currentStreak : maxStreak;
      currentStreak = 1; // Если день не в той же неделе, сбрасываем streak
    }
    lastCompletedDay = completedDays[i];
  }

  // Проверка для последнего streak
  maxStreak = currentStreak > maxStreak ? currentStreak : maxStreak;

  return maxStreak;
}

int getWeekNumber(DateTime date) {
  // Используем стандартный алгоритм для нахождения номера недели
  int dayOfYear = int.parse(DateFormat('D').format(date));
  DateTime startOfYear = DateTime(date.year, 1, 1);
  int daysSinceStartOfYear = dayOfYear - startOfYear.weekday + 1;
  return (daysSinceStartOfYear / 7).ceil();
}


