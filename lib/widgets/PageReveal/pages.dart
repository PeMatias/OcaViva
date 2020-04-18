import 'package:flutter/material.dart';
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/screens/desafioPage.dart';
import 'package:ocaviva/services/jogo_service.dart';
import 'package:ocaviva/widgets/SwipeAnimation/index.dart';
import 'package:ocaviva/widgets/botao.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:random_color/random_color.dart';


List<DesafioList> desafioPages;

//var ocaviva = carregaJogo(1);


//final pages=[
   //new PageViewModel(Colors.blue, Icons.phone, Icons.contacts, desafioPages.last.desafio , "Contact"),

   //new PageViewModel(Colors.red, Icons.chat_bubble, Icons.chat, desafioPages[1].desafio, "Chat"),

  //new PageViewModel(Colors.green, Icons.hotel, Icons.home, desafioPages[2].desafio, "Home"),

//];



class Page extends StatelessWidget {

  final PageViewModel viewModel;
  final double percentVisible;
Page({this.viewModel,this.percentVisible=1.0});

  @override
  Widget build(BuildContext context) {
     RandomColor _randomColor = RandomColor();

      Color _color = _randomColor.randomColor(colorHue: ColorHue.blue);
    return new Container(
      width: double.infinity,
      //color: viewModel.color,
      //color: _color,
      child: new Opacity(
        opacity: percentVisible,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

           new Transform(
             child: new Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: CircleAvatar(
                    backgroundImage: ExactAssetImage(viewModel.desafioList.imagem),
                    minRadius: 50,
                    maxRadius: 90,
                  ),
                
                /*child: new Icon(
                  viewModel.iconName,
                  size: 150.0,
                  color: Colors.white,
                ),*/
              ),
             transform: new Matrix4.translationValues(0.0, 50.0*(1.0-percentVisible), 0.0),
           ),

            /*new Transform(
              transform: new Matrix4.translationValues(0.0, 30.0*(1.0-percentVisible), 0.0),
              child: new Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 10.0),
                child: new Text(
                  viewModel.title,
                  style: new TextStyle(fontSize: 34.0, color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
            ),*/
            new Transform(
              transform: new Matrix4.translationValues(0.0, 30.0*(1.0-percentVisible), 0.0),

              child: new Padding(
                //padding: const EdgeInsets.only(bottom:75.0),
                padding:  EdgeInsets.all(22),
                child: new Column(
                  children: <Widget>[
                        new Texto(conteudo: viewModel.desafioList.desafio ,tamFonte: 18.0),
                        new SizedBox(height: 15,),
                        new FlatButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => 
                          CardDemo(problemas: viewModel.desafioList.problemaList, desafios: viewModel.desafioList,) ) ),
                          child: Botao(conteudo: "INICIAR O DESAFIO", tamFonte: 18.0),)
                         
                        
                  ],
                )
                
              ),
            )
          ],
        ),
      ),
    );
  }
}


class PageViewModel{
  final Color color;
  final IconData iconName;
  final String title;
  final IconData iconAssetIcon;
  final DesafioList desafioList;
  PageViewModel(this.color,this.iconAssetIcon,this.iconName,this.title,this.desafioList);
}