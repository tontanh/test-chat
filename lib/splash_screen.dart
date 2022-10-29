import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/home.dart';
import 'package:test1/login.dart';
import 'package:test1/ultils/state_m.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

enum Page { login, home }

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool pageLoad = false;
  final dataControllers = Get.put(dataController());
  Future getData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = await prefs.getString('id');
    action == null ? pageLoad == false : pageLoad = true;
    dataControllers.id = '$action'.obs;
    return action;
  }

  @override
  Widget build(BuildContext context) {
    // print(pageLoad);
    // return pageLoad? Homepage():LoginPage();
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('errorrrrrrrrr');
            return pageLoad ? Homepage() : LoginPage();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return pageLoad ? Homepage() : LoginPage();
          }
          return Container();
        });
  }
}
