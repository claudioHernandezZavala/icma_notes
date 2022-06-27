import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class drawer extends StatelessWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF1A1A2E),
      child: ListView(
        children: [
          DrawerHeader(
              child: Row(
            children: [
              Image.asset(
                'assets/logofinal.png',
                height: 150,
                width: 150,
              ),
              Text(
                "ICMA notes",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          )),
          ListTile(
            title: const Text("Cerrar sesion",
                style: TextStyle(color: Colors.black, fontSize: 15)),
            tileColor: Colors.white,
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('login');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text("Seguridad de mis datos",
                style: TextStyle(color: Colors.black, fontSize: 15)),
            tileColor: Colors.white,
            leading: Icon(
              Icons.security_outlined,
              color: Colors.orange,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('infodatos');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const ListTile(
            title: Text("Compartir app",
                style: TextStyle(color: Colors.black, fontSize: 15)),
            tileColor: Colors.white,
            leading: Icon(
              Icons.share,
              color: Colors.green,
            ),
          ),
          const ListTile(
            title: Text(
              "Todos los derechos reservados",
              style: TextStyle(color: Colors.grey),
            ),
            subtitle: Text("Ilustraciones gracias a Agurame",
                style: TextStyle(color: Colors.grey)),
          )
        ],
      ),
    );
  }
}
