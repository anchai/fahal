import 'package:basicfultter/model/user_Model.dart';
import 'package:basicfultter/utility/myconstant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListShop extends StatefulWidget {
  const OrderListShop({Key? key}) : super(key: key);

  @override
  State<OrderListShop> createState() => _OrderListShopState();
}

class _OrderListShopState extends State<OrderListShop> {
  late UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('แสดงรายการอาหาร ที่ลูกค้าสั่ง');
  }
}
