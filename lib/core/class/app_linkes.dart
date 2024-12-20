

class AppLinks {

  static const String baserUrl = "https://studyoverflow.runasp.net/api/";

  
  static const loginUrl = "${baserUrl}Account/login";
  static const registerUrl = "${baserUrl}Account/register";
  static const refreshTokenUrl = "${baserUrl}Account/refresh-user-token";
  static const getUserInfoUrl = "${baserUrl}Account/get-user-info";
  
  static const confirmEmailUrl = "${baserUrl}Account/confirm-email";
  static const forgotPasswordUrl = "${baserUrl}Account/forgot-password";
  static const resetPasswordUrl = "${baserUrl}Account/reset-password";

  
  static  resendEmailConfirmationLinkUrl(String email){
    return "${baserUrl}Account/resend-email-confirmation-link/$email";
  }
  
  static forgetPasswordUrl(String email){
    return "${baserUrl}Account/forgot-username-or-password/$email";
  }
  
}

////https://api.weatherapi.com/
// v1/forecast.json
// ?key=3677bed892474b30b7a122242220806&q=egypt&days=7