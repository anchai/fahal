import 'dart:convert';

import 'package:basicfultter/model/user_Model.dart';
import 'package:basicfultter/screen/add_info_shop.dart';
import 'package:basicfultter/utility/my_Syle.dart';
import 'package:basicfultter/utility/myconstant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationShop extends StatefulWidget {
  const InformationShop({Key? key}) : super(key: key);

  @override
  State<InformationShop> createState() => _InformationShopState();
}

class _InformationShopState extends State<InformationShop> {
  var userModel;

  @override
  void initState() {
    super.initState();
    readDataUser();
  }

  Future<Null> readDataUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('id');

    String url =
        '${Myconstant().domain}/fahal/getUserWhereid.php?isAdd=true&id=$id';

    await Dio().get(url).then((value) {
      print('valut = $value');
      var result = json.decode(value.data);

      print('result = $result');

      for (var map in result) {
        setState(() {
          userModel = UserModel.fromJson(map);
        });
        print('nameShop = ${userModel.nameShop}');
      }
    });
  }

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
        userModel == null
            ? MySyle().showProgress()
            : userModel.nameShop.isEmpty
                ? showNoData(context)
                : shoListinfoShop(),
        addAndEditButton(),
      ],
    );
  }

  Widget shoListinfoShop() => Column(
        children: <Widget>[
          MySyle().ShowTitle2('รายละเอียดร้าน ${userModel.nameShop}'),
          showImage(),
          MySyle().mysizedbox(),
          Row(
            children: <Widget>[
              MySyle().ShowTitle2('ที่อยู่ของร้าน'),
            ],
          ),
          Row(
            children: <Widget>[
              Text(userModel.address),
            ],
          ),
          showMap(),
        ],
      );

  Container showImage() {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Image.network(
        userModel.urlPicture,
        scale: 1.0,
      ),
    );
  }

  Set<Marker> shopMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('shopID'),
        position: LatLng(
          double.parse(userModel.lat),
          double.parse(userModel.lng),
        ),
        infoWindow: InfoWindow(
            title: 'ตำแหน่งร้าน',
            snippet: 'ละติจูด = ${userModel.lat}, ลองติจูด =${userModel.lng}'),
      ),
    ].toSet();
  }

  Expanded showMap() {
    MySyle().showProgress();
    MySyle().showProgress();
    MySyle().showProgress();
    double lat = double.parse(userModel.lat);
    double lng = double.parse(userModel.lng);

    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(target: latLng, zoom: 16.0);

    return Expanded(
      // padding: EdgeInsets.all(10.0),
      //height: 300.0,
      child: GoogleMap(
        initialCameraPosition: position,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: shopMarker(),
      ),
    );
  }

  Widget showNoData(BuildContext context) =>
      MySyle().titleCenter(context, 'ยังไม่มีข้อมูล กรุณาเพิ่มข้อมูลด้วยค่ะ');

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
