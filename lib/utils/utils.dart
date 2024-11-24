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
  return switch(category) {
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

  return weekNumber;
}
double calculatePercentage(int currentAttempts, int maxAttempts) {
  if (maxAttempts == 0) return 0; // защита от деления на ноль
  return (currentAttempts / maxAttempts);
}

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any(
        (elem) =>
    elem.year == today.year &&
        elem.month == today.month &&
        elem.day == today.day,
  );
}
