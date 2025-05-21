import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pt_best/models/list.dart';

class jobList extends StatefulWidget {
  const jobList({super.key});

  @override
  State<jobList> createState() => _jobListState();
}

class _jobListState extends State<jobList> {
  List<ListModel> jblists = [];

  // ignore: unused_element
  void _getInitialInfo() {
    jblists = ListModel.getList();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        children: [
          jobColumns(jblists),
        ],
      ),
    );
  }

  Widget jobColumns(List<ListModel> jblists) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // because it's inside SingleChildScrollView
      itemCount: jblists.length,
      separatorBuilder: (context, index) => SizedBox(height: 25),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 198,
          decoration: BoxDecoration(
            color: Color(0xffD9D9D9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/whojob.svg',
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jblists[index].jobGiver,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            jblists[index].posted,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff797B7B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/3dodot.svg',
                      width: 25,
                      height: 25,
                    ),
                  ],
                ),
                // You can add more rows/info here as needed
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(128),
      child: AppBar(
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Text(
            'Job listings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xff00426C)
            ),
          ),
        ),
        backgroundColor: Color(0xffD9D9D9),
        leading: SvgPicture.asset('assets/icons/Logo.svg'),
        actions: [
          GestureDetector(
            onTap: () {

            },
            child: Container(
              margin: EdgeInsets.only(right: 40, top: 25),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle
              ),
              child: SvgPicture.asset(
                'assets/icons/searchicon.svg',
                width: 20,
                height: 20
              ),
            ),
          ),
          GestureDetector(
            onTap: () {

            },
            child: Container(
              margin: EdgeInsets.only(right: 20, top: 25),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle
              ),
              child: SvgPicture.asset(
                'assets/icons/chaticon.svg',
                width: 20,
                height: 20
              ),
            ),
          )
        ],
      ),
    );
  }
}