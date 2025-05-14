import 'package:pt_best/models/requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<MixModel> requests = [];

  void _getInitialInfo() {
    requests = MixModel.getMix();
  }

  int myIndex = 2;

  @override  
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(// optional for better contrast
      bottomNavigationBar: navigationBar(),
      body: ListView(
        children: [
          searchBox(),
          SizedBox(height: 15),
          selectBar(),
          SizedBox(height: 15),
          requestList()
        ],
      ),
    );
  }

  Column requestList() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 170, 
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 30),
                    width: 315,
                    decoration: BoxDecoration(
                      color: Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Color(0xffFFFFFF),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/box.svg',
                                  width: 18,
                                  height: 18,
                                )
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              requests[index].orderName, 
                              style: const TextStyle(
                                color: Colors.black, 
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(width: 70),
                            Container(
                              width: 105,
                              height: 30,
                              decoration: BoxDecoration(
                                color: requests[index].statusColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  requests[index].status,
                                  style: TextStyle(
                                    color: Color(0xff222526),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20),
                            Text(
                              requests[index].price,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              )
                            ),
                            SizedBox(width: 185),
                            SvgPicture.asset('assets/icons/info.svg')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20), 
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Posted by:',
                                  style: TextStyle(
                                    color: Color(0xff595B5C),
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  requests[index].soliciter,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 150),
                            Column(
                              children: [
                                Text(
                                  'Expected on:',
                                  style: TextStyle(
                                    color: Color(0xff595B5C),
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  requests[index].date,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '(in ' + requests[index].duration + ')',
                                  style: TextStyle(
                                    fontSize: 10, 
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ]
                    )
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 15,),
                itemCount: requests.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
              ),
            ),
          ],
        );
  }

  Container selectBar() {
    return Container(
          margin: const EdgeInsets.only(left: 23, right: 23),
          alignment: Alignment.center,
          height: 33,
          width: 362,
          decoration: BoxDecoration(
            color: Color(0xffC7C9CF),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Requests'),
              Text('Assigned'),
              Text('Completed'),
            ],
          )
        );
  }

  Widget searchBox() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        height: 206, 
        width: 362, 
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.black, 
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 56, 
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff343738),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/profile.svg',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
                Container(
                  width: 56, 
                  height: 56, 
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff343738),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/notifications.svg',
                      width: 25, 
                      height: 25, 
                    ),
                  ),
                ),
              ]
            ),
            Padding(
              padding: const EdgeInsets.only(right: 100, top: 10),
              child: Text(
                'Search Orders',
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 30,
                  fontWeight: FontWeight.w100
                ),
              ),
            ),
            Padding( 
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: 320,
                height: 45,
                child: Container(
                  padding: EdgeInsets.only(right:18),
                  decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true, 
                      fillColor: Color(0xffD9D9D9),
                      contentPadding: EdgeInsets.all(15),
                      hintText: 'Search for works',
                      hintStyle: TextStyle(
                        color: Color(0xffADADAD), 
                        fontSize: 14
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12), 
                        child: SvgPicture.asset('assets/icons/search.svg'),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none
                      ),
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

  Padding navigationBar() {
    return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xff868686),
        borderRadius: BorderRadius.circular(30),
      ),
      child: BottomNavigationBar(
        currentIndex: myIndex,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xffC6C9CF),
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: 40, 
              height: 40, 
              decoration: BoxDecoration(
                shape: BoxShape.circle, 
                color: myIndex == 0 ? Colors.black : Color(0xffC6C9CF), 
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/history.svg',
                  width: 24, 
                  height: 24, 
                  color: myIndex == 0 ? Colors.white : Colors.black,
                ),
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 40, 
              height: 40, 
              decoration: BoxDecoration(
                shape: BoxShape.circle, 
                color: myIndex == 1 ? Colors.black : Color(0xffC6C9CF), 
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/certification.svg',
                  width: 24, 
                  height: 24, 
                  color: myIndex == 1 ? Colors.white : Colors.black,
                ),
              ),
            ),
            label: 'Certificates',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 40, 
              height: 40, 
              decoration: BoxDecoration(
                shape: BoxShape.circle, 
                color: myIndex == 2 ? Colors.black : Color(0xffC6C9CF), 
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/orders.svg',
                  width: 24, 
                  height: 24, 
                  color: myIndex == 2 ? Colors.white : Colors.black,
                ),
              ),
            ),
            label: 'Orders',
          ),
        ],
      ),
    ),
  );
  }
}

