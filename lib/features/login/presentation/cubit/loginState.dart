abstract class LoginState {}

class LoginInitState extends LoginState {}
class ChangShowPasswordFlagState extends LoginState {}
class ChangShowConfirmPasswordFlagState extends LoginState {}
class SignUpByEmailStateSuccessfully extends LoginState {}
class RestSignUpControlsStateSuccessfully extends LoginState {}
class RestLoginControlsStateSuccessfully extends LoginState {}