import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/services/authentication_services.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/config/login_manager.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';

// Mock classes
class MockAuthenticationServices extends Mock
    implements AuthenticationServices {}

class MockLoginManager extends Mock implements LoginManager {}

class MockUser extends Mock implements User {}

void main() {
  late AuthenticationCubit authenticationCubit;
  late MockAuthenticationServices mockAuthenticationServices;

  setUp(() {
    mockAuthenticationServices = MockAuthenticationServices();
    authenticationCubit =
        AuthenticationCubit(authenticationServices: mockAuthenticationServices);
  });

  group('AuthenticationCubit', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [Authenticating, Authenticated] when signInWithEmailAndPassword is successful',
      build: () {
        final user = MockUser();
        final userModel = UserModel(
            id: 'uid', username: 'username', email: 'email@example.com');

        when(() => mockAuthenticationServices.signinWithEmailAndPassword(
            any(), any())).thenAnswer((_) async => user);
        when(() => mockAuthenticationServices.getUser(user.uid))
            .thenAnswer((_) async => userModel);
        when(() => LoginManager.saveUser(user.uid)).thenAnswer((_) async => {});

        return authenticationCubit;
      },
      act: (cubit) =>
          cubit.signInWithEmailAndPassword('email@example.com', 'password123'),
      expect: () => [
        Authenticating(),
        Authenticated(
            user: UserModel(
                id: 'uid', username: 'username', email: 'email@example.com')),
      ],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [Authenticating, AuthenticationFailed] when signInWithEmailAndPassword fails',
      build: () {
        when(() => mockAuthenticationServices.signinWithEmailAndPassword(
            any(), any())).thenThrow(Exception('Sign in failed'));

        return authenticationCubit;
      },
      act: (cubit) =>
          cubit.signInWithEmailAndPassword('email@example.com', 'password123'),
      expect: () => [
        Authenticating(),
        AuthenticationFailed(errorMessage: 'Exception: Sign in failed'),
      ],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [Authenticating, AuthenticationFailed] when signUpWithEmailAndPassword is called with an invalid email',
      build: () => authenticationCubit,
      act: (cubit) => cubit.signUpWithEmailAndPassword(
          'username', 'invalid-email', 'password123'),
      expect: () => [
        Authenticating(),
        AuthenticationFailed(errorMessage: 'Invalid email format.'),
      ],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [Authenticating, AuthenticationFailed] when signUpWithEmailAndPassword is called with an invalid password',
      build: () => authenticationCubit,
      act: (cubit) => cubit.signUpWithEmailAndPassword(
          'username', 'email@example.com', 'short'),
      expect: () => [
        Authenticating(),
        AuthenticationFailed(
            errorMessage:
                'Password must be at least 8 characters long and contain both letters and numbers.'),
      ],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [AuthenticatingGoogle, Authenticated] when signInWithGoogle is successful',
      build: () {
        final user = MockUser();
        final userModel = UserModel(
            id: 'uid', username: 'username', email: 'email@example.com');

        when(() => mockAuthenticationServices.signinWithGoogle())
            .thenAnswer((_) async => user);
        when(() => mockAuthenticationServices.getUser(user.uid))
            .thenAnswer((_) async => userModel);

        return authenticationCubit;
      },
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => [
        AuthenticatingGoogle(),
        Authenticated(
            user: UserModel(
                id: 'uid', username: 'username', email: 'email@example.com')),
      ],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [AuthenticatingFacebook, Authenticated] when signInWithFacebook is successful',
      build: () {
        final user = MockUser();
        final userModel = UserModel(
            id: 'uid', username: 'username', email: 'email@example.com');

        when(() => mockAuthenticationServices.signinWithFacebook())
            .thenAnswer((_) async => user);
        when(() => mockAuthenticationServices.getUser(user.uid))
            .thenAnswer((_) async => userModel);

        return authenticationCubit;
      },
      act: (cubit) => cubit.signInWithFacebook(),
      expect: () => [
        AuthenticatingFacebook(),
        Authenticated(
            user: UserModel(
                id: 'uid', username: 'username', email: 'email@example.com')),
      ],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [Authenticating, AuthenticationInitial] when signOut is successful',
      build: () {
        when(() => mockAuthenticationServices.signOut())
            .thenAnswer((_) async => {});

        return authenticationCubit;
      },
      act: (cubit) => cubit.signOut(),
      expect: () => [
        Authenticating(),
        AuthenticationInitial(),
      ],
    );
  });
}
