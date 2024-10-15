import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_provider.dart';
import 'fitur/login_and_regist/auth_prov.dart';
import 'fitur/login_and_regist/login.dart';
import 'fitur/profile/provider/profil_prov.dart';
import 'fitur/profile/provider/switchProvider.dart';
import 'fitur/Challanges/TranslateGames/game_provider.dart';
import 'fitur/Challanges/myDictionary/_Provider.dart';
import 'fitur/Challanges/Sentences/HandlerButton_prov.dart';
import 'fitur/Challanges/Sentences/_services.dart';
import 'fitur/providers/translation_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await _getLoginStatus();
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    key: null,
  ));
}

Future<bool> _getLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({required key, required this.isLoggedIn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfilProv()),
        ChangeNotifierProvider(create: (context) => SwitchModeProvider()),
        ChangeNotifierProvider(create: (context) => WordProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => GameProvider()),
        ChangeNotifierProvider(create: (context) => TranslationProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => HandlerButtonProvider()),
        ChangeNotifierProvider(create: (context) => ClickedButtonListProvider()),
      ],
      child: Consumer<SwitchModeProvider>(builder: (context, value, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: value.themeData,
          title: 'Learning_App',
          home: Login(),
        );
      }),
    );
  }
}
