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
      logOut();
      throw LogInException('No user Found');
    }

    List userPasswordJSON = jsonDecode(response);

    Map userPasswordMap = userPasswordJSON.firstWhere((element) {
      return element.containsValue(email);
    }, orElse: () => {});

    if (userPasswordMap.isEmpty) {
      logOut();
      throw LogInException('No user Found');
    }

    if (password != userPasswordMap['password']) {
      logOut();
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

    List users = response == null ? [] : jsonDecode(response);

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

  void logOut() {
    state = AuthState.loggedOut;
  }
}

final authProvider = StateNotifierProvider<Auth, AuthState>(
  (ref) => Auth(const FlutterSecureStorage()),
);
