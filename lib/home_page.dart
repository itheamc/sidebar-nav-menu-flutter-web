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
          headerBuilder: (duration, value) {
            return Container(
              padding: const EdgeInsets.only(top: 25.0, bottom: 30.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 17.0, right: 15.0),
                    child: Icon(
                      Icons.facebook,
                      size: 36.0,
                    ),
                  ),
                  Flexible(
                    child: Transform.scale(
                      scale: value,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                          "Aarohi Botique".toUpperCase(),
                          style: theme.textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
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
