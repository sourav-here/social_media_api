// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:social_media_api/model/auth_model.dart';
import 'package:social_media_api/services/auth_services.dart';
import 'package:social_media_api/view/bottom_nav.dart';
import 'package:social_media_api/view/sign_up_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Social Media'),
        centerTitle: true,
      ),
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
                    const SizedBox(height: 40),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            final status = await AuthService().login(
                                context,
                                AuthModel(
                                    email: emailController.text,
                                    password: passwordController.text));
                            if (status == 'success') {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const Bottomnav(),
                              ));
                            } else {
                              return;
                            }
                          }
                        },
                        child: const Text('Login')),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ));
                      },
                      child: const Text('Sign up'),
                    ),
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
