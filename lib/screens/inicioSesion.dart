import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listaImagenes = [
      Image.asset("assets/librito.png"),
      Image.asset("assets/liro2.png")
    ];
    return Scaffold(
      backgroundColor: Color(0xFF191919),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 85,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "  Bienvenido\n  Puedes iniciar sesion\n  o registrarte con google",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CarouselSlider(
                      items: listaImagenes,
                      options: CarouselOptions(
                        height: 250,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 950),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      )),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: TextButton.icon(
                        onPressed: () async {
                          await signinGoogle();
                          Navigator.pushReplacementNamed(context, 'inicio');
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                          color: Color(0xFFDB6400),
                        ),
                        label: const Text(
                          "Iniciar sesion con google",
                          style: TextStyle(color: Color(0xFFDB6400)),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: Text(
                      "¿Aun no tienes una cuenta?",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: TextButton.icon(
                        onPressed: () async {
                          await signinGoogle();
                          Navigator.pushReplacementNamed(context, 'intro');
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                          color: Color(0xFFC5D7BD),
                        ),
                        label: const Text("Registrarse con google")),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<UserCredential> signinGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleauth =
      await googleUser!.authentication;
  final credential = GoogleAuthProvider.credential(
      idToken: googleauth.idToken, accessToken: googleauth.accessToken);
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
