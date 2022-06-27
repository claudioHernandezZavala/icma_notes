import 'package:flutter/material.dart';
import 'package:pruebafire/constants.dart';

class infoMisDatos extends StatelessWidget {
  const infoMisDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 950;
    final lista = [
      Card(
        shadowColor: Color(0xFFffd000),
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFFff7b00), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                "assets/firebase.png",
                height: 67,
              ),
              SizedBox(height: 30),
              Text(
                "Tus datos van a Firestore,base de datos de google.",
                style: estiloLetraSeguridad,
              )
            ],
          ),
        ),
      ),
      Card(
        shadowColor: Color(0xFF7DEDFF),
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFF1E3163), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset("assets/wifi.png"),
              SizedBox(
                height: 20,
              ),
              Text(
                "Todas tus notas van a internet, por lo que no dependen de tu almacenamiento local.",
                style: estiloLetraSeguridad,
              )
            ],
          ),
        ),
      ),
      Card(
        shadowColor: Color(0xFFFA1E0E),
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFFFA1E0E), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset("assets/gmail.png"),
              SizedBox(height: 30),
              Text(
                "Tus notas se guardan segun tu correo,asi que no te preocupes si cierras sesion.",
                style: estiloLetraSeguridad,
              )
            ],
          ),
        ),
      ),
      Card(
        shadowColor: Color(0xFF06FF00),
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFF00AF91), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset("assets/mobile-app.png"),
              SizedBox(height: 30),
              Text(
                "No importa si cambias de celular, solo necesitas tu correo y tus notas estaran ahi.",
                style: estiloLetraSeguridad,
              )
            ],
          ),
        ),
      )
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Seguridad de datos"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Tus datos estan seguros!",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                  color: Colors.black),
            ),
            Image.asset(
              'assets/seguridad.png',
              height: 180,
              width: 260,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 20,
                      childAspectRatio: height),
                  children: lista,
                ),
              ),
            ),
          ],
        ));
  }
}
