import 'dart:convert';

import 'package:flutter_clean_achi_example/core/exceptions.dart';
import 'package:flutter_clean_achi_example/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class RandomUserGeneratorApi {
  static const BASE_URL = 'https://randomuser.me/api/';
  final http.Client client;

  RandomUserGeneratorApi(this.client);

  Future<List<UserModel>> fetchRandomUsers(int count) async {
    final url = '$BASE_URL?format=json&results=$count';
    final response = await this.client.get(url);

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      return UserModel.userListFromJson(jsonDecode(response.body));
    }
  }
}
