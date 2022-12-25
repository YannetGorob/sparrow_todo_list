import 'package:flutter/material.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/feature/presentation/pages/add_group_screen.dart';
import 'package:sparrow_todo_list/feature/presentation/widgets/group_list_widget.dart';
import 'package:sparrow_todo_list/feature/presentation/widgets/header_drawer_widget.dart';

class GroupHomeScreen extends StatefulWidget {
  final String name;

  const GroupHomeScreen({
    super.key,
    required this.name,
  });

  @override
  State<GroupHomeScreen> createState() => _GroupHomeScreenState();
}

class _GroupHomeScreenState extends State<GroupHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var res = WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: Drawer(
            child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                HeaderDrawerWidget(
                  username: widget.name,
                ),
                DrawerListWidget(context, widget.name),
              ],
            ),
          ),
        )),
        appBar: AppBar(
            backgroundColor: AppColors.mainBacgroundColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Text(widget.name),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: AppColors.helpTextColor,
                  ),
                  onPressed: (() {
                    Scaffold.of(context).openDrawer();
                  }),
                );
              },
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.search,
                      color: AppColors.helpTextColor,
                      size: 26.0,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.more_vert,
                      color: AppColors.helpTextColor,
                    ),
                  )),
            ]),
        body: GroupListWidget(
          name: widget.name,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.mainColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddGroupScreen()));
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );

    return res;
  }
}

Widget DrawerListWidget(BuildContext context, String name) {
  return Column(
    children: [
      GestureDetector(
          onTap: (() {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => GroupHomeScreen(
                          name: name,
                        )));
          }),
          child: ListTile(
            title: Text(
              'Home',
              style: TextStyle(fontSize: 20),
            ),
          )),
    ],
  );
}
