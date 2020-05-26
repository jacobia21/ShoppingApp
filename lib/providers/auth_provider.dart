import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exceptions.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expirationDate;
  String _userId;

  Future<void> _authenticate(String email, String password, String urlSegment) async {
    try {
      final url =
          'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCBeN16z5Dtv5mNdYbZSv7h2ItwwzvnPic';
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
