import 'package:habitsapp/model/date.dart';
import 'package:intl/intl.dart';

class CalendarData {

  static DateTime getCurrentDay() {
    var today = DateTime.now();
    return today;
  }

  static DateTime getTomorrow() {
    var tommorow = DateTime.now().add(Duration(days: 1));
    return tommorow;
  }

  static List getNextDays(int duration) {
    var today = getCurrentDay();
    int num = 0;
    List list = [];
    for (var i = num; i < duration; i++) {
      DateTime nextDay = today.add(Duration(days: i));
      list.add(
        Date(
            fullDate: getFormatDate(nextDay),
            dayNumber: nextDay.day,
            month: getMonth(nextDay.month),
            monthShort: getShortMonthName(nextDay.month),
            weekday: getWeekday(nextDay.weekday),
            weekdayShort: getShortMonthName(nextDay.weekday),
            year: nextDay.year),
      );
    }
    return list;
  }

  static String getFormatDate(DateTime date) {
    var formatter = DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(date);
    return formatted;
  }

  static getMonth(int number) {
    switch (number) {
      case 1:
        return 'January';
      case 2:
        return 'Febuary';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
    }
    return '';
  }

  static getShortMonthName(int number) {
    switch (number) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return '';
  }

  static getWeekday(int number) {
    switch (number) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
    }
    return '';
  }

  static getShortWeekday(int number) {
    switch (number) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tu';
      case 3:
        return 'Wed';
      case 4:
        return 'Th';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
    }
    return '';
  }

  static String stringDate(Date date) {
    if(date.fullDate == getFormatDate(getCurrentDay())) {
      return 'Today';
    }
    else if(date.fullDate == getFormatDate(getTomorrow())) {
      return 'Tomorrow';
    }
    else {
      return date.dayNumber.toString();
    }
  }
}