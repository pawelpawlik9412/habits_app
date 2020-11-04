class Date {

  String fullDate;
  int dayNumber;
  String weekdayShort;
  String weekday;
  String monthShort;
  String month;
  int year;

  Date({
    this.fullDate,
    this.dayNumber,
    this.weekdayShort,
    this.weekday,
    this.monthShort,
    this.month,
    this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullDate': fullDate,
      'dayNumber': dayNumber,
      'weekdayShort': weekdayShort,
      'weekday': weekday,
      'monthShort': monthShort,
      'month': month,
      'year': year,
    };
  }

  Date.fromFirestore(Map<String, dynamic> firestore)
      : fullDate = firestore['fullDate'],
        dayNumber = firestore['dayNumber'],
        weekdayShort = firestore['weekdayShort'],
        weekday = firestore['weekday'],
        monthShort = firestore['monthShort'],
        month = firestore['month'],
        year = firestore['year'];
}
