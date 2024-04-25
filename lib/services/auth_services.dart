// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:social_media_api/model/auth_model.dart';

class AuthService {
  Dio dio = Dio();
  Future<AuthModel?> signUp(BuildContext context, AuthModel authModel) async {
    try {
      final response = await dio.post(
          'http://social-media-5ukj.onrender.com/auth/register',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: authModel.toJson());

      if (response.statusCode == 201) {
        log('account created');

        const snackBar = SnackBar(
          content: Text('Account Created'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
       final snackBar = SnackBar(
        content: Text('Unable to create account $e'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return null;
  }

  Future<String> login(BuildContext context, AuthModel authModel) async {
    try {
      final response = await dio.post(
          'http://social-media-5ukj.onrender.com/auth/login',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: authModel.toJson());

      if (response.statusCode == 200) {
        const SnackBar(
          content: Text('Login Succesful'),
          backgroundColor: Colors.red,
        );

        log('login success');
        final jsonData = response.data as Map<String, dynamic>;
        String token = jsonData['token'];
        String status = jsonData['status'];
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('Token', token);
        pref.setString('Status', status);
        return status;
      } else {
        const SnackBar(
          content: Text('User not found'),
          backgroundColor: Colors.red,
        );
        throw Exception('user not found ${response.statusCode}');
      }
    } catch (e) {
      const SnackBar(
          content: Text('Unable to login'),
          backgroundColor: Colors.red,
        );
      throw Exception('Something went wrong $e');
    }
  }


  Future<UserModel?> getLoggedUser(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString('Token');
      final response = await dio.get(
        'http://social-media-5ukj.onrender.com/auth/loggeduser',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final jsonData = UserModel.fromJson(response.data);
        return jsonData;
      } else {
        const SnackBar(
          content: Text('Failed to login'),
          backgroundColor: Colors.red,
        );
        throw Exception('Failed to get logged-in user: ${response.statusCode}');
      }
    } catch (e) {
      const SnackBar(
          content: Text('Something went wrong'),
          backgroundColor: Colors.red,
        );
      throw Exception('Something went wrong: $e');
    }
  }
}
