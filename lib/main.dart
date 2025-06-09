import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pt_best/pages/jobList.dart';
import 'package:pt_best/pages/login.dart';
import 'package:pt_best/pages/mainEntry.dart';
import 'package:pt_best/pages/register.dart';
import 'package:pt_best/pages/skillDev.dart';
import 'package:pt_best/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xffAFAFAF),
        chipTheme: ChipThemeData(iconTheme: IconThemeData(), showCheckmark: false)
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainEntryPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _current = 0;
  // Keys now use the PUBLIC State class names
  final GlobalKey<HistoryState> _historyKey = GlobalKey<HistoryState>();
  final GlobalKey<jobListState> _jobListKey = GlobalKey<jobListState>();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      jobList(key: _jobListKey, onJobApplied: _onJobAction),
      const skillPage(),
      History(key: _historyKey, onJobResigned: _onJobAction),
    ];
  }

  void _onJobAction({bool switchToOrders = false}) {
    // These calls will now work because the methods and classes are public.
    _historyKey.currentState?.fetchOrders();
    _jobListKey.currentState?.fetchData();

    if (switchToOrders) {
      setState(() {
        _current = 2; // Switch to the Orders tab
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _current, children: _pages),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xff868686),
          borderRadius: BorderRadius.circular(30),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: _current,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color(0xffC6C9CF),
          onTap: (index) => setState(() => _current = index),
          items: [
            BottomNavigationBarItem(
              icon: _buildIcon('assets/icons/history.svg', 0),
              label: 'Search Jobs',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon('assets/icons/certification.svg', 1),
              label: 'Skills',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon('assets/icons/orders.svg', 2),
              label: 'Orders',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(String asset, int index) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _current == index ? Colors.black : const Color(0xffC6C9CF),
      ),
      child: SvgPicture.asset(
        asset,
        colorFilter: ColorFilter.mode(
          _current == index ? Colors.white : Colors.black,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}