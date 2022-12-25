import 'package:sparrow_todo_list/feature/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required id,
      required name,
      required surname,
      required fullName,
      required email,
      required login,
      required phone})
      : super(
            id: id,
            name: name,
            surname: surname,
            fullName: fullName,
            email: email,
            login: login,
            phone: phone);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      fullName: json['fullName'],
      email: json['email'],
      login: json['login'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'fullName': fullName,
      'email': email,
      'login': login,
      'phone': phone,
    };
  }
}
