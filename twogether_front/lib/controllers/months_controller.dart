import 'package:flutter/foundation.dart';

class MonthsController with ChangeNotifier {
  // months
  DateTime _visibleMonth = DateTime.now();

  static const List<String> _monthNames = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  DateTime get visibleMonth => _visibleMonth;

  String get visibleMonthLabel =>
      '${_monthNames[_visibleMonth.month - 1]} ${_visibleMonth.year}';

  int get daysInVisibleMonth => _daysInMonth(_visibleMonth);

  int _daysInMonth(DateTime date) {
    final lastDay = DateTime(date.year, date.month + 1, 0);
    return lastDay.day;
  }

  void prevMonth() {
    _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month - 1, 1);
    notifyListeners();
  }

  void nextMonth() {
    _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1, 1);
    notifyListeners();
  }
}
