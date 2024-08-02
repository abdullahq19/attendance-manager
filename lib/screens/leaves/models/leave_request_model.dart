// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

enum LeaveRequestStatus { pending, approved, rejected }

class LeaveRequestModel {
  String email;
  String name;
  String profilePicUrl;
  DateTime fromDate;
  DateTime toDate;
  String? reason;
  String status;
  DateTime requestedAt;
  LeaveRequestModel({
    required this.email,
    required this.name,
    required this.profilePicUrl,
    required this.fromDate,
    required this.toDate,
    this.reason,
    required this.status,
    required this.requestedAt,
  });

  LeaveRequestModel copyWith({
    String? email,
    String? name,
    String? profilePicUrl,
    DateTime? fromDate,
    DateTime? toDate,
    String? reason,
    String? status,
    DateTime? requestedAt,
  }) {
    return LeaveRequestModel(
      email: email ?? this.email,
      name: name ?? this.name,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      requestedAt: requestedAt ?? this.requestedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'profilePicUrl': profilePicUrl,
      'fromDate': Timestamp.fromDate(fromDate),
      'toDate': Timestamp.fromDate(toDate),
      'reason': reason,
      'status': status,
      'requestedAt': Timestamp.fromDate(requestedAt),
    };
  }

  factory LeaveRequestModel.fromMap(Map<String, dynamic> map) {
    return LeaveRequestModel(
      email: map['email'] as String,
      name: map['name'] as String,
      profilePicUrl: map['profilePicUrl'] as String,
      fromDate: (map['fromDate'] as Timestamp).toDate(),
      toDate: (map['toDate'] as Timestamp).toDate(),
      reason: map['reason'] != null ? map['reason'] as String : null,
      status: map['status'] as String,
      requestedAt: (map['requestedAt'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaveRequestModel.fromJson(String source) =>
      LeaveRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LeaveRequestModel(email: $email, name: $name, profilePicUrl: $profilePicUrl, fromDate: $fromDate, toDate: $toDate, reason: $reason, status: $status, requestedAt: $requestedAt)';
  }

  @override
  bool operator ==(covariant LeaveRequestModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.name == name &&
        other.profilePicUrl == profilePicUrl &&
        other.fromDate == fromDate &&
        other.toDate == toDate &&
        other.reason == reason &&
        other.status == status &&
        other.requestedAt == requestedAt;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        profilePicUrl.hashCode ^
        fromDate.hashCode ^
        toDate.hashCode ^
        reason.hashCode ^
        status.hashCode ^
        requestedAt.hashCode;
  }
}
