import 'dart:convert';

class AppUser {
  final String uid;
  final String name;
  final String email;
  final String role; // 'student' or 'admin'
  String? profilePicUrl;
  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.profilePicUrl,
  });

  AppUser copyWith({
    String? uid,
    String? name,
    String? email,
    String? role,
    String? profilePicUrl,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'profilePicUrl': profilePicUrl,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      profilePicUrl:
          map['profilePicUrl'] != null ? map['profilePicUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(uid: $uid, name: $name, email: $email, role: $role, profilePicUrl: $profilePicUrl)';
  }

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.role == role &&
        other.profilePicUrl == profilePicUrl;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        role.hashCode ^
        profilePicUrl.hashCode;
  }
}
