class UserModel {
  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;

  const UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoUrl,
  });

  factory UserModel.fromFirestore(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return UserModel(
      uid: documentId,
      displayName: json['displayName'] ?? json['name'] ?? 'No Name',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'] ?? json['photoURL'] ?? '',
    );
  }

  factory UserModel.fromFirebaseUser(dynamic user) {
    return UserModel(
      uid: user.uid,
      displayName: user.displayName ?? 'No Name',
      email: user.email ?? '',
      photoUrl: user.photoURL ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}
