import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/auth.dart';

class LogInScreen extends HookConsumerWidget {
  LogInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _emailController = useTextEditingController();
    TextEditingController _passwordController = useTextEditingController();
    FocusNode focus = useFocusNode();
    Auth auth = ref.read(authProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.15,
        ),
        child: Center(
          child: Card(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      autofocus: true,
                      controller: _emailController,
                      validator: (str) {
                        RegExp exp = RegExp(r".{1,}@[^.]{1,}");
                        if (str!.isEmpty || exp.hasMatch(str)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      onFieldSubmitted: (str) {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).requestFocus(focus);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      focusNode: focus,
                      controller: _passwordController,
                      validator: (str) {
                        RegExp exp =
                            RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
                        if (str!.isEmpty || exp.hasMatch(str)) {
                          return "Minimum 8 characters and 1 number";
                        }
                        return null;
                      },
                      onFieldSubmitted: (str) {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        try {
                          auth.logIn(
                            email: _emailController.text.isEmpty ? '' : _emailController.text,
                            password: _passwordController.text.isEmpty ? '' : _passwordController.text,
                          );
                        } catch (e) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text(e.toString()),
                          //   ),
                          // );
                          print(e.toString());
                        }
                      },
                      child: const Text("Log In"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    )
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
