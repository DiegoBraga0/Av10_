import 'package:flutter/material.dart';
import 'package:flutter_crud_operations/views/about.dart';
import 'package:flutter_crud_operations/views/list.dart';
import 'package:flutter_crud_operations/views/add.dart';
import 'package:flutter_crud_operations/homepage.dart';
import 'colors.dart';

class Drawal extends StatelessWidget {
  const Drawal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 80),
      child: Drawer(
        backgroundColor: MyColors.drawalBackground,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text(
                'Home Page',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomePage(title: 'Home',)));
              },
            ),
            Divider(
              color: MyColors.drawalDivider,
              height: 2,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AddAnime()));
              },
            ),
            Divider(
              color: MyColors.drawalDivider,
              height: 2,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'List',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AnimeList()));
              },
            ),
            Divider(
              color: MyColors.drawalDivider,
              height: 2,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'About',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => About(title: 'About',)));
              },
            ),
            Divider(
              color: MyColors.drawalDivider,
              height: 2,
              thickness: 2,
            ),
            
          ],
        ),
      ),
    );
  }
}
