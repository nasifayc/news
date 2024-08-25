import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:news_app/config/app.dart';
import 'package:news_app/config/login_manager.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/services/authentication_services.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String? userId = await LoginManager.getUser();
  // print(userId);

  FlutterNativeSplash.remove();
  runApp(BlocProvider(
    create: (context) =>
        AuthenticationCubit(authenticationServices: AuthenticationServices()),
    child: App(userId: userId),
  ));
}
