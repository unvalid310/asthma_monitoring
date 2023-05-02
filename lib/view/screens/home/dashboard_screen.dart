import 'package:asthma_monitor/view/screens/history/history_screen.dart';
import 'package:asthma_monitor/view/screens/home/home_screen.dart';
import 'package:asthma_monitor/view/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  const DashboardScreen({Key key, @required this.pageIndex}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      HomeScreen(),
      ProfileScreen(),
      HistoryScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _barItem(Icons.ballot_outlined, 'Analyze', 0),
            _barItem(Icons.account_circle_outlined, 'Profile', 1),
            _barItem(Icons.history_outlined, 'History', 2),
          ],
          onTap: (int index) {
            _setPage(index);
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: Icon(icon, size: 30),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
