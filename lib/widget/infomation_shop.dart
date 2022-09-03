import 'package:basicfultter/screen/add_info_shop.dart';
import 'package:basicfultter/utility/my_Syle.dart';
import 'package:flutter/material.dart';

class InformationShop extends StatefulWidget {
  const InformationShop({Key? key}) : super(key: key);

  @override
  State<InformationShop> createState() => _InformationShopState();
}

class _InformationShopState extends State<InformationShop> {
  void routeToAddInfo() {
    print('rountToAddInfo Work');
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => AddInfoShop(),
    );
    Navigator.push(context, materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MySyle().titleCenter(context, 'ยังไม่มีข้อมูล กรุณาเพิ่มข้อมูลด้วยค่ะ'),
        addAndEditButton(),
      ],
    );
  }

  Row addAndEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                  child: Icon(Icons.edit),
                  onPressed: () {
                    routeToAddInfo();
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
