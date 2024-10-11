import 'package:flutter/material.dart';

class CekProfil {
  String picture;
  String nama;
  String email;
  String noTelp;
  String alamat;

  CekProfil(
      {required this.picture,
      required this.nama,
      required this.email,
      required this.noTelp,
      required this.alamat});
}

class ProfilProv extends ChangeNotifier {
  final List<CekProfil> _profil = [];

  List<CekProfil> get profil => _profil;

  ProfilProv() {
    _profil.add(CekProfil(
      picture: "",
      nama: "Admin",
      email: "admin@main.com",
      noTelp: "",
      alamat: "",
    ));
  }
  void updateProfil(CekProfil profil) {
    _profil
        .clear(); // Jika Anda ingin mengganti profil yang ada dengan yang baru, gunakan clear() untuk menghapus profil yang ada sebelum menambahkan yang baru.
    _profil.add(profil); // Tambahkan profil yang baru
    notifyListeners(); // Panggil notifyListeners untuk memberitahukan kepada listener bahwa ada perubahan pada state
  }
}
