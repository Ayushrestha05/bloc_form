import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bloc_form/model/User.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(LoadingState()) {
    on<LoadingEvent>((event, emit) async {
      print("Loading Event Started");
      //Get SharedPreferences Instance
      final prefs = await SharedPreferences.getInstance();
      //Return empty string if no logged user is found
      String loggedUserJSON = prefs.getString('logged') ?? '';
      if (loggedUserJSON != '') {
        emit(LoggedInState(loggedUserJSON));
      } else {
        emit(NotLoggedInState());
      }
    });

    on<LoginEvent>((event, emit) async {
      print("Login Event Started");
      //Get SharedPreferences Instance
      final prefs = await SharedPreferences.getInstance();
      //Create empty list of Users
      List<User> userList = [];
      //Return empty string if no user list is found
      String usersJSON = prefs.getString('users') ?? '';
      if (usersJSON != '') {
        //Decode the Users JSON
        var decode = jsonDecode(usersJSON);
        //From the decoded JSON, convert each element to User object and then add the User Object to the list.
        decode.forEach((e) => userList.add(User(e['username'], e['password'])));
      }
      print(userList);
      if (userList.any((element) =>
          element.username == event.username &&
          element.password == event.password)) {
        prefs.setString('logged', event.username);
        emit(LoggedInState(event.username));
      } else {
        //Emit a State that shows Alert Dialog
        emit(FailureAlertState("Wrong Credentials / No User Found"));
        emit(NotLoggedInState());
      }
    });

    on<RegisterEvent>((event, emit) async {
      print("Register Event Started");
      //Get SharedPreferences Instance
      final prefs = await SharedPreferences.getInstance();
      //Create empty list of Users
      List<User> userList = [];
      //Return empty string if no user list is found
      String usersJSON = prefs.getString('users') ?? '';
      if (usersJSON != '') {
        //Decode the Users JSON
        var decode = jsonDecode(usersJSON);
        //From the decoded JSON, convert each element to User object and then add the User Object to the list.
        decode.forEach((e) => userList.add(User(e['username'], e['password'])));
      }
      if (userList.any((element) =>
          element.username.toLowerCase() == event.username.toLowerCase())) {
        emit(FailureAlertState("User Already Exists"));
        emit(NotLoggedInState());
      } else {
        //Add the newly registered user to the list
        userList.add(User(event.username, event.password));
        //Encode the User List into JSON String
        var encodeJSON = jsonEncode(userList.map((e) => e.toJSON()).toList());
        //Save the JSON String to SharedPreferences
        prefs.setString('users', encodeJSON);
        //Save the newly registered User in Device
        prefs.setString('logged', event.username);
        emit(RegisteredState());
        emit(LoggedInState(event.username));
      }
    });

    on<LogoutEvent>((event, emit) async {
      print("Logout Event Started");
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('logged');
      emit(NotLoggedInState());
    });

    on<ClearDataEvent>((event, emit) async {
      print("Clear Data Event Started");
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('users');
      prefs.remove('logged');
      emit(NotLoggedInState());
    });
  }
}
