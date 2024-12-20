import '../../core/class/app_linkes.dart';
import '../../core/class/curd.dart';



class LoginRemoteData {
  Curd curd;
  LoginRemoteData(this.curd);

  login({
    required String userName,
    required String password,
  }) async {
    final response = await curd.post(AppLinks.loginUrl, {
      "userName": userName,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }

}
