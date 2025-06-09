// lib/models/order.dart
import 'package:pt_best/models/job.dart';

class Order {
  final String orderId;
  final Job jobDetails;
  String status;
  final double createdAt;

  Order({
    required this.orderId,
    required this.jobDetails,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      jobDetails: Job.fromJson(json['jobDetails']),
      status: json['status'],
      createdAt: json['createdAt'],
    );
  }
}