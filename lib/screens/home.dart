import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pruebafire/screens/editnote.dart';
import 'package:pruebafire/widgets/drawer.dart';
import 'package:pruebafire/widgets/noteWidget.dart';

import 'addNote.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      drawer: const drawer(),
      appBar: AppBar(
        title: const Text("Tus notas"),
        centerTitle: true,
        backgroundColor: const Color(0xDDDDDD),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFff7b00),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => addnote()));
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("notes/" + user!.uid + "/notas")
            .snapshots(includeMetadataChanges: true),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Column(
              children: [
                Image.asset("assets/noConexion.png"),
                const Text(
                  "Algo salio mal\n comprueba tu conexion a internet",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.size == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/empty.png",
                    height: 300,
                    width: 300,
                  ),
                  const Text(
                    "No tienes notas aun",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Slidable(
                  actions: [
                    IconSlideAction(
                      foregroundColor: const Color(0xFFFF5200),
                      caption: "Eliminar",
                      color: const Color(0xFF8C0000),
                      icon: Icons.delete,
                      onTap: () {
                        document.reference.delete();
                      },
                    ),
                    IconSlideAction(
                      caption: "Modificar",
                      color: const Color(0xFF007965),
                      icon: Icons.mode_edit,
                      foregroundColor: const Color(0xFF00A1AB),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => edits(
                                titulo: data['title'],
                                contenido: data['contenido'],
                                referencia: document.reference)));
                      },
                    )
                  ],
                  actionPane: const SlidableDrawerActionPane(),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                            color: Color(0xFFff7b00), width: 2),
                      ),
                      color: const Color(0xFF212f45),
                      elevation: 20,
                      shadowColor: const Color(0xFFffd000),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: note(
                              titulo: data['title'],
                              contenido: data['contenido'],
                              fecha: DateFormat('dd-MM-yyyy')
                                  .format(data['fecha de creacion'].toDate())
                                  .toString()))),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
