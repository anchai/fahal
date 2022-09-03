import 'package:basicfultter/main.dart';
import 'package:basicfultter/utility/my_Syle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddInfoShop extends StatefulWidget {
  const AddInfoShop({Key? key}) : super(key: key);

  @override
  State<AddInfoShop> createState() => _AddInfoShopState();
}

class _AddInfoShopState extends State<AddInfoShop> {
  late Position userLocation;
  late GoogleMapController mapController;

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
            showMap(),
            MySyle().mysizedbox(),
            saveButton(),
          ],
        ),
      ),
    );
  }

  Container showMap() {
    LatLng latLng = LatLng(18.316395416475686, 99.39645163180481);
    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 16.0);
    return Container(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
      ),
    );
  }

  Widget saveButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        color: MySyle().primaryColor,
        onPressed: () {},
        icon: Icon(Icons.save),
        label: Text('Save Infomation'),
      ),
    );
  }

  Row GroupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.add_a_photo,
              size: 36.0,
            ),
            onPressed: () {}),
        Container(
          width: 250.0,
          child: Image.asset('images/myimage.png'),
        ),
        IconButton(
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36.0,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
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
