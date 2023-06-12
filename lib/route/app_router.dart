import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:baiki2/repository/login/repository.dart';

import '../model/list/model.dart';
import '../modules/dashboard/view.dart';

//Pages
import 'package:baiki2/modules/login/view.dart';
import 'package:baiki2/modules/intro/intro_screen.dart';
import 'package:baiki2/modules/navBar/appBar.dart';
import '../modules/dashboard_detail/view.dart';
import 'guard.dart';
//Route

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        /**AutoRoute(
      page: LoginRoute.page,
      guards: [LoginGuard(userRepository: UserRepository())],
    ),**/
        AutoRoute(
            //page: NavBarRoute.page,
            page: DashboardRoute.page,
            //guards: [AuthGuard(userRepository: UserRepository())],
            initial: true,
            children: [
              /**AutoRoute(
                //page: NavBarRoute.page,
                page: IntroRoute.page,
                initial: true,
              ),**/
              AutoRoute(
                page: DashboardRoute.page,
                children: [
                  AutoRoute(page: DetailRoute.page)
                ]
              )
            ]),
      ];
}
