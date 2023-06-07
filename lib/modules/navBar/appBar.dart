import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class NavBarScreen extends StatelessWidget implements PreferredSizeWidget {

  const NavBarScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      //toolbarHeight: 60,
      backgroundColor: Color.fromRGBO(251, 31, 38, 1),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: FittedBox(
          alignment: AlignmentDirectional.centerStart,
          fit: BoxFit.cover,
          child: Image.asset('assets/images/Baiki.png'),
        ),
      ),
      actions: [
        Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.menu),
                color: Colors.white,
              );
            }
        ),
      ],
    );

  }
  @override
  Size get preferredSize => const Size.fromHeight(56);
}
