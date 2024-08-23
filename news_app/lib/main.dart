import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/app.dart';
import 'package:news_app/config/login_manager.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/services/authentication_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String? userId = await LoginManager.getUser();
  print(userId);
  runApp(BlocProvider(
    create: (context) =>
        AuthenticationCubit(authenticationServices: AuthenticationServices()),
    child: App(userId: userId),
  ));
}
