// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:attendance_management_system/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarkedStudents {
  String name;
  String email;
  String profilePicUrl;
  String attendanceStatus;
  DateTime? markedAt;
  MarkedStudents({
    required this.name,
    required this.email,
    required this.profilePicUrl,
    required this.attendanceStatus,
    required this.markedAt,
  });

  MarkedStudents copyWith({
    String? name,
    String? email,
    String? profilePicUrl,
    String? attendanceStatus,
    DateTime? markedAt,
  }) {
    return MarkedStudents(
      name: name ?? this.name,
      email: email ?? this.email,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      attendanceStatus: attendanceStatus ?? this.attendanceStatus,
      markedAt: markedAt ?? this.markedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profilePicUrl': profilePicUrl,
      'attendanceStatus': attendanceStatus,
      'markedAt': markedAt,
    };
  }

  factory MarkedStudents.fromMap(Map<String, dynamic> map) {
    return MarkedStudents(
      name: map['name'] ?? 'Unknown',
      email: map['email'] ?? 'No email',
      profilePicUrl: map['profilePicUrl'] ?? defaultImageUrl,
      attendanceStatus: map['attendanceStatus'] ?? 'Unknown',
      markedAt: map['markedAt'] is Timestamp
          ? (map['markedAt'] ?? Timestamp.now()).toDate()
          : map['markedAt'] ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MarkedStudents.fromJson(String source) =>
      MarkedStudents.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MarkedStudents(name: $name, email: $email, profilePicUrl: $profilePicUrl, attendanceStatus: $attendanceStatus, markedAt: $markedAt)';
  }

  @override
  bool operator ==(covariant MarkedStudents other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.profilePicUrl == profilePicUrl &&
        other.attendanceStatus == attendanceStatus &&
        other.markedAt == markedAt;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        profilePicUrl.hashCode ^
        attendanceStatus.hashCode ^
        markedAt.hashCode;
  }
}
