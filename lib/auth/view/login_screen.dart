import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/utilities.dart';
import '../provider/auth.dart';

class LogInScreen extends HookConsumerWidget {
  LogInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _emailController = useTextEditingController();
    TextEditingController _passwordController = useTextEditingController();
    FocusNode _focus = useFocusNode();

    const SizedBox sizedBox = SizedBox(
      height: 14,
    );

    void logIn() async {
      if (_formKey.currentState!.validate()) {
        try {
          await ref.read(authProvider.notifier).logIn(
                email: _emailController.text,
                password: _passwordController.text,
              );
          Navigator.of(context).pop();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
      }
    }

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.amber[200],
        body: ref.watch(authProvider) == AuthState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.15,
                ),
                child: Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              autofocus: true,
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                              ),
                              validator: (str) {
                                RegExp exp =
                                    RegExp(r"[a-z0-9]+@[a-z]+\.[a-z]{2,3}");
                                if (str!.isEmpty || !exp.hasMatch(str)) {
                                  return "Enter a valid email";
                                }
                                return null;
                              },
                              onFieldSubmitted: (str) {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).requestFocus(_focus);
                                }
                              },
                            ),
                            sizedBox,
                            TextFormField(
                              focusNode: _focus,
                              obscureText: true,
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                              ),
                              validator: (str) {
                                RegExp exp = RegExp(
                                    r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
                                if (str!.isEmpty || !exp.hasMatch(str)) {
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
                            sizedBox,
                            ElevatedButton(
                              onPressed: logIn,
                              child: const Text("Log In"),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
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
      ),
    );
  }
}
