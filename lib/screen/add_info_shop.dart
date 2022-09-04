import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:basicfultter/main.dart';
import 'package:basicfultter/utility/my_Syle.dart';
import 'package:basicfultter/utility/myconstant.dart';
import 'package:basicfultter/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddInfoShop extends StatefulWidget {
  const AddInfoShop({Key? key}) : super(key: key);

  @override
  State<AddInfoShop> createState() => _AddInfoShopState();
}

class _AddInfoShopState extends State<AddInfoShop> {
  late Position userLocation;
  late GoogleMapController mapController;
  //map
  var lat, lng;

  //File _image; //เก็บรูป
  final ImagePicker _picker = ImagePicker();
  var _file;

//
  var nameShop, address, phone, urlImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finLatLng();
  }

  Future<Null> finLatLng() async {
    LocationData? locationData = await findLocationData();
    setState(() {
      lat = locationData?.latitude;
      lng = locationData?.longitude;
    });
    print('lat= $lat, lng = $lng');
  }

  Future<LocationData?> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Infomation Shop'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MySyle().mysizedbox(),
            nameForm(),
            MySyle().mysizedbox(),
            addressForm(),
            MySyle().mysizedbox(),
            phoneForm(),
            MySyle().mysizedbox(),
            GroupImage(),
            MySyle().mysizedbox(),
            lat == null ? MySyle().showProgress() : showMap(),
            MySyle().mysizedbox(),
            saveButton(),
          ],
        ),
      ),
    );
  }

  Set<Marker> mymarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('myshop'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
            title: 'ร้านของคุณ Fahal',
            snippet: 'ละติจุูด = $lat, ลองติจูด = $lng'),
      )
    ].toSet();
  }

  Container showMap() {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: mymarker(),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        color: MySyle().primaryColor,
        onPressed: () {
          if (nameShop == null ||
              nameShop.isEmpty ||
              address == null ||
              address.isEmpty ||
              phone == null ||
              phone.isEmpty) {
            normalDialog(context, 'กรุณากรอก ทุกช่อง ค่ะ');
          } else if (_file == null) {
            normalDialog(context, 'กรุณาเลือกรูปภาพ ด้วยต่ะ');
          } else {
            uploadImage();
          }
        },
        icon: Icon(Icons.save),
        label: Text('Save Infomation'),
      ),
    );
  }

  Future<Null> uploadImage() async {
    Random random = Random(); //กำหนดซื่อให้กับรูป
    int i = random.nextInt(100000);
    String nameImage = 'shop$i.jpg';

    String url =
        '${Myconstant().domain}/fahal/saveShop.php'; //กำหนด url เพื่อส่งค่า domain อยู่ในไฟล์ myconstant.dart

    try {
      Map<String, dynamic> map =
          Map(); //กำหนดค่าเพื่อโยนขึ้น database // 'file' คือค่าที่เช็คกับไฟล์php
      map['file'] =
          await MultipartFile.fromFile(_file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) => {
            print('Response ==>> $value'),
            urlImage =
                '${Myconstant().domain}/fahal/Shop/$nameImage', //ที่อยู่ภาพ
            print('urlImage = $urlImage'),
            editUserShop(),
          });
    } catch (e) {}
  }

  Future<Null> editUserShop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    String url =
        'http://10.0.189.216/fahal/editUserWhereId.php?isAdd=true&id=$id&NameShop=$nameShop&Address=$address&Phone=$phone&UrlPicture=$urlImage&Lat=$lat&Lng=$lng';
  }

  Row GroupImage() {
    //show image
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36.0,
          ),
          onPressed: () => chooseImage(ImageSource.camera),
        ),
        Container(
          width: 250.0,
          child: _file == null
              ? Image.asset('images/myimage.png') //imagedefaul
              : Image.file(_file),
        ),
        IconButton(
          icon: Icon(
            Icons.add_a_photo,
            size: 36.0,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      final object = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      setState(() {
        _file = File(object!.path);
      });
    } catch (e) {}
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => nameShop = value.trim(),
              decoration: InputDecoration(
                  labelText: 'ชื่อร้านค้า',
                  prefixIcon: Icon(Icons.account_box),
                  border: OutlineInputBorder()),
            ),
          ),
        ],
      );

  Widget addressForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => address = value.trim(),
              decoration: InputDecoration(
                  labelText: 'ที่อยู่',
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder()),
            ),
          ),
        ],
      );

  Widget phoneForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => phone = value.trim(),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  labelText: 'เบอติดต่อร้านค้า',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder()),
            ),
          ),
        ],
      );
}
