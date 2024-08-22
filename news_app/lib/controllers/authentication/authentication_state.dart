import 'package:equatable/equatable.dart';
import 'package:news_app/models/user_model.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class Authenticating extends AuthenticationState {}

final class AuthenticatingGoogle extends AuthenticationState {}

final class AuthenticatingFacebook extends AuthenticationState {}

final class Authenticated extends AuthenticationState {
  final UserModel user;
  Authenticated({required this.user});

  @override
  List<Object> get props => [user];
}

final class AuthenticationFailed extends AuthenticationState {
  final String errorMessage;
  AuthenticationFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
