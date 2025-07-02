import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:work_order_app/core/router/router.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AutoTabsScaffold(
        routes:  [
          HomeRoute(),
          WorkOrderListRoute(),
          TechnicianListRoute(),
          ProfileRoute()
        ],
        backgroundColor: Colors.white,
        transitionBuilder: (context, child, animation) => FadeTransition(
          opacity: animation,
          // the passed child is technically our animated selected-tab page
          child: child,
        ),

        bottomNavigationBuilder: (_, tabsRouter) {
          // obtain the scoped TabsRouter controller using context
          // final tabsRouter = AutoTabsRouter.of(context);
          var selectedIndex = tabsRouter.activeIndex;

          return BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: (selectedIndex == 0) ? Colors.blueAccent : Colors.grey,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list, color: (selectedIndex == 1) ? Colors.blueAccent : Colors.grey,),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group, color: (selectedIndex == 2) ? Colors.blueAccent : Colors.grey,),
                label: 'Groups',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: (selectedIndex == 3) ? Colors.blueAccent : Colors.grey,),
                label: 'Profile',
              ),
            ],
            currentIndex: tabsRouter.activeIndex,
            selectedItemColor: Colors.blue,
            onTap: (index){
              tabsRouter.setActiveIndex(index);
            },
            type: BottomNavigationBarType.fixed, // Tetapkan tipe ke fixed
            showSelectedLabels: true, // Pastikan label yang dipilih terlihat
            showUnselectedLabels: true, // Pastikan label yang tidak dipilih terlihat
          );
        },
      ),
    );
  }
}

