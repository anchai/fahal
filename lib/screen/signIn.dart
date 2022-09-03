import 'dart:convert';

import 'package:basicfultter/model/user_Model.dart';
import 'package:basicfultter/screen/main_rider.dart';
import 'package:basicfultter/screen/main_shop.dart';
import 'package:basicfultter/screen/main_user.dart';
import 'package:basicfultter/utility/my_Syle.dart';
import 'package:basicfultter/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
//field
  var user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, MySyle().primaryColor],
            center: Alignment(0, -0.3),
            radius: 1.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MySyle().ShowLogo(),
                MySyle().ShowTitle('Fahal Food'),
                MySyle().mysizedbox(),
                UserForm(),
                MySyle().mysizedbox(),
                PasswordForm(),
                MySyle().mysizedbox(),
                LoginButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget LoginButton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: MySyle().darkColor,
          onPressed: () {
            if (user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'มีช่องว่างกรุณา กรอกให้ครบ');
            } else {
              checkAuthen();
            }
          },
          child: Text(
            'login',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> checkAuthen() async {
    String url =
        'http://10.0.189.216/fahal/getUserWhereUser.php?isAdd=true&User=$user';
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('result = $result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password == userModel.password) {
          var chooseType = userModel.chooseType;
          if (chooseType == 'User') {
            routeTuService(MainUser(), userModel);
          } else if (chooseType == 'Shop') {
            routeTuService(MainShop(), userModel);
          } else if (chooseType == 'Rider') {
            routeTuService(MainRider(), userModel);
          } else {
            normalDialog(context, 'Error');
          }
        } else if (result == '') {
          normalDialog(context, 'Password ผิด กรุณาลองใหม่');
        }
      }
    } catch (e) {}
  }

//จำค่า login
  Future<Null> routeTuService(Widget myWidget, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('ChooseType', userModel.chooseType);
    preferences.setString('Name', userModel.name);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget UserForm() => Container(
        width: 250.0,
        child: TextField(
            onChanged: (value) => user = value..trim(),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
                color: MySyle().darkColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MySyle().darkColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MySyle().primaryColor),
              ),
            )),
      );

  Widget PasswordForm() => Container(
        width: 250.0,
        child: TextField(
            onChanged: (value) => password = value.trim(),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: MySyle().darkColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MySyle().darkColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MySyle().primaryColor),
              ),
            )),
      );
}
