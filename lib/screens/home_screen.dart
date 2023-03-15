import 'package:chatter_app/pages/calls_page.dart';
import 'package:chatter_app/pages/contacts_page.dart';
import 'package:chatter_app/pages/messages_page.dart';
import 'package:chatter_app/pages/notifications_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatter_app/theme.dart';
import 'package:chatter_app/widgets/widgets.dart';
import 'package:chatter_app/helpers.dart';

import '../widgets/glowing_action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier("Messages");

  final List pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage()
  ];
  final List<String> pagesTitles = [
    "Messages",
    "Notifications",
    "Calls",
    "Contacts"
  ];

  void _onNavigationItemSelected(int index) {
    pageIndex.value = index;
    title.value = pagesTitles[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (context, String value, _) {
            return Text(
              value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textFaded),
            );
          },
        ),
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: () {},
          ),
        ),
        leadingWidth: 54,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Avatar.small(
              url: Helpers.randomPictureUrl(),
            ),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar:
          _BottomNavigationBar(onItemSelected: _onNavigationItemSelected),

      // BottomNavigationBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   items: <BottomNavigationBarItem>[
      //     //messages
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         CupertinoIcons.bubble_left_bubble_right_fill,
      //       ),
      //       label: "Messages",
      //       backgroundColor: Colors.transparent,
      //     ),
      //     //notifications
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         CupertinoIcons.bell_solid,
      //       ),
      //       label: "Contacts",
      //       backgroundColor: Colors.transparent,
      //     ),

      //     //calls
      //     BottomNavigationBarItem(
      //       icon: Icon(CupertinoIcons.phone_fill),
      //       label: "Calls",
      //       backgroundColor: Colors.transparent,
      //     ),
      //     //contacts
      //     BottomNavigationBarItem(
      //       icon: Icon(CupertinoIcons.person_2_fill),
      //       label: "Contacts",
      //       backgroundColor: Colors.transparent,
      //     ),
      //   ],
      //   currentIndex: pageIndex.value,
      //   onTap: onItemSelected,
      //   selectedItemColor: AppColors.secondary,
      //   unselectedItemColor: AppColors.textFaded,
      //   selectedFontSize: 16,
      //   unselectedFontSize: 16,
      //   selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      // ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  _BottomNavigationBar({required this.onItemSelected, super.key});
  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;
  void _handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(0),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(top: 15, bottom: 22, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //messsages
              _NavigationBarItem(
                onTap: _handleItemSelected,
                isSelected: (selectedIndex == 0),
                index: 0,
                label: "Messages",
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
              ),

              //notifications
              _NavigationBarItem(
                onTap: _handleItemSelected,
                isSelected: (selectedIndex == 1),
                index: 1,
                label: "Notifications",
                icon: CupertinoIcons.bell_solid,
              ),

              //glowing_action_button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:08.0),
                child: GlowingActionButton(
                  color: AppColors.secondary,
                  icon: CupertinoIcons.add,
                  onPressed: (){},
                ),
              ),

              //calls
              _NavigationBarItem(
                  onTap: _handleItemSelected,
                  isSelected: (selectedIndex == 2),
                  index: 2,
                  label: "Calls",
                  icon: CupertinoIcons.phone_fill),

              //Contacts
              _NavigationBarItem(
                  onTap: _handleItemSelected,
                  isSelected: (selectedIndex == 3),
                  index: 3,
                  label: "Contacts",
                  icon: CupertinoIcons.person_2_fill),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {this.isSelected = false,
      required this.onTap,
      required this.label,
      required this.icon,
      required this.index,
      super.key});

  final String label;
  final IconData icon;
  final int index;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Expanded(
        child: SizedBox(
          width: 60,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? AppColors.secondary : AppColors.iconLight,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                label,
                style: isSelected
                    ? TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary)
                    : TextStyle(
                        fontSize: 10,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
