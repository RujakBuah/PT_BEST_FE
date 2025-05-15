import 'package:flutter/material.dart';

class MixModel {
  String orderName; 
  String status;
  String soliciter;
  String duration; 
  String date; 
  String price; 
  Color statusColor;

  MixModel({
    required this.orderName,
    required this.status, 
    required this.soliciter, 
    required this.duration, 
    required this.date, 
    required this.price, 
    required this.statusColor
  });

  static List < MixModel > getMix() {
    List < MixModel > requests = [];

    requests.add(
      MixModel(
        orderName: 'Order #69',
        status: 'Pending',
        soliciter: 'PT Worst',
        duration: '10 Days',
        date: '21/08/2042',
        price: 'Rp 15,000',
        statusColor: Color(0xffFFDE21)
      )
    );

    requests.add(
      MixModel(
        orderName: 'Order #21',
        status: 'Accepted',
        soliciter: 'Hoyoverse',
        duration: '7 Days',
        date: '30/10/2025',
        price: 'Rp 25,000',
        statusColor: Color(0xff56D47A)
      )
    );

    requests.add(
      MixModel(
        orderName: 'Order #227',
        status: 'Rejected',
        soliciter: 'Moonton',
        duration: '14 Days',
        date: '27/05/2026',
        price: 'Rp 18,900',
        statusColor: Color(0xffFF3F41)
      )
    );

    return requests;
  }
}