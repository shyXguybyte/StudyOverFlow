import '../../core/class/app_linkes.dart';
import '../../core/class/curd.dart';

class ReConfirmData {
  Curd curd;

  ReConfirmData(this.curd);

  login({
    required String email,
  }) async {
    final response = await curd.post(AppLinks.resendEmailConfirmationLinkUrl(email), {});
    return response.fold((l) => l, (r) => r);
  }
}
