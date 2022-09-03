import 'package:flutter/material.dart';

class ShowImages extends StatelessWidget {
  const ShowImages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('images/image1.png');
  }
}
