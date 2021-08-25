import 'package:cara_app/constants/strings.dart' as strings;
import 'package:http/http.dart' as http;

class UserApi {
  fetchUser({required String emailAddress}) async {
    try {
      var response =
          await http.get(Uri.parse(strings.fetchUser + emailAddress));

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
          body: body,
          headers: <String, String>{
            strings.HEADER_DETAILS_KEY: strings.HEADER_DETAILS_VALUE
          });

      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }
}
