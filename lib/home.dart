import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/chat/http.chat.dart';
import 'package:test1/login.dart';
import 'package:test1/ultils/alertSnackbar.dart';
import 'package:test1/ultils/state_m.dart';

import 'chat/chatroom.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    // TODO: implement initState
    FlutterNativeSplash.remove();
    super.initState();
    _postsController = new StreamController();
    loadPosts();
  }

  late StreamController _postsController;
  loadPosts() async {
    ChatHttp().fetchDataAllUsers('${dataControllers.id}').then((res) async {
      _postsController.add(res);
      return res;
    });
  }

  Future<Null> _handleRefresh() async {
    ChatHttp().fetchDataAllUsers('${dataControllers.id}').then((res) async {
      _postsController.add(res);
      alertSnackbar()
          .showAlert(context: context, txt: 'reloaded', color: Colors.teal);
      return null;
    });
  }
  final dataControllers = Get.put(dataController());
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         
          title:Text('id : ${dataControllers.id}',style: TextStyle(fontSize: 16),),
          actions: [
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              final success = await prefs.remove('id');
              Get.offAll(() => LoginPage());
            },
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
          )
        ]),
        body: StreamBuilder(
          stream: _postsController.stream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Column(children: <Widget>[
                Expanded(
                    child: Scrollbar(
                  child: RefreshIndicator(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data[index];
                            var name = data['username'];
                            return GestureDetector(
                              // onTap: () {},
                              child: boxwidget(
                                name: name,
                                onTap: () {
                                  // alertSnackbar().showAlert(
                                  //     context: context,
                                  //     txt: '${data['_id']}',
                                  //     color: Colors.teal);
                                      dataControllers.s_id='${data['_id']}'.obs;
                                      Get.to(()=>ChatRoom(),transition: Transition.rightToLeft);
                                },
                              ),
                            );
                          }),
                      onRefresh: _handleRefresh),
                ))
              ]);
            } else if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: Text('ກະລຸນາລໍຖ້າ Order ຈະມາໄວໆນີ້ ...'),
              );
            } else if (!snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done ||
                snapshot.hasError) {
              return Text('No Posts');
            }
            return Text('ກະລຸນາລໍຖ້າ Order ຈະມາໄວໆນີ້ ...');
          },
        ));
  }

  boxwidget({String? name, VoidCallback? onTap}) {
    return Card(
      shadowColor: Colors.white,
      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.all(5),
                height: 50,
                width: 50,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.png'),
                )),
            SizedBox(width: 10),
            Text('$name')
          ],
        ),
      ),
    );
  }
}
