import 'package:basicfultter/main.dart';
import 'package:basicfultter/utility/my_Syle.dart';
import 'package:basicfultter/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var chooseType, name, user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          MyLogo(),
          MySyle().mysizedbox(),
          shoAppName(),
          MySyle().mysizedbox(),
          nameForm(),
          MySyle().mysizedbox(),
          UserForm(),
          MySyle().mysizedbox(),
          passwordForm(),
          MySyle().mysizedbox(),
          MySyle().Showtype('ชนิดของสมาชิก'),
          MySyle().mysizedbox(),
          userradio(),
          shopradio(),
          riderradio(),
          MySyle().mysizedbox(),
          registerButton(),
        ],
      ),
    );
  }

  Widget registerButton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: MySyle().darkColor,
          onPressed: () {
            print(
                'name = $name, user = $user, password = $password , chooseType = $chooseType');
            if (name == null ||
                name.isEmpty ||
                user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              print('Have Space');
              normalDialog(context, 'มีช่องว่าง ค่ะ กรุณากรอกทุกช่องค่ะ');
            } else if (chooseType == null) {
              normalDialog(context, 'โปรดเลือกชนิดผู้สมัค');
            } else {
              checkUser();
            }
          },
          child: Text(
            'Register',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> checkUser() async {
    String url =
        'http://10.0.189.216/fahal/getUserWhereUser.php?isAdd=true&User=$user';
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        registerThread();
      } else {
        normalDialog(context,
            'user นี้ $user มีคนอื่นใช้ไปแล้ว กรุณาเปลี่ยน  User ใหม่');
      }
    } catch (e) {}
  }

  Future<Null> registerThread() async {
    String url =
        'http://10.0.189.216/fahal/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&ChooseType=$chooseType';
    try {
      Response response = await Dio().get(url);
      print('res = $response');
      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'ไม่สามารถ สมัคได้ กรุณาลองใหม่ค่ะ');
      }
    } catch (e) {}
  }

  Widget userradio() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                  value: 'User',
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value;
                    });
                  },
                ),
                Text(
                  'ผู้สั่งอาหาร',
                  style: TextStyle(color: MySyle().darkColor),
                )
              ],
            ),
          ),
        ],
      );

  Widget shopradio() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                  value: 'Shop',
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value;
                    });
                  },
                ),
                Text(
                  'เจ้าของร้านอาหาร',
                  style: TextStyle(color: MySyle().darkColor),
                )
              ],
            ),
          ),
        ],
      );

  Widget riderradio() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                  value: 'Rider',
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value;
                    });
                  },
                ),
                Text(
                  'ผู้ส่งอาหาร',
                  style: TextStyle(color: MySyle().darkColor),
                )
              ],
            ),
          ),
        ],
      );

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
                onChanged: (value) => name = value.trim(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.face,
                    color: MySyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MySyle().darkColor),
                  labelText: 'Name :',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MySyle().darkColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MySyle().primaryColor),
                  ),
                )),
          ),
        ],
      );

  Widget UserForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
                onChanged: (value) => user = value.trim(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.account_box,
                    color: MySyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MySyle().darkColor),
                  labelText: 'User :',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MySyle().darkColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MySyle().primaryColor),
                  ),
                )),
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
                onChanged: (value) => password = value.trim(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.account_box,
                    color: MySyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MySyle().darkColor),
                  labelText: 'Password :',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MySyle().darkColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MySyle().primaryColor),
                  ),
                )),
          ),
        ],
      );

  Row shoAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MySyle().ShowTitle('Fahal Food'),
      ],
    );
  }

  Widget MyLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MySyle().ShowLogo(),
        ],
      );
}
