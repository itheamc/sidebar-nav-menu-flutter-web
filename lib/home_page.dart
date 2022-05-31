import 'package:flutter/material.dart';
import 'package:side_navbar/a_sidebar_menu.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _i = -1;

  void _onSelected(int index) {
    setState(() {
      _i = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ASideMenu(
          itemsCount: 5,
          itemsBuilder: (_, duration, value, index) {
            return ASideMenuItem(
              label: [
                "Dashboard",
                "Cart",
                "Products",
                "Notifications",
                "Settings"
              ][index],
              icon: [
                Icons.dashboard,
                Icons.shopping_cart,
                Icons.list,
                Icons.notifications,
                Icons.settings
              ][index],
              animValue: value,
              duration: duration,
              onClick: () => _onSelected(index),
              selected: index == _i,
            );
          },
        ),
        const Expanded(
          child: Center(
            child: Text("Home Page"),
          ),
        )
      ],
    ));
  }
}
