import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/login_manager.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/services/authentication_services.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationServices authenticationServices;
  AuthenticationCubit({required this.authenticationServices})
      : super(AuthenticationInitial());

  void signInWithEmailAndPassword(String email, String password) async {
    emit(Authenticating());
    try {
      User? user = await authenticationServices.signinWithEmailAndPassword(
          email, password);
      if (user != null) {
        UserModel? usermodel = await authenticationServices.getUser(user.uid);
        if (usermodel != null) {
          await LoginManager.saveUser(user.uid);
          emit(Authenticated(user: usermodel));
        } else {
          emit(AuthenticationFailed(errorMessage: usermodel.toString()));
        }
      } else {
        emit(AuthenticationFailed(errorMessage: user.toString()));
      }
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
    }
  }

  void signUpWithEmailAndPassword(
      String username, String email, String password) async {
    emit(Authenticating());

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

    // Validate email format
    if (!emailRegex.hasMatch(email)) {
      emit(AuthenticationFailed(errorMessage: 'Invalid email format.'));
      return;
    }

    // Validate password (Minimum 8 characters, at least one letter and one number)
    if (!passwordRegex.hasMatch(password)) {
      emit(AuthenticationFailed(
          errorMessage:
              'Password must be at least 8 characters long and contain both letters and numbers.'));
      return;
    }
    try {
      User? user = await authenticationServices.signupWithEmailAndPassword(
          username, email, password);
      if (user != null) {
        signInWithEmailAndPassword(email, password);
      } else {
        emit(AuthenticationFailed(errorMessage: user.toString()));
      }
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
    }
  }

  void signInWithGoogle() async {
    emit(AuthenticatingGoogle());
    try {
      User? user = await authenticationServices.signinWithGoogle();
      if (user != null) {
        UserModel? usermodel = await authenticationServices.getUser(user.uid);
        if (usermodel != null) {
          emit(Authenticated(user: usermodel));
        } else {
          emit(AuthenticationFailed(errorMessage: usermodel.toString()));
        }
      }
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
    }
  }

  void signInWithFacebook() async {
    emit(AuthenticatingFacebook());
    try {
      User? user = await authenticationServices.signinWithFacebook();
      if (user != null) {
        UserModel? usermodel = await authenticationServices.getUser(user.uid);
        if (usermodel != null) {
          emit(Authenticated(user: usermodel));
        } else {
          emit(AuthenticationFailed(errorMessage: usermodel.toString()));
        }
      }
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
    }
  }

  void updateUser(UserModel user) async {
    try {
      UserModel? userModel = await authenticationServices.updateUser(user);
      String? currentUserId = await LoginManager.getUser();
      if (userModel != null && userModel.id == currentUserId) {
        emit(Authenticated(user: userModel));
      }
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
    }
  }

  void signOut() async {
    emit(Authenticating());
    try {
      await authenticationServices.signOut();
      emit(AuthenticationInitial());
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
    }
  }

  void emitAuthenticated(UserModel user) {
    emit(Authenticated(user: user));
  }

  void emitUnauthenticated(String error) {
    emit(AuthenticationFailed(errorMessage: error));
  }
}
