import 'package:clean_flutter_poc/core/failure.dart';
import 'package:clean_flutter_poc/features/auth/login/domain/entities/login_response_item.dart';
import 'package:clean_flutter_poc/features/auth/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'login_repository_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
  });

  group('LoginRepository', () {
    final String testEmail = 'test@example.com';
    final String testPassword = 'password123';
    final LoginResponseItem testLoginResponseItem =
        LoginResponseItem(token: 'testToken', refreshToken: 'testRefreshToken');

    test('should return LoginResponseItem when login is successful', () async {
      // arrange
      when(mockLoginRepository.login_user(testEmail, testPassword))
          .thenAnswer((_) async => Right(testLoginResponseItem));

      // act
      final result =
          await mockLoginRepository.login_user(testEmail, testPassword);

      // assert
      expect(result, Right(testLoginResponseItem));
      verify(mockLoginRepository.login_user(testEmail,
          testPassword)); // ensures calling with the correct parameters
      verifyNoMoreInteractions(
          mockLoginRepository); // ensures no unexpected calls happened
    });

    test('should return Failure when login fails', () async {
      // arrange
      final ServerFailure testFailure = ServerFailure('Login failed');
      when(mockLoginRepository.login_user(testEmail, testPassword))
          .thenAnswer((_) async => Left(testFailure));

      // act
      final result =
          await mockLoginRepository.login_user(testEmail, testPassword);

      // assert
      expect(result, Left(testFailure));
      verify(mockLoginRepository.login_user(testEmail, testPassword));
      verifyNoMoreInteractions(mockLoginRepository);
    });
  });
}
