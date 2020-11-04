class User {
  String uid;
  String email;
  String name;
  String photoUrl;

  User({
    this.uid,
    this.email,
    this.name,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
    };
  }

  User.fromFirestore(Map<String, dynamic> firestore)
      : uid = firestore['uid'],
        email = firestore['email'],
        name = firestore['name'],
        photoUrl = firestore['photoUrl'];
}
