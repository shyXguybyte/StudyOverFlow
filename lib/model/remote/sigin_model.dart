import '../../core/class/app_linkes.dart';
import '../../core/class/curd.dart';



class SigInRemoteData {
  Curd curd;
  SigInRemoteData(this.curd);

  sigIn({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String phone,
    required String password,
  }) async {
    final response = await curd.post(
    "https://studyoverflow.runasp.net/api/Account/register", {
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName,
      "email": email,
      "password": password,
      "phone": phone,
    });
    return response.fold((l) => l, (r) => r);
  }

}

