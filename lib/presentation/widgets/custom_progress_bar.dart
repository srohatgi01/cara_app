import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({Key? key, this.text, this.marginTop = 0, this.marginBottom = 0}) : super(key: key);
  final String? text;
  final double marginTop;
  final double marginBottom;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
        text != null ? Text(text!, style: TextStyle(color: Colors.black54)) : SizedBox(),
      ],
    );
  }
}
