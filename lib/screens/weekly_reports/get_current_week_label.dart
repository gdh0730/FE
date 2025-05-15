String getCurrentWeekLabel() {
  final now = DateTime.now();
  final firstDayOfMonth = DateTime(now.year, now.month, 1);
  final currentDay = now.day;

  int offset = firstDayOfMonth.weekday - 1; // 월요일 시작 기준 (weekday: 1 ~ 7)
  int weekNumber = ((currentDay + offset) / 7).ceil();

  const monthNames = [
    '',
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  const ordinal = ['first', 'second', 'third', 'fourth', 'fifth'];

  final weekLabel = weekNumber <= ordinal.length
      ? ordinal[weekNumber - 1]
      : '${weekNumber}th';

  return 'The $weekLabel week of ${monthNames[now.month]}';
}