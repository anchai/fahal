import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:basicfultter/utility/singOut_process.dart';
import 'package:basicfultter/utility/my_Syle.dart';

class MainRider extends StatefulWidget {
  const MainRider({Key? key}) : super(key: key);

  @override
  State<MainRider> createState() => _MainRiderState();
}

class _MainRiderState extends State<MainRider> {
  var nameUser;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('Name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameUser == null ? 'Mian Rider' : '$nameUser login'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => singOutProcess(context),
          ),
        ],
      ),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
          ],
        ),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MySyle().myBoxDecoration('rider.jpg'),
      currentAccountPicture: MySyle().ShowLogo(),
      accountName: Text('Name login'
          //,style: TextStyle(color: MySyle().darkColor),
          ),
      accountEmail: Text('Login'
          //,style: TextStyle(color: MySyle().darkColor),
          ),
    );
  }
}
