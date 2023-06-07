import 'package:auto_route/auto_route.dart';
import 'package:baiki2/services/auth_bloc/auth_bloc.dart';
import 'package:baiki2/modules/login/bloc/login_bloc.dart';
import 'package:baiki2/repository/login/repository.dart';
import 'package:baiki2/modules/login/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;
  const LoginScreen ({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context){
          return LoginBloc(
            authenticationBloc : BlocProvider.of<AuthenticationBloc>(context),
            userRepository : userRepository,
          );
        },
        child: LoginForm(userRepository: userRepository,),
      ),
    );
  }
}
