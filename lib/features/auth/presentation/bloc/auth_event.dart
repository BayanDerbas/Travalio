abstract class AuthEvent {}

class AuthEmailChanged extends AuthEvent {
  final String email;
  AuthEmailChanged(this.email);
}

class AuthPasswordChanged extends AuthEvent {
  final String password;
  AuthPasswordChanged(this.password);
}

class AuthFullNameChanged extends AuthEvent {
  final String name;
  AuthFullNameChanged(this.name);
}

class AuthUsernameChanged extends AuthEvent {
  final String username;
  AuthUsernameChanged(this.username);
}

class AuthBirthDateChanged extends AuthEvent {
  final DateTime birthDate;
  AuthBirthDateChanged(this.birthDate);
}

class AuthSubmit extends AuthEvent {
  final bool isLogin;
  final Map<String, dynamic>? body;
  AuthSubmit({required this.isLogin, this.body});
}

class AuthTogglePasswordVisibility extends AuthEvent {}

class AuthToggleConfirmPasswordVisibility extends AuthEvent {}