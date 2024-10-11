import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isLoggedIn = false;

  String get email => _email;
  String get password => _password;
  bool get isLoggedIn => _isLoggedIn;

  UserProfile _profil =
      UserProfile(nama: '', email: '', alamat: '', picture: '');
  UserProfile get profil => _profil;

  void register(String email, String password) {
    _profil = UserProfile(
        nama: getNameFromEmail(email), email: email, alamat: '', picture: '');
    notifyListeners();
  }

  Future<void> loadRegisterInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('registerEmail') ?? '';
    _password = prefs.getString('registerPassword') ?? '';
    notifyListeners();
  }

  Future<void> saveRegisterInfo(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('registerEmail', email);
    await prefs.setString('registerPassword', password);
    _email = email;
    _password = password;
    notifyListeners();
  }

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    _isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  void updateProfil(String nama, String email, String alamat, String picture) {
    _profil =
        UserProfile(nama: nama, email: email, alamat: alamat, picture: picture);
    notifyListeners();
  }

  Future<void> loadLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  bool validateCredentials(String email, String password) {
    return _email == email && _password == password;
  }

  String getNameFromEmail(String email) {
    return email.split('@')[0];
  }
}

class UserProfile {
  String nama;
  String email;
  String alamat;
  String picture;

  UserProfile({
    required this.nama,
    required this.email,
    required this.alamat,
    required this.picture,
  });
}
