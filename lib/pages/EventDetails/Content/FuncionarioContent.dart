import 'package:flutter/material.dart';

class FuncionarioContent extends StatelessWidget {
  final int numero;
  final String nome;

  const FuncionarioContent({
    Key? key,
    this.numero = 0,
    this.nome = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: <Widget>[
          Text(numero.toString(),
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF0D1333).withOpacity(.5),
                fontWeight: FontWeight.bold,
              )),
          SizedBox(width: 20),
          Container(
            child: Expanded(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: nome,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF0D1333),
                        fontWeight: FontWeight.w600,
                        height: 1.5))
              ])),
            ),
          ),
        ],
      ),
    );
  }
}
