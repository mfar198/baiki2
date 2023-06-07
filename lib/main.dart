import 'package:baiki2/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:baiki2/modules/login/bloc/login_bloc.dart';
import 'package:baiki2/modules/navBar/appBar.dart';
import 'package:baiki2/repository/login/repository.dart';
import 'package:baiki2/services/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:baiki2/route/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  final userRepository = UserRepository();
  final _appRouter = AppRouter();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(userRepository: userRepository)
              ..add(AppStarted());
          },
        ),
        BlocProvider<ListBloc>(
          create: (context) => ListBloc(),
        ),
        // Add more BlocProviders here if needed
      ], child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
    ),
    ),
  );
}

