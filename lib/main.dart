import 'package:flutter/material.dart';
import 'fitur/login_and_regist/auth_prov.dart';
import 'fitur/login_and_regist/login.dart';
import 'fitur/profile/provider/profil_prov.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fitur/profile/provider/switchProvider.dart';

import 'fitur/Challanges/Sentences/beginner/_servicesBeginner.dart';
import 'fitur/Challanges/Sentences/intermediate/_servicesintermediate.dart';
import 'fitur/Challanges/Sentences/advance/_servicesiAdvance.dart';
import 'fitur/Challanges/myDictionary/_Provider.dart';

// import 'Home.dart';

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
        ChangeNotifierProvider(create: (_) => ProfilProv()),
        ChangeNotifierProvider(create: (_) => SwitchModeProvider()),
        ChangeNotifierProvider(
          create: (context) => BeginnerButtonListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => IntermediateButtonListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdvanceButtonListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WordProvider(),
        ),
        ChangeNotifierProvider(create: (context) => AuthProvider())
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
