// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

enum AttendanceStatus { present, absent, onLeave }

class AttendanceModel {
  final String email;
  final String status;
  final DateTime timestamp;
  AttendanceModel({
    required this.email,
    required this.status,
    required this.timestamp,
  });

  AttendanceModel copyWith({
    String? email,
    String? status,
    DateTime? timestamp,
  }) {
    return AttendanceModel(
      email: email ?? this.email,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'status': status,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      email: map['email'] as String,
      status: map['status'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceModel.fromJson(String source) =>
      AttendanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AttendanceModel(email: $email, status: $status, timestamp: $timestamp)';

  @override
  bool operator ==(covariant AttendanceModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.status == status &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode => email.hashCode ^ status.hashCode ^ timestamp.hashCode;
}
