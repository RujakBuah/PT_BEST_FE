// lib/models/job.dart
class Job {
  final String id;
  final String jobGiver;
  final String posted;
  final String address;
  final String dropAt;
  final String deadline;
  final String priceOffer;

  Job({
    required this.id,
    required this.jobGiver,
    required this.posted,
    required this.address,
    required this.dropAt,
    required this.deadline,
    required this.priceOffer,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      jobGiver: json['jobGiver'],
      posted: json['posted'],
      address: json['address'],
      dropAt: json['dropAt'],
      deadline: json['deadline'],
      priceOffer: json['priceOffer'],
    );
  }
}