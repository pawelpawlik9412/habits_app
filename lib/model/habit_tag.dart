class HabitTag {
  String tagLabel;
  int tagColor;

  HabitTag({
    this.tagLabel,
    this.tagColor,
  });

  Map<String, dynamic> toMap() {
    return {
      'tagLabel': tagLabel,
      'tagColor': tagColor,
    };
  }

  HabitTag.fromFirestore(Map<String, dynamic> firestore)
      : tagLabel = firestore['tagLabel'],
        tagColor = firestore['tagColor'];
}
