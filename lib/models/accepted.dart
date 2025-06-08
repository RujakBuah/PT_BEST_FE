import 'package:flutter/material.dart';

class AccModel {
  String orderName; 
  String status;
  String soliciter;
  String duration; 
  String date; 
  String price; 
  Color statusColor;

  AccModel({
    required this.orderName,
    required this.status, 
    required this.soliciter, 
    required this.duration, 
    required this.date, 
    required this.price, 
    required this.statusColor
  });

  static List < AccModel > getAcc() {
    List < AccModel > accepted = [];

    accepted.add(
      AccModel(
        orderName: 'Order #21',
        status: 'Accepted',
        soliciter: 'Hoyoverse',
        duration: '7 Days',
        date: '30/10/2025',
        price: 'Rp 25,000',
        statusColor: Color(0xff56D47A)
      )
    );

    accepted.add(
      AccModel(
        orderName: 'Order #55',
        status: 'Accepted',
        soliciter: 'PT Sampoerna',
        duration: '18 Days',
        date: '30/10/2025',
        price: 'Rp 26,000',
        statusColor: Color(0xff56D47A)
      )
    );

    accepted.add(
      AccModel(
        orderName: 'Order #120',
        status: 'Accepted',
        soliciter: 'Gudang Garam',
        duration: '14 Days',
        date: '30/10/2025',
        price: 'Rp 90,000',
        statusColor: Color(0xff56D47A)
      )
    );
    return accepted;
  }
}