import '../../core/class/app_linkes.dart';
import '../../core/class/curd.dart';

class ConfirmUserModel {
  Curd curd;

  ConfirmUserModel(this.curd);

  confirmUser(
    final String token,
  ) async {
    final response = await curd.get(AppLinks.getUserInfoUrl, token);
    return response.fold((l) => l, (r) => r);
  }
}
