import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class edits extends StatefulWidget {
  final String titulo, contenido;
  final DocumentReference referencia;
  const edits(
      {Key? key,
      required this.titulo,
      required this.contenido,
      required this.referencia})
      : super(key: key);

  @override
  _editsState createState() => _editsState();
}

class _editsState extends State<edits> {
  TextEditingController titulo = TextEditingController();
  TextEditingController contenido = TextEditingController();

  CollectionReference referenciaBase =
      FirebaseFirestore.instance.collection("notes");
  User? user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    titulo = TextEditingController(text: widget.titulo);
    contenido = TextEditingController(text: widget.contenido);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF30475E),
        appBar: AppBar(
          title: const Text(
            "Editar Nota",
            style: TextStyle(color: Color(0xFFDDDDDD)),
          ),
          backgroundColor: const Color(0xFFF05454),
          actions: [
            TextButton.icon(
                onPressed: () {
                  final key2 = _formKey.currentState;
                  if (key2!.validate()) {
                    widget.referencia
                        .set(
                            {'title': titulo.text, 'contenido': contenido.text},
                            SetOptions(merge: true))
                        .whenComplete(() =>
                            ScaffoldMessenger.of(context).showSnackBar(snack()))
                        .whenComplete(() => Navigator.pop(context));
                  }
                },
                icon: const Icon(
                  Icons.save,
                  color: Color(0xFF222831),
                ),
                label: const Text(
                  "Guardar cambios",
                  style: TextStyle(color: Color(0xFF222831)),
                ))
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
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
                keyboardType: TextInputType.multiline,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                    color: Colors.deepOrange),
                decoration: InputDecoration(
                  hintText: 'titulo',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                  prefixIcon: Icon(Icons.text_fields),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
              child: Divider(
                thickness: 1,
              ),
            ),
            TextFormField(
              maxLines: null,
              style: TextStyle(color: Colors.orangeAccent, fontSize: 19),
              keyboardType: TextInputType.multiline,
              controller: contenido,
              decoration: const InputDecoration(
                hintText: 'Contenido',
                prefixIcon: Icon(Icons.text_snippet_sharp),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
            const SizedBox(
              height: 50,
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
          Text("Editado con exito"),
        ],
      ));
}
