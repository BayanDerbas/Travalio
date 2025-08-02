class UserEntity {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String? dob;
  final String access;
  final String refresh;

  UserEntity({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.dob,
    required this.access,
    required this.refresh,
  });
}
