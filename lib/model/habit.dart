class Habit {

  String date;
  String label;
  bool done;
  int tagColor;
  String tagId;
  String tagName;

  Habit({this.date, this.label, this.done, this.tagColor, this.tagId, this.tagName});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'label': label,
      'done': done,
      'tagColor': tagColor,
      'tagId': tagId,
      'tagName': tagName,
    };
  }

  Habit.fromFirestore(Map<String, dynamic> firestore)
      : date = firestore['date'],
        label = firestore['label'],
        done = firestore['done'],
        tagColor = firestore['tagColor'],
        tagId = firestore['tagId'],
        tagName = firestore['tagName'];
}
