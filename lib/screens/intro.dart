import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class onboard extends StatefulWidget {
  const onboard({Key? key}) : super(key: key);

  @override
  _onboardState createState() => _onboardState();
}

class _onboardState extends State<onboard> {
  late LiquidController liquidcontroller;

  @override
  void initState() {
    liquidcontroller = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFF121212),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logofinal.png",
              height: 300,
              width: 300,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Bienvenido a ICMA notes",
              style: TextStyle(fontSize: 20, color: Color(0xFFFC9918)),
            )
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFF370665),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/ilustacionOnoard.png",
              height: 300,
              width: 300,
            ),
            const Text(
              "  En ICMA notes podras escribir\n  cosas importantes y guardarlas\n  en la nube!",
              style: TextStyle(fontSize: 20, color: Color(0xFFFC9918)),
            )
          ],
        ),
      ),
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xFF810034),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/noConexion.png",
                height: 300,
                width: 300,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  "  Recuerda que la aplicacion \n  necesita de conexion a internet\n  para guardar y cargar tus notas!",
                  style: TextStyle(fontSize: 20, color: Color(0xFFFC9918)))
            ],
          ))
    ];

    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
              waveType: WaveType.liquidReveal,
              enableLoop: false,
              enableSideReveal: true,
              slideIconWidget: const Icon(Icons.arrow_forward_ios),
              liquidController: liquidcontroller,
              pages: pages),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'inicio');
                },
                child: const Text("iniciar"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
