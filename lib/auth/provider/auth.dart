import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/utilities.dart';
import '../model/user.dart';
import '../../error/exception.dart';

class Auth extends StateNotifier<AuthState> {
  final FlutterSecureStorage storage;

  Auth(this.storage) : super(AuthState.waiting) {
    storage.read(key: 'status').then(
      (value) {
        if (value == "0") {
          state = AuthState.loggedOut;
        } else if (value == "1") {
          state = AuthState.loggedIn;
        } else {
          state = AuthState.loggedOut;
        }
      },
    );
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    state = AuthState.waiting;

    String? response = await storage.read(key: 'user');

    if (response == null) {
      state = AuthState.loggedOut;
      throw LogInException('No user Found');
    }

    List<Map<String, String>> userPasswordJSON = jsonDecode(response);
    String userPassword = userPasswordJSON.firstWhere(
          (element) {
            return element.containsKey(email);
          },
        )['password'] ??
        "";
    if (password != userPassword) {
      state = AuthState.loggedOut;
      throw LogInException('Check your password');
    }
    state = AuthState.loggedIn;
  }

  Future<User> signUp({
    required String name,
    required String email,
    required String phoneNumber,
    required String profession,
    required String password,
  }) async {
    User user = User(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      profession: profession,
      password: password,
    );

    state = AuthState.waiting;

    String? response = await storage.read(key: 'user');

    List<Map<String, String>> users =
        response == null ? [] : jsonDecode(response);

    await storage.write(
      key: 'user',
      value: json.encode(
        users..add(user.toJson()),
      ),
    );
    
    await storage.write(
      key: 'status',
      value: "1",
    );

    state = AuthState.loggedIn;

    return user;
  }
}
