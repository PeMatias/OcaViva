import 'package:flutter/material.dart';
import 'package:ocaviva/widgets/texto.dart';

class CampoEntrada extends StatelessWidget 
{
  final String titulo;
  //final double tamFonte;
  final String textoDica;
  final IconData icone;
  bool isPassword = false;
  final TextEditingController controller;
  final FocusNode focusNode;
  CampoEntrada
  ({
    Key key,
    @required this.titulo,
    @required this.textoDica,
    @required this.icone,
    @required this.isPassword,
    @required this.controller,
    @required this.focusNode,
  })
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container
    (
      width: MediaQuery.of(context).size.width /1.2,
      padding: EdgeInsets.symmetric(vertical: 11),
      margin: EdgeInsets.symmetric(vertical: 0.3),
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>
        [
          Texto(tamFonte: 18.0, conteudo: titulo,),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            style: TextStyle(color: Colors.white,fontSize: 16.0, fontFamily: "GoogleFonts.quantico",fontWeight: FontWeight.bold),
            obscureText: isPassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide( style: BorderStyle.none, )
              ),
            fillColor: Colors.yellow[700],
            filled: true,
            hintText: "Digite "+ textoDica,
            prefixIcon: Icon(icone),
            hintStyle: TextStyle(color: Colors.white),
            ),
            initialValue: null,
            validator: (value) => value.isEmpty ? 'Campo não pode ficar vazio' : null,
          )  
        ],
      ),
    );
  }

 
}