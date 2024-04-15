import 'package:flutter/material.dart';
import 'package:todoappsqlite/helpers/drawer_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           backgroundColor: Colors.white12,
         foregroundColor: Colors.blue,
        title: Center(child: Text("TodoApp")),
      ),
      drawer: DrawerNavigation(),
    );
  }
}
