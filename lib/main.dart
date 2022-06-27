import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pruebafire/screens/addNote.dart';
import 'package:pruebafire/screens/informacionDatos.dart';
import 'package:pruebafire/screens/inicioSesion.dart';
import 'package:pruebafire/screens/intro.dart';
import 'package:pruebafire/themes.dart';

import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    myThemes t = myThemes();
    return MaterialApp(
        title: 'Notas',
        themeMode: ThemeMode.system,
        darkTheme: t.darkTheme,
        routes: {
          'login': (context) => login(),
          'inicio': (context) => home(),
          'addNote': (context) => addnote(),
          'intro': (context) => onboard(),
          'infodatos': (context) => infoMisDatos()
        },
        debugShowCheckedModeBanner: false,
        theme: t.light,
        home: iniciar());
  }
}

Widget iniciar() {
  if (FirebaseAuth.instance.currentUser == null) {
    return login();
  } else {
    return home();
  }
}
