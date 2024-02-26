import 'package:event_booking/pages/home/widget/search_screen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({required Key key})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Image(
          height: 40,
          image: AssetImage('assets/images/splashscreen.png'),
          fit: BoxFit.cover,
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
              }),
          // icon:badges.Badge(
          //   animationType: BadgeAnimationType.fade,
          //   badgeContent: const Text('3'),
          //   child: IconButton(
          //       onPressed: () {}, icon: const Icon(Icons.notifications)),
          // ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
        ],
      ),
    );
  }
}
