import 'package:flutter/material.dart';

Widget statusButton(context, {required String status}) {
  Color color;
  String text;
  Color textColor = Colors.white;

  if (status == 'COMPLETED') {
    color = Theme.of(context).primaryColor;
    text = 'COMPLETED';
  } else if (status == 'CANCELED_BY_USER' || status == 'CANCELED_BY_SALON') {
    color = Colors.red;
    status == 'CANCELED_BY_USER' ? text = 'CANCELED BY USER' : text = 'CANCELED BY SALON';
  } else if (status == 'BOOKED') {
    color = Colors.green;
    text = 'BOOKED';
    textColor = Colors.black;
  } else {
    color = Colors.white;
    text = '';
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    ],
  );
}
