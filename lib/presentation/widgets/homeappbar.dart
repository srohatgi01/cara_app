import 'package:cara_app/constants/colors.dart';
import 'package:cara_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

AppBar homeAppBar({
  required BuildContext context,
  required String zipCode,
}) {
  TextEditingController _controller = TextEditingController(text: zipCode);

  return AppBar(
    backgroundColor: Color(backgroundColor),
    elevation: 0,
    centerTitle: true,
    title: Text(
      'Cara',
      style: TextStyle(
          fontFamily: 'Signatra',
          fontSize: 45,
          color: Theme.of(context).primaryColor),
    ),
    leading: IconButton(
      onPressed: () => {
        zipCodeFunc(context, _controller),
      },
      icon: Icon(
        Icons.location_history,
        color: Theme.of(context).primaryColor,
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(
          LineIcons.coins,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () => {},
      )
    ],
  );
}

Future<dynamic> zipCodeFunc(
    BuildContext context, TextEditingController _controller) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Icon(
        Icons.location_history,
        color: Theme.of(context).primaryColor,
        size: 80,
      ),
      children: [
        SimpleDialogOption(
          child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(),
            controller: _controller,
            maxLength: 6,
          ),
        ),
        SimpleDialogOption(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<UserProvider>(context, listen: false)
                  .updateZipCode(zipCode: _controller.value.text);
            },
            child: Text('Sumbit'),
          ),
        )
      ],
    ),
  );
}
