import 'package:flutter_clean_achi_example/core/exceptions.dart';
import 'package:flutter_clean_achi_example/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_achi_example/data/datasources/random_user_generator_api.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'random_user_generator_sample_response.dart.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  RandomUserGeneratorApi api;
  MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    api = RandomUserGeneratorApi(mockClient);
  });

  test('should return List<UserModel> when the response code is 200', () async {
    final sampleJson = RandomUserGeneratorSampleResponse.RESULT_JSON;
    final userCount = RandomUserGeneratorSampleResponse.RESULT_USER_COUNT;

    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(sampleJson, 200));

    final List<UserModel> result = await api.fetchRandomUsers(userCount);
    verify(mockClient
        .get('https://randomuser.me/api/?format=json&results=$userCount'));
    expect(result.length, userCount);
  });

  test('should throw a ServerException when the response code is not 200',
      () async {
    when(mockClient.get(any)).thenAnswer((_) async => http.Response('', 500));

    expect(() => api.fetchRandomUsers(3), throwsA(isA<ServerException>()));
  });
}
