import 'package:flutter/material.dart';
import 'package:synced_admin_portal/screens/department_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _bodyWidget = DepartmentScreen();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Departments'),
                onTap: () {
                  setState(() {
                    _bodyWidget = DepartmentScreen();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Colleges'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Premium Colleges'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Area of Interest'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Courses'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Users'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        body: _bodyWidget,
      ),
    );
  }
}
