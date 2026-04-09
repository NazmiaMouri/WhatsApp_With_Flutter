import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_app/base_screen.dart';
import 'package:whats_app/constants/colors.dart';
import 'package:whats_app/view/home_screens/tab_views/call_list.dart';
import 'package:whats_app/view/home_screens/tab_views/chats.dart';
import 'package:whats_app/view/home_screens/tab_views/status.dart';

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
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
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
    print({index, _selectedIndex});
    return _selectedIndex == index ? Colors.blue : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: BaseScreen(child: ChatList())),
          Center(child: BaseScreen(child: Status())),
          Center(child: Text('Settings Page')),
          Center(child:  BaseScreen(child: CallList())),
        ],
      ),
      bottomNavigationBar: TabBar(
        padding: EdgeInsets.zero,
        controller: _tabController,
        indicatorColor: Colors.transparent,
        labelColor: AppColors.blue,
        labelPadding: EdgeInsets.zero,
        tabs: [
          Tab(
              icon: SvgPicture.asset(
                'assets/icons/Icone=Chats outline.svg',
                semanticsLabel: 'Chats',
               
                color: _getIconColor(0),
              ),
              text: 'Chats'),
          Tab(
              icon: SvgPicture.asset(
                'assets/icons/Icone=Status.svg',
                semanticsLabel: 'Status',
               
                color: _getIconColor(1),
              ),
              text: 'Status'),
          Tab(
              icon: Icon(
                Icons.groups_3_outlined,
                color: _getIconColor(2),
              ),
              text: 'Communities'),
          Tab(
              icon: SvgPicture.asset(
                'assets/icons/Icone=Phone.svg',
                semanticsLabel: 'Calls',
               
                color: _getIconColor(3),
              ),
              text: 'Calls'),
        ],
      ),
    );
  }
}
