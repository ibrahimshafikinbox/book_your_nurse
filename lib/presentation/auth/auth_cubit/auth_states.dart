abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class SignUpLoading extends AuthStates {}

class SignUpSuccess extends AuthStates {}

class SignUpFailed extends AuthStates {
  String errorMessage;

  SignUpFailed({ required this.errorMessage});
}

class ChangeObscuredSignUp extends AuthStates {}
class ChangeObscuredLogin extends AuthStates {}

class LoginLoading extends AuthStates {}

class LoginSuccess extends AuthStates {}

class LoginFailedState extends AuthStates {
  String errorMessage;

  LoginFailedState({required this.errorMessage});
}

class GoogleLoginLoading extends AuthStates {}

class GoogleLoginSuccess extends AuthStates {}

class GoogleLoginFailed extends AuthStates {
  String errorMessage;

  GoogleLoginFailed(this.errorMessage);
}

class FacebookLoginLoading extends AuthStates {}

class FacebookLoginSuccess extends AuthStates {}

class FacebookLoginFailed extends AuthStates {
  final String errorMessage;

  FacebookLoginFailed(this.errorMessage);
}

class EditName extends AuthStates {}

class ResetPasswordLoading extends AuthStates {}

class ResetPasswordSuccess extends AuthStates {}

class ResetPasswordFailed extends AuthStates {}



