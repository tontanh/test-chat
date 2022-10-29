import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:test1/chat/http.chat.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
              child: TextField(
                
                controller: text1,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
              child: TextField(
                controller: text2,
                decoration: InputDecoration(
                   contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
             SizedBox(height: 10),
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () async {
                
                 await ChatHttp().login(name: text1.text,pass: text2.text,context: context,);
               
                
                },
                child: Text(
                  "login",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        )),
      ),
    );
  }
}
