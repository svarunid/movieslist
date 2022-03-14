import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';

class SignUpScreen extends HookConsumerWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final List<String> _profession = ["Doctor", "Engineer", "Teacher", "Student"];

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _nameController = useTextEditingController();
    TextEditingController _phoneNumberController = useTextEditingController();
    TextEditingController _emailController = useTextEditingController();
    TextEditingController _passwordController = useTextEditingController();
    FocusNode _phoneNumberfocus = useFocusNode();
    FocusNode _emailfocus = useFocusNode();
    FocusNode _passwordfocus = useFocusNode();
    final _selectedVal = useState(_profession[0]);

    const SizedBox sizedBox = SizedBox(
      height: 14,
    );

    void signUp() {
      if (_formKey.currentState!.validate()) {
        ref.read(authProvider.notifier).signUp(
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            phoneNumber: _phoneNumberController.text,
            profession: _selectedVal.value);
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      backgroundColor: Colors.amber[200],
      body: Padding(
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
                      decoration: const InputDecoration(
                        hintText: 'Name',
                      ),
                      controller: _nameController,
                      onFieldSubmitted: (val) {
                        FocusScope.of(context).nextFocus();
                      },
                      validator: (str) {
                        if (str!.isEmpty) {
                          return "Enter your name";
                        }
                        return null;
                      },
                    ), //name
                    sizedBox,
                    TextFormField(
                        focusNode: _phoneNumberfocus,
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                        ),
                        controller: _phoneNumberController,
                        validator: (str) {
                          RegExp exp = RegExp(
                              r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");
                          if (str!.isEmpty || !exp.hasMatch(str)) {
                            return "Enter a valid phone number";
                          }
                          return null;
                        },
                        onFieldSubmitted: (str) {
                          FocusScope.of(context).nextFocus();
                        }), //phoneNumber
                    sizedBox,
                    TextFormField(
                        focusNode: _emailfocus,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        controller: _emailController,
                        validator: (str) {
                          RegExp exp = RegExp(r"[a-z0-9]+@[a-z]+\.[a-z]{2,3}");
                          if (str!.isEmpty || !exp.hasMatch(str)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).nextFocus();
                        }), //email
                    sizedBox,
                    TextFormField(
                        focusNode: _passwordfocus,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        controller: _passwordController,
                        validator: (str) {
                          RegExp exp =
                              RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
                          if (str!.isEmpty || !exp.hasMatch(str)) {
                            return "Minimum 8 characters and 1 number";
                          }
                          return null;
                        },
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).nextFocus();
                        }), //phoneNumber
                    sizedBox,
                    DropdownButtonFormField<String>(
                      items: [
                        for (String str in _profession)
                          DropdownMenuItem(
                            child: Text(str),
                            value: str,
                          )
                      ],
                      value: _selectedVal.value,
                      selectedItemBuilder: (ctx) {
                        return _profession.map((str) => Text(str)).toList();
                      },
                      onChanged: (val) {
                        _selectedVal.value = val!;
                      },
                    ),
                    sizedBox,
                    ElevatedButton(
                      onPressed: signUp,
                      child: const Text("Sign Up"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ), //profession
                  ],
                )),
          ),
        )),
      ),
    );
  }
}
