import 'dart:convert';
import 'package:flutter_clean_achi_example/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../datasources/random_user_generator_sample_response.dart.dart';

void main() {
  group('factory fromJson', () {
    test('should return valid UserModel when json is valid', () {
      final jsonString = RandomUserGeneratorSampleResponse.SINGLE_USER_JSON;
      final user = UserModel.fromJson(jsonDecode(jsonString));

      expect('Serenity Bell', user.name);
      expect('https://randomuser.me/api/portraits/thumb/women/62.jpg',
          user.thumbnailUrl);
      expect('serenity.bell@example.com', user.email);
    });
  });

  group('userListFromJson', () {
    test('should return valid List<UserModel> when json is valid', () {
      final jsonString = RandomUserGeneratorSampleResponse.RESULT_JSON;
      final userCount = RandomUserGeneratorSampleResponse.RESULT_USER_COUNT;
      final userList = UserModel.userListFromJson(jsonDecode(jsonString));

      expect(userList.length, userCount);
    });
  });
}
