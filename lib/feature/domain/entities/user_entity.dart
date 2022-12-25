class UserEntity {
  final int id;
  final String name;
  final String surname;
  final String fullName;
  final String email;
  final String login;
  final String phone;
  UserEntity(
      {required this.id,
      required this.name,
      required this.surname,
      required this.fullName,
      required this.email,
      required this.login,
      required this.phone});
}
