import 'package:basicfultter/main.dart';
import 'package:basicfultter/screen/main_rider.dart';
import 'package:basicfultter/screen/main_shop.dart';
import 'package:basicfultter/screen/main_user.dart';
import 'package:basicfultter/utility/my_Syle.dart';
import 'package:basicfultter/utility/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:basicfultter/screen/signIn.dart';
import 'package:basicfultter/screen/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    checkPreference();
  }

  Future<Null> checkPreference() async {
    //เช็คหน้า
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var chooseType = preferences.getString('ChooseType');
      if (chooseType != null && chooseType.isNotEmpty) {
        if (chooseType == 'User') {
          rountToService(MainUser());
        } else if (chooseType == 'Shop') {
          rountToService(MainShop());
        } else if (chooseType == 'Rider') {
          rountToService(MainRider());
        } else {
          normalDialog(context, 'Error User Type');
        }
      }
    } catch (e) {}
  }

  void rountToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
            children: <Widget>[ShowHeardDrawer(), signInMenu(), signUpMenu()]),
      );

  ListTile signInMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Sing IN'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, route);
      },
    );
  }

  ListTile signUpMenu() {
    return ListTile(
        leading: Icon(Icons.android),
        title: Text('Sing UP'),
        onTap: () {
          Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => SignUp());
          Navigator.push(context, route);
        });
  }

  UserAccountsDrawerHeader ShowHeardDrawer() {
    return UserAccountsDrawerHeader(
      decoration: MySyle().myBoxDecoration('guset.jpg'),
      currentAccountPicture: MySyle().ShowLogo(),
      accountName: Text('Guest'),
      accountEmail: Text('Pleas Login'),
    );
  }
}
