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
        backgroundColor: Color(0xFF1A1A2E),
        appBar: AppBar(
          title: const Text(
            "Add Note",
            style: TextStyle(color: Color(0xFFDDDDDD)),
          ),
          actions: [
            TextButton.icon(
                label: const Text(
                  "Save",
                  style: TextStyle(color: Color.fromARGB(255, 8, 128, 175)),
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
                  color: Color.fromARGB(255, 13, 163, 209),
                ))
          ],
          backgroundColor: Color(0xFF1A1A2E),
          elevation: 0,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
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
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    prefixIcon: const Icon(Icons.title),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black26,
              thickness: 2,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                maxLines: null,
                minLines: 10,
                keyboardType: TextInputType.multiline,
                controller: contenido,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orangeAccent),
                decoration: InputDecoration(
                  hintText: 'Content',
                  prefixIcon: Icon(
                    Icons.text_snippet_sharp,
                    // color: Colors.white,
                  ),
                  filled: true,
                  alignLabelWithHint: true,
                  fillColor: Colors.white,
                  prefixIconColor: Colors.red,
                  border: InputBorder.none,
                  focusColor: Colors.red,
                  focusedBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
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
