import 'package:bloc_form/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final _registerKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _initialPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _registerKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/bloc_logo_full.png'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      validator: RequiredValidator(
                          errorText: 'Please enter a username'),
                      decoration: const InputDecoration(
                        label: Text('Username'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _initialPasswordController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter a password'),
                        MinLengthValidator(8,
                            errorText: 'At least 8 characters requried')
                      ]),
                      obscureText: true,
                      decoration: const InputDecoration(
                        label: Text('Password'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (_initialPasswordController.text == value?.trim()) {
                          return null;
                        } else {
                          return 'Passwords do not match';
                        }
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        label: Text('Re-enter Password'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_registerKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context)
                              ..add(RegisterEvent(_usernameController.text,
                                  _initialPasswordController.text));
                          } else {
                            print('not validated');
                          }
                        },
                        child: Text('Register')),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                              text: 'Login Now!',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
