import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pt_best/models/order.dart';
import 'package:pt_best/services/api_service.dart';

class History extends StatefulWidget {
  final Function({bool switchToOrders}) onJobResigned;
  const History({Key? key, required this.onJobResigned}) : super(key: key);

  @override
  State<History> createState() => HistoryState();
}

// State class name is now PUBLIC (no underscore)
class HistoryState extends State<History> {
  final ApiService apiService = ApiService();
  List<Order> _allOrders = [];
  List<Order> _requests = [];
  List<Order> _accepted = [];
  List<Order> _completed = [];
  bool _isLoading = true;
  int _selectedFilter = 0;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  // Method name is now PUBLIC (no underscore)
  Future<void> fetchOrders() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final orders = await apiService.fetchOrders();
      _allOrders = orders;
      _filterOrders();
      _allOrders.where((o) => o.status == 'Pending').forEach(_startAcceptanceTimer);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch orders: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _filterOrders() {
    if (!mounted) return;
    setState(() {
      _requests = _allOrders.where((o) => o.status == 'Pending').toList();
      _accepted = _allOrders.where((o) => o.status == 'Accepted').toList();
      _completed = _allOrders.where((o) => o.status == 'Completed').toList();
    });
  }

  void _startAcceptanceTimer(Order order) {
    final timeSinceCreation = DateTime.now().millisecondsSinceEpoch / 1000 - order.createdAt;
    final remainingTime = 30 - timeSinceCreation;
    if (remainingTime > 0) {
      Timer(Duration(seconds: remainingTime.toInt()), () {
        if (mounted && order.status == 'Pending') {
          _updateOrderStatus(order.orderId);
        }
      });
    } else if (order.status == 'Pending') {
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateOrderStatus(order.orderId));
    }
  }

  Future<void> _updateOrderStatus(String orderId) async {
    try {
      await apiService.updateOrderStatus(orderId);
      await fetchOrders();
    } catch (e) {
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update status: ${e.toString()}')));
    }
  }

  Future<void> _resignFromJob(String orderId) async {
    try {
      await apiService.resignJob(orderId);
      widget.onJobResigned(switchToOrders: false);
    } catch(e) {
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to resign: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: fetchOrders,
        child: ListView(
          children: [
            searchBox(),
            const SizedBox(height: 15),
            selectBar(),
            const SizedBox(height: 15),
            _isLoading ? const Center(child: CircularProgressIndicator()) : requestList(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget requestList() {
    List<Order> currentList;
    switch (_selectedFilter) {
      case 0: currentList = _requests; break;
      case 1: currentList = _accepted; break;
      case 2: currentList = _completed; break;
      default: currentList = [];
    }
    if (currentList.isEmpty) {
      return const Center(child: Padding(padding: EdgeInsets.all(32.0), child: Text('No orders in this category.')));
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: currentList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 25),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        final order = currentList[index];
        return orderCard(order);
      },
    );
  }

  Widget orderCard(Order order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xffD9D9D9), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 35, height: 35,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xffF1F1F1)),
                child: Center(child: SvgPicture.asset('assets/icons/box.svg', width: 18, height: 18)),
              ),
              const SizedBox(width: 15),
              Expanded(child: Text(order.jobDetails.jobGiver, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: _getStatusColor(order.status)),
                child: Text(order.status, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
              )
            ],
          ),
          Divider(height: 20, color: Colors.grey[600]),
          Text('Price: ${order.jobDetails.priceOffer}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Pickup: ${order.jobDetails.address}', style: const TextStyle(fontSize: 10)),
          const SizedBox(height: 4),
          Text('Dropoff: ${order.jobDetails.dropAt}', style: const TextStyle(fontSize: 10)),
          const SizedBox(height: 10),
          if (order.status == 'Accepted' || order.status == 'Pending')
            Align(
              alignment: Alignment.bottomRight,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                alignment: WrapAlignment.end,
                children: [
                  if(order.status == 'Accepted')
                  ElevatedButton(
                      onPressed: () => _updateOrderStatus(order.orderId),
                      child: const Text("Mark as Done"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue)),
                  ElevatedButton(
                    onPressed: () => _resignFromJob(order.orderId),
                    child: const Text("Resign Job"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending': return const Color(0xffFFDE21);
      case 'Accepted': return const Color(0xff56D47A);
      case 'Completed': return const Color(0xffAFAFAF);
      default: return Colors.grey;
    }
  }

  Padding selectBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Container(
        height: 40,
        decoration: BoxDecoration(color: const Color(0xffC7C9CF), borderRadius: BorderRadius.circular(15)),
        child: Row(children: [
            Expanded(child: filterChip("Requests", 0)),
            Expanded(child: filterChip("Accepted", 1)),
            Expanded(child: filterChip("Completed", 2)),
        ]),
      ),
    );
  }

  Widget filterChip(String label, int index) {
    return ChoiceChip(
        selected: _selectedFilter == index,
        onSelected: (bool selected) => setState(() => _selectedFilter = index),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        selectedColor: const Color(0xff717171),
        backgroundColor: const Color(0xffC7C9CF),
        label: Center(child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black))),
        padding: EdgeInsets.zero,
    );
  }

  Widget searchBox() {
    return Align(alignment: Alignment.topCenter,
      child: Container(margin: const EdgeInsets.only(top: 40), height: 206, width: 362,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
              Container(width: 56, height: 56, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xff343738)),
                child: Center(child: SvgPicture.asset('assets/icons/profile.svg', width: 25, height: 25)),
              ),
              Container(width: 56, height: 56, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xff343738)),
                child: Center(child: SvgPicture.asset('assets/icons/notifications.svg', width: 25, height: 25)),
              ),
            ]),
            const Padding(padding: EdgeInsets.only(right: 100, top: 10),
              child: Text('Search Orders', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w100)),
            ),
            Padding( padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(width: 320, height: 45,
                child: Container(padding: const EdgeInsets.only(right:18),
                  decoration: BoxDecoration(color: const Color(0xffD9D9D9), borderRadius: BorderRadius.circular(15)),
                  child: TextField(decoration: InputDecoration(filled: true, fillColor: const Color(0xffD9D9D9),
                      contentPadding: const EdgeInsets.all(15), hintText: 'Search for works',
                      hintStyle: const TextStyle(color: Color(0xffADADAD), fontSize: 14),
                      prefixIcon: Padding(padding: const EdgeInsets.all(12), child: SvgPicture.asset('assets/icons/search.svg')),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}