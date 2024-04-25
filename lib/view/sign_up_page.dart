import 'package:flutter/material.dart';
import 'package:social_media_api/model/auth_model.dart';
import 'package:social_media_api/services/auth_services.dart';
import 'package:social_media_api/view/login_page.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.black12),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration:
                          const InputDecoration(hintText: 'Enter a Email'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid Email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration:
                          const InputDecoration(hintText: 'Enter a password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                        controller: usernameController,
                        decoration:
                            const InputDecoration(hintText: 'Enter a username'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid username';
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(height: 40),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            AuthService().signUp(
                                context,
                                AuthModel(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    username: usernameController.text));

                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                          }
                        },
                        child: const Text('Sign Up'))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}