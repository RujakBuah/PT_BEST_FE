import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pt_best/models/job.dart';
import 'package:pt_best/models/order.dart';
import 'package:pt_best/services/api_service.dart';

class jobList extends StatefulWidget {
  final Function({bool switchToOrders}) onJobApplied;
  const jobList({Key? key, required this.onJobApplied}) : super(key: key);

  @override
  // Use the public State class name
  State<jobList> createState() => jobListState();
}

// State class name is now PUBLIC (no underscore)
class jobListState extends State<jobList> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  // Method name is now PUBLIC (no underscore)
  Future<List<dynamic>> fetchData() async {
    final jobs = await apiService.fetchJobs();
    final orders = await apiService.fetchOrders();
    return [jobs, orders];
  }

  void _applyToJob(String jobId) async {
    try {
      await apiService.applyForJob(jobId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully applied! Check your Orders.')),
      );
      widget.onJobApplied(switchToOrders: true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _dataFuture = fetchData();
          });
        },
        child: FutureBuilder<List<dynamic>>(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available.'));
            }

            final List<Job> jblists = snapshot.data![0];
            final List<Order> orders = snapshot.data![1];
            bool isJobActive = orders.any((o) => o.status == 'Pending' || o.status == 'Accepted');

            return ListView.separated(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              itemCount: jblists.length,
              separatorBuilder: (context, index) => const SizedBox(height: 25),
              itemBuilder: (context, index) {
                final job = jblists[index];
                return jobCard(job, isJobActive: isJobActive);
              },
            );
          },
        ),
      ),
    );
  }

  Widget jobCard(Job job, {required bool isJobActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/icons/whojob.svg', width: 40, height: 40),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.jobGiver, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
                    Text(job.posted, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xff797B7B))),
                  ],
                ),
              ),
              SvgPicture.asset('assets/icons/3dodot.svg', width: 25, height: 25),
            ],
          ),
          const SizedBox(height: 10),
          detailRow('Pickup:', job.address),
          const SizedBox(height: 4),
          detailRow('Dropoff:', job.dropAt),
          const SizedBox(height: 4),
          detailRow('Complete by:', job.deadline),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: isJobActive ? null : () => _applyToJob(job.id),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff35883B),
                disabledBackgroundColor: Colors.grey[600],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              child: Text(
                isJobActive ? 'Job Active' : 'Apply',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w400, color: Color(0xff343738))),
        Text(value, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black)),
      ],
    );
  }

  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AppBar(
        toolbarHeight: 100,
        title: const Text('Job listings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xff00426C))),
        backgroundColor: const Color(0xffD9D9D9),
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset('assets/icons/Logo.svg'),
        ),
      ),
    );
  }
}