import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/chat_screen.dart';
import 'package:we_chat_app/pages/contacts_screen.dart';
import 'package:we_chat_app/pages/moments_screen.dart';
import 'package:we_chat_app/pages/profile_screen.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';
import 'package:we_chat_app/resources/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const MomentsScreen(),
    const ChatScreen(),
    const ContactsScreen(),
    const ProfileScreen(),
    const ProfileScreen(),
  ];

  Color activeColor = PRIMARY_COLOR;
  Color inActiveColor = GREY_COLOR;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.14,
              child: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
            ),
            Container(
              padding:const EdgeInsets.only(top: MARGIN_LEVEL_1_LAST),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  InkWell(onTap: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                    child: Column(
                      children: [
                        Image.asset(_currentIndex == 0 ? MOMENT_BOTTOM_BAR_ACTIVE_ICON : MOMENT_BOTTOM_BAR_INACTIVE_ICON),
                        const SizedBox(height: MARGIN_LEVEL_1_7,),
                        Text("Moments", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color: _currentIndex == 0 ? activeColor : inActiveColor),)
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(_currentIndex == 1 ? CHAT_BOTTOM_BAR_ACTIVE_ICON : CHAT_BOTTOM_BAR_INACTIVE_ICON),
                        const SizedBox(height: MARGIN_LEVEL_1_7,),
                        Text("Chats",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color: _currentIndex == 1 ? activeColor : inActiveColor))
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(_currentIndex == 2 ? CONTACTS_BOTTOM_BAR_ACTIVE_ICON : CONTACTS_BOTTOM_BAR_INACTIVE_ICON),
                        const SizedBox(height: MARGIN_LEVEL_1_7,),
                        Text("Contacts", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color: _currentIndex == 2 ? activeColor : inActiveColor))
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(_currentIndex == 3 ? PROFILE_BOTTOM_BAR_ACTIVE_ICON : PROFILE_BOTTOM_BAR_INACTIVE_ICON),
                        const SizedBox(height: MARGIN_LEVEL_1_7,),
                        Text("Me", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color: _currentIndex == 3 ? activeColor : inActiveColor))
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 4;
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(_currentIndex == 4 ? SETTING_BOTTOM_BAR_ACTIVE_ICON : SETTING_BOTTOM_BAR_INACTIVE_ICON),
                        const SizedBox(height: MARGIN_LEVEL_1_7,),
                        Text("Setting", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color: _currentIndex == 4 ? activeColor : inActiveColor))
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            )
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   selectedItemColor: PRIMARY_COLOR,
        //   unselectedItemColor: GREY_COLOR,
        //   showSelectedLabels: true,
        //   showUnselectedLabels: true,
        //   currentIndex: _currentIndex,
        //   onTap: (int index) {
        //     setState(() {
        //       _currentIndex = index;
        //     });
        //   },
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.search),
        //       label: 'Search',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.favorite),
        //       label: 'Favorites',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.shopping_cart),
        //       label: 'Cart',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Profile',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

