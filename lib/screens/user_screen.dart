import 'package:bloc_form/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  final String username;
  const UserScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome $username'),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context)..add(LogoutEvent());
              },
              icon: Icon(Icons.logout))
        ],
        centerTitle: true,
      ),
    );
  }
}
