import 'package:flutter/material.dart';
import 'package:pruebafire/constants.dart';

class note extends StatelessWidget {
  final String titulo, contenido, fecha;
  const note(
      {Key? key,
      required this.titulo,
      required this.contenido,
      required this.fecha})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              "Fecha de creacion: ",
              style: estiloFecha,
            ),
            Text(
              fecha,
              style: estiloFecha,
            ),
          ],
        ),
        const Divider(
          thickness: 1,
          color: Color(0xFFff7b00),
        ),
        Text(
          titulo,
          style: estiloTitulo,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          contenido,
          style: estilocontenido,
        )
      ],
    );
  }
}
