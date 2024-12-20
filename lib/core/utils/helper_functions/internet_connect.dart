import 'dart:io';


Future<bool> interConnect() async {
  try {
    var request = await InternetAddress.lookup('google.com');
    if (request.isNotEmpty && request[0].rawAddress.isNotEmpty) {
      return true;
    }
  } catch (e) {
    return false;
  }
  return false;
}
