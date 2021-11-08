import 'package:cara_app/constants/colors.dart';
import 'package:cara_app/data/repositories/user_repo.dart';
import 'package:cara_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
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
      style: TextStyle(fontFamily: 'Signatra', fontSize: 45, color: Theme.of(context).primaryColor),
    ),
    leading: IconButton(
      onPressed: () => {
        zipCodeFunc(context, _controller),
      },
      icon: Icon(
        LineIcons.mapMarker,
        size: 28,
        color: Theme.of(context).primaryColor,
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {
          userCoinsFunc(context);
        },
        child: Container(
          margin: EdgeInsets.only(right: 16, top: 6),
          child: SvgPicture.asset(
            'assets/svg/wallet-line.svg',
            height: 20,
            fit: BoxFit.contain,
          ),
        ),
      ),
    ],
  );
}

Future<dynamic> zipCodeFunc(BuildContext context, TextEditingController _controller) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Icon(
        LineIcons.mapMarker,
        color: Theme.of(context).primaryColor,
        size: 80,
      ),
      children: [
        SimpleDialogOption(
          child: TextFormField(
            style: TextStyle(fontFamily: 'NexaBold'),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(hintText: 'Enter Zipcode'),
            controller: _controller,
            showCursor: false,
            autovalidateMode: AutovalidateMode.always,
            validator: (val) {
              if (val!.length == 0) {
                return "Zipcode cannot be empty";
              } else if (val.length != 6) {
                return "Zipcode must be 6 digits";
              } else {
                return null;
              }
            },
          ),
        ),
        SimpleDialogOption(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              // API call for patch request to update the zipcode only if the user is signed in
              if (Provider.of<UserProvider>(context, listen: false).isSignedIn == true) {
                UserRepository().updateZipCode(
                  emailAddress: Provider.of<UserProvider>(context, listen: false).cuser.emailAddress,
                  zipCode: _controller.value.text,
                );
              }

              Provider.of<UserProvider>(context, listen: false).updateZipCode(zipCode: _controller.value.text);
            },
            child: Text('Sumbit'),
          ),
        )
      ],
    ),
  );
}

Future<dynamic> userCoinsFunc(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Icon(
        Icons.construction_outlined,
        color: Theme.of(context).primaryColor,
        size: 80,
      ),
      children: [
        SimpleDialogOption(
          child: Container(alignment: Alignment.center, child: Text('Coming soon')),
        ),
        SimpleDialogOption(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go Back'),
          ),
        )
      ],
    ),
  );
}
