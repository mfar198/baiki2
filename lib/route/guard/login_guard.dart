import 'package:auto_route/auto_route.dart';
import 'package:baiki2/repository/login/repository.dart';
import 'package:baiki2/services/auth_bloc/auth_bloc.dart';

import 'package:baiki2/route/app_router.dart';


class LoginGuard extends AutoRouteGuard {
  final UserRepository userRepository;
  get state => userRepository;
  LoginGuard({required this.userRepository});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (userRepository is AuthenticationAuthenticated) {
      router.push(IntroRoute(/**title: 'Intro'**/));
      //resolver.next(true);
    } else if (userRepository is AuthenticationUnauthenticated) {
      router.push(LoginRoute(userRepository: userRepository));
    }
  }
}
