import 'package:bloc_form/bloc/auth/auth_bloc.dart';
import 'package:bloc_form/screens/login_screen.dart';
import 'package:bloc_form/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(LoadingEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthState) {
          if (state.registerStatus == RegisterStatus.Registered) {
            Navigator.pop(context);
          }
          if (state.loginStatus == LoginStatus.AuthError) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Bad Credentials'),
                    ));
          }

          if (state.registerStatus == RegisterStatus.Exists) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('User Exists Already'),
                    ));
          }
        }
      },
      builder: (context, state) {
        if (state is AuthState) {
          if (state.loggedInUser != null) {
            return UserScreen(
              username: state.loggedInUser!,
            );
          } else {
            return const LoginScreen();
          }
        }

        return Container();
      },
    );
  }
}
