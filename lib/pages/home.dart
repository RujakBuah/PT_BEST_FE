import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int myIndex = 0;

  @override  
  Widget build(BuildContext context) {
    return Scaffold(// optional for better contrast
      bottomNavigationBar: navigationBar(),
      body: ListView(
        children: [
          searchBox(),
          SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

          )
        ],
      ),
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
            Padding(
              padding: const EdgeInsets.only(right: 100),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true, 
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(15),
                      hintText: 'Search for works',
                      hintStyle: TextStyle(
                        color: Color(0xffDDDADA), 
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
            label: 'Recommendation',
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

