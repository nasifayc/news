import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/services/authentication_services.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationServices authenticationServices;
  AuthenticationCubit({required this.authenticationServices})
      : super(AuthenticationInitial());

  void signInWithEmailAndPassword(String email, String password) async {}
  void signUpWithEmailAndPassword(
      String username, String email, String password) async {}
  void signInWithGoogle() async {}
  void signInWithFacebook() async {}
}
