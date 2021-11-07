import 'package:cara_app/constants/strings.dart' as strings;
import 'package:cara_app/constants/strings.dart';
import 'package:cara_app/data/models/update_zipcode.dart';
import 'package:http/http.dart' as http;

class UserApi {
  fetchUser({required String emailAddress}) async {
    try {
      var response = await http.get(Uri.parse(strings.fetchUser + emailAddress));

      if (response.statusCode == 404) {
        return 404;
      } else if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  postUser({required String body}) async {
    try {
      var response = await http.post(Uri.parse(strings.postUser),
          body: body, headers: <String, String>{strings.HEADER_DETAILS_KEY: strings.HEADER_DETAILS_VALUE});

      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }

  /* 
  this patch request will return the http code 200 and will return the whole object of the user.
  it is not of use as for right now so I am not storing the response in any variable.
  */
  updateZipCode({required String emailAddress, required var body}) async {
    try {
      var response = await http.patch(Uri.parse(patchUser + emailAddress), body: body, headers: headers);

      if (response.statusCode == 200) {
        print('Update Successful.');
      }
    } catch (e) {
      print(e);
    }
  }
}
