import 'package:cara_app/constants/colors.dart';
import 'package:flutter/material.dart';

AppBar commonAppBar(BuildContext context) => AppBar(
      backgroundColor: Color(backgroundColor),
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Cara',
        style: TextStyle(fontFamily: 'Signatra', fontSize: 45, color: Theme.of(context).primaryColor),
      ),
    );
