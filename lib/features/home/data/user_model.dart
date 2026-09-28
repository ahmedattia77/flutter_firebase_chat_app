class UserModel {
  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;
  final String status;
  final int lastSeen;

  const UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    this.status = 'Offline',
    this.lastSeen = 0,
  });

  factory UserModel.fromFirestore(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return UserModel(
      uid: documentId,
      displayName: json['name'] ?? json['displayName'] ?? 'new user',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'] ?? json['photoURL'] ?? '',
      status: json['status'] ?? 'Offline',
      lastSeen: json['last_seen'] ?? 0,
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
