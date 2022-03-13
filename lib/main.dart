import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'auth/provider/auth.dart';
import 'utils/utilities.dart';

final authProvider = StateNotifierProvider<Auth, AuthState>(
  (ref) => Auth(const FlutterSecureStorage()),
);

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
