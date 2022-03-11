import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth/provider/auth.dart';
import 'utils/utilities.dart';
import 'auth/view/welcome_screen.dart';
import 'movies/view/movies_screen.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthState status = ref.watch(authProvider);

    return MaterialApp(
      title: 'Movies List',
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: status == AuthState.waiting
          ? Container(
            color: Colors.white,
            child: const Center(
                child: CircularProgressIndicator(),
              ),
          )
          : status == AuthState.loggedIn
              ? const MoviesScreen()
              : const WelcomeScreen(),
    );
  }
}
