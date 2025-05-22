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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/truck.svg',
                          width: 40,
                          height: 32,
                        ),
                        Text(
                          'Delivery',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pickup:',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff343738),
                                ),
                              ),
                              Text(
                                jblists[index].address,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dropoff:',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff343738),
                              ),
                            ),
                            Text(
                              jblists[index].dropAt,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 138),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Complete by:',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff343738),
                                ),
                              ),
                              Text(
                                jblists[index].deadline,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 250),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'offer:',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff595B5C)
                          ),
                        ),
                        Text(
                          jblists[index].priceOffer,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff595B5C)
                          ),
                        ),
                        SafeArea(
                          child: Container(
                            width: 80,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: Color(0xff35883B),
                            ),
                            child: Center(
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
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