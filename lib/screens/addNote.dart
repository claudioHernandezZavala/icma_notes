import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addnote extends StatelessWidget {
  TextEditingController titulo = new TextEditingController();
  TextEditingController contenido = new TextEditingController();
  CollectionReference referenciaBase =
      FirebaseFirestore.instance.collection("notes");
  User? user = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return Scaffold(
        backgroundColor: Color(0xFF30475E),
        appBar: AppBar(
          title: const Text(
            "Agregar Nota",
            style: TextStyle(color: Color(0xFFDDDDDD)),
          ),
          actions: [
            TextButton.icon(
                label: const Text(
                  "Guardar",
                  style: TextStyle(color: Color(0xFF222831)),
                ),
                onPressed: () {
                  CollectionReference referenciaBase2 = FirebaseFirestore
                      .instance
                      .collection("notes/" + user!.uid + "/notas");

                  final key2 = _formKey.currentState;
                  if (key2!.validate()) {
                    referenciaBase2
                        .add({
                          "title": titulo.text,
                          "contenido": contenido.text,
                          'fecha de creacion': Timestamp.now()
                        })
                        .whenComplete(() =>
                            ScaffoldMessenger.of(context).showSnackBar(snack()))
                        .whenComplete(() => Navigator.pop(context));
                  }
                },
                icon: const Icon(
                  Icons.cloud_upload,
                  color: Color(0xFF222831),
                ))
          ],
          backgroundColor: Color(0xFFF05454),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Debe escribir un texto';
                  }
                  return null;
                },
                controller: titulo,
                maxLines: null,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    color: Colors.deepOrange),
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Titulo',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: const Icon(Icons.title),
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
            const Divider(
              color: Colors.black26,
              thickness: 2,
            ),
            Center(
              child: TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: contenido,
                style: TextStyle(color: Colors.orangeAccent),
                decoration: InputDecoration(
                    hintText: 'Contenido',
                    prefixIcon: Icon(
                      Icons.text_snippet_sharp,
                      // color: Colors.white,
                    ),
                    prefixIconColor: Colors.red,
                    border: InputBorder.none,
                    focusColor: Colors.red,
                    focusedBorder: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                    enabledBorder: InputBorder.none,
                    hintMaxLines: 10),
              ),
            ),
          ],
        ));
  }
}

SnackBar snack() {
  return SnackBar(
      backgroundColor: Colors.green,
      content: Row(
        children: const [
          Icon(
            Icons.thumb_up,
            color: Colors.white,
          ),
          SizedBox(
            width: 15,
          ),
          Text("Agregado con exito"),
        ],
      ));
}
