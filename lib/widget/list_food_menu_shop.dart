import 'package:flutter/material.dart';

class ListFoodMenuShop extends StatefulWidget {
  const ListFoodMenuShop({Key? key}) : super(key: key);

  @override
  State<ListFoodMenuShop> createState() => _ListFoodMenuShopState();
}

class _ListFoodMenuShopState extends State<ListFoodMenuShop> {
  @override
  Widget build(BuildContext context) {
    return Text('รายการอาหารของร้าน');
  }
}
