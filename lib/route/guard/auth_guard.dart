import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';

import 'package:baiki2/services/auth_bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:baiki2/repository/login/repository.dart';
import 'package:baiki2/route/app_router.dart';


class AuthGuard extends AutoRouteGuard {
  final UserRepository userRepository;
  get state => userRepository;

  AuthGuard({required this.userRepository});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final context = router.navigatorKey.currentContext;
    if (userRepository is AuthenticationUnauthenticated) {
      router.push(LoginRoute(userRepository: userRepository));
      //return false;
    } else if (userRepository is AuthenticationAuthenticated) {
      //router.push(NavBarRoute());
      resolver.next(true);
    } else {
      router.push(LoginRoute(userRepository: userRepository));
    }
  }
}
