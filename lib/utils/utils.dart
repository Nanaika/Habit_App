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


int getCurrentStreakWeek(List<int> completedWeeks) {
  if (completedWeeks.isEmpty) return 0;

  // Сортируем список выполненных недель
  completedWeeks.sort();

  int currentStreak = 1;
  int lastCompletedWeek = completedWeeks[0];

  for (int i = 1; i < completedWeeks.length; i++) {
    if (completedWeeks[i] == lastCompletedWeek + 1) {
      // Увеличиваем streak, если недели идут подряд
      currentStreak++;
    } else if (completedWeeks[i] > lastCompletedWeek + 1) {
      // Если разрыв между неделями, streak прерывается
      break;
    }
    lastCompletedWeek = completedWeeks[i];
  }

  return currentStreak;
}



int getMaxStreakWeeks(List<int> completedWeeks) {
  if (completedWeeks.isEmpty) return 0;

  // Сортируем список выполненных недель
  completedWeeks.sort();

  int maxStreak = 1;
  int currentStreak = 1;

  for (int i = 1; i < completedWeeks.length; i++) {
    if (completedWeeks[i] == completedWeeks[i - 1] + 1) {
      // Увеличиваем streak, если недели подряд
      currentStreak++;
      maxStreak = maxStreak < currentStreak ? currentStreak : maxStreak;
    } else if (completedWeeks[i] != completedWeeks[i - 1]) {
      // Сбрасываем streak, если недели не подряд
      currentStreak = 1;
    }
  }

  return maxStreak;
}


int getWeekNumber(DateTime date) {
  // Используем стандартный алгоритм для нахождения номера недели
  int dayOfYear = int.parse(DateFormat('D').format(date));
  DateTime startOfYear = DateTime(date.year, 1, 1);
  int daysSinceStartOfYear = dayOfYear - startOfYear.weekday + 1;
  return (daysSinceStartOfYear / 7).ceil();
}

int countDaysInCurrentWeek(List<DateTime> dates) {
  // Получаем сегодняшнюю дату
  final today = DateTime.now();

  // Находим начало недели (понедельник) и конец недели (воскресенье)
  final startOfWeek = DateTime(today.year, today.month, today.day)
      .subtract(Duration(days: today.weekday - 1)); // Понедельник
  final endOfWeek = startOfWeek.add(Duration(days: 6)); // Воскресенье

  // Фильтруем даты, которые попадают в текущую неделю
  final daysInCurrentWeek = dates.where((date) {
    // Нормализуем дату, убираем время
    final normalizedDate = DateTime(date.year, date.month, date.day);

    // Проверяем, попадает ли дата в текущую неделю
    return normalizedDate.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
        normalizedDate.isBefore(endOfWeek.add(Duration(days: 1)));
  }).toList();

  // Возвращаем количество таких дат
  return daysInCurrentWeek.length;
}

List<int> getIndicesOfCurrentWeekDates(List<DateTime> dates) {
  // Получаем сегодняшнюю дату
  final today = DateTime.now();

  // Находим начало недели (понедельник) и конец недели (воскресенье)
  final startOfWeek = DateTime(today.year, today.month, today.day)
      .subtract(Duration(days: today.weekday - 1)); // Начало недели — понедельник
  final endOfWeek = startOfWeek.add(const Duration(days: 6)); // Конец недели — воскресенье

  // Находим индексы дат, которые попадают в текущую неделю (год, месяц, день)
  final indices = <int>[];
  for (int i = 0; i < dates.length; i++) {
    // Нормализуем дату (сбрасываем время)
    final date = DateTime(dates[i].year, dates[i].month, dates[i].day);

    // Проверяем, если дата попадает в текущую неделю
    if (date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        date.isBefore(endOfWeek.add(const Duration(days: 1)))) {
      // Получаем индекс дня недели
      final dayIndex = date.weekday - 1; // Понедельник = 0, вторник = 1, ...
      indices.add(dayIndex); // Добавляем индекс дня недели
    }
  }

  return indices;
}

int getIndexOfTodayInCurrentWeek() {
  final today = DateTime.now();

  // Находим начало недели (понедельник)
  final startOfWeek = DateTime(today.year, today.month, today.day)
      .subtract(Duration(days: today.weekday - 1)); // Понедельник

  // Индекс сегодняшнего дня в текущей неделе (от 0 для понедельника до 6 для воскресенья)
  return today.weekday - 1;  // Понедельник = 0, Воскресенье = 6
}


