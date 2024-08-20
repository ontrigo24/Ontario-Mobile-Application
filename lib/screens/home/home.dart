import 'package:flutter/material.dart';
import 'package:ontrigo/API/models/user_data.dart';
import 'package:ontrigo/API/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    UserData? user = Provider.of<UserProvider>(context).userData;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Welcome to the Home Screen, ${user?.data?.firstName}'),
      ),
    );
  }
}
