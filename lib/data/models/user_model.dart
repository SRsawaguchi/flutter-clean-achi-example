import 'package:flutter_clean_achi_example/domain/entities/user.dart';

class UserModel extends User {
  UserModel({String name, String email, String thumbnailUrl})
      : super(name: name, email: email, thumbnailUrl: thumbnailUrl);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: [json['name']['first'], json['name']['last']].join(' '),
      email: json['email'],
      thumbnailUrl: json['picture']['thumbnail'],
    );
  }

  static List<UserModel> userListFromJson(Map<String, dynamic> json) {
    return json['results'].fold(List<UserModel>(), (prev, userJson) {
      prev.add(UserModel.fromJson(userJson));
      return prev;
    });
  }
}
