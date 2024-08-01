// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum AttendanceStatus { present, absent, onLeave }

class AttendanceModel {
  final String status;
  final String timestamp;
  AttendanceModel({
    required this.status,
    required this.timestamp,
  });

  AttendanceModel copyWith({
    String? status,
    String? timestamp,
  }) {
    return AttendanceModel(
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'timestamp': timestamp,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      status: map['status'] as String,
      timestamp: map['timestamp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceModel.fromJson(String source) =>
      AttendanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AttendanceModel(status: $status, timestamp: $timestamp)';

  @override
  bool operator ==(covariant AttendanceModel other) {
    if (identical(this, other)) return true;

    return other.status == status && other.timestamp == timestamp;
  }

  @override
  int get hashCode => status.hashCode ^ timestamp.hashCode;
}
