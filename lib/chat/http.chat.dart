import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/home.dart';
import '../ultils/alertSnackbar.dart';
import '../ultils/state_m.dart';

class ChatHttp {
  ChatHttp();
  final dataControllers = Get.put(dataController());
  var headers = {
    "content-type": "application/json",
    "accept": "application/json",
    "Access-Control_Allow_Origin": "*",
  };
  // get all user
  Future fetchDataAllUsers(String id) async {
    var url = "http://192.168.173.30:5001/api/auth/allusers/$id";
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response?> login({
    String? name,
    pass,
    txt,
    BuildContext? context,
  }) async {
    const String url = 'http://192.168.173.30:5001/api/auth/login';
    Map data = {"username": name, "password": pass};
    Uri uri = Uri.parse(url);
    final response =
        await http.post(uri, body: json.encode(data), headers: headers);
    var info = json.decode(response.body);
    bool status = info['status'];
    var id = info['user']['_id'];
    if (response.statusCode == 200 && status == true) {
      alertSnackbar().showAlert(
          context: context, txt: 'login completed', color: Colors.teal);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', id);
      dataControllers.id = '$id'.obs;
      Get.to(() => Homepage());
    } else {
      alertSnackbar().showAlert(
          context: context, txt: 'user or pass wrong', color: Colors.red);
    }
    return null;
  }
}
