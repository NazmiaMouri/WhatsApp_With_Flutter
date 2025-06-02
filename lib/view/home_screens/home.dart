import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_app/constants/colors.dart';
import 'package:whats_app/view/home_screens/tab_views/chats.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 3);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getIconColor(int index) {
    return _selectedIndex == index ? Colors.blue : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('Chats Page')),
          Center(child: Text('Calls Page')),
          Center(child: Text('Settings Page')),
          Center(child: ChatList()),
          Center(child: Text('Settings Page')),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicatorColor: Colors.transparent,
        labelColor: AppColors.blue,
        tabs: [
          Tab(
              icon: SvgPicture.asset(
                'assets/icons/Icone=Status.svg',
                semanticsLabel: 'Logo',
                height: 30.0,
                width: 30.0,
                color: _getIconColor(0),
              ),
              text: 'Status'),
          Tab(
              icon: SvgPicture.asset(
                'assets/icons/Icone=Phone.svg',
                semanticsLabel: 'Logo',
                height: 30.0,
                width: 30.0,
                color: _getIconColor(1),
              ),
              text: 'Calls'),
          Tab(
              icon: SvgPicture.asset(
                'assets/icons/Icone=Camera outline.svg',
                semanticsLabel: 'Logo',
                height: 30.0,
                width: 30.0,
                color: _getIconColor(2),
              ),
              text: 'Camera'),
          Tab(
              icon: SvgPicture.asset(
                'assets/icons/Icone=Chats outline.svg',
                semanticsLabel: 'Logo',
                height: 30.0,
                width: 30.0,
                color: _getIconColor(3),
              ),
              text: 'Chats'),
          Tab(
              icon: SvgPicture.asset(
                'assets/icons/Icone=Settings.svg',
                semanticsLabel: 'Logo',
                height: 30.0,
                width: 30.0,
                color: _getIconColor(4),
              ),
              text: 'Settings'),
        ],
      ),
    );
  }
}
