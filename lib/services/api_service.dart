import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pt_best/models/job.dart';
import 'package:pt_best/models/order.dart';

class ApiService {
  final String _baseUrl = 'http://10.0.2.2:5000';
  Map<String, String> _headers = {};

  Future<List<Job>> fetchJobs() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/jobs'));
    if (response.statusCode == 200) {
      _updateCookie(response);
      List<dynamic> body = jsonDecode(response.body);
      List<Job> jobs = body.map((dynamic item) => Job.fromJson(item)).toList();
      return jobs;
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  Future<Order> applyForJob(String jobId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/apply/$jobId'),
      headers: _headers,
    );
    _updateCookie(response);
    if (response.statusCode == 201) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(errorBody['error'] ?? 'Failed to apply for job');
    }
  }

  Future<List<Order>> fetchOrders() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/orders'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      _updateCookie(response);
      List<dynamic> body = jsonDecode(response.body);
      List<Order> orders = body.map((dynamic item) => Order.fromJson(item)).toList();
      return orders;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<Order> updateOrderStatus(String orderId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/orders/$orderId/update'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      _updateCookie(response);
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update order status');
    }
  }

  Future<void> resignJob(String orderId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/orders/$orderId/resign'),
      headers: _headers,
    );
    _updateCookie(response);
    if (response.statusCode != 200) {
      throw Exception('Failed to resign from job');
    }
  }

  void _updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      _headers['cookie'] = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}