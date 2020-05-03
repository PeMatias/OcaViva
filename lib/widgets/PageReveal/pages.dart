import 'package:flutter/material.dart';
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/screens/desafioPage.dart';
import 'package:ocaviva/screens/loginPage.dart';
import 'package:ocaviva/services/jogo_service.dart';
import 'package:ocaviva/widgets/PageReveal/page_dragger.dart';
import 'package:ocaviva/widgets/PageReveal/page_main.dart';
import 'package:ocaviva/widgets/PageReveal/page_indicator.dart';

import 'package:ocaviva/widgets/SwipeAnimation/index.dart';
import 'package:ocaviva/widgets/botao.dart';
import 'package:ocaviva/widgets/circular_chart.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:ocaviva/widgets/texto2.dart';
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

  var slidePercent;
Page({this.viewModel,this.percentVisible=1.0});

  @override
  Widget build(BuildContext context) {
     RandomColor _randomColor = RandomColor();

      Color _color = _randomColor.randomColor(colorHue: ColorHue.blue);
      var _score = userAuth.usuario.score[viewModel.fase-1];
    return new Container(
      width: double.infinity,
      //color: viewModel.color,
      //color: _color,
      child: new Opacity(
        opacity: percentVisible,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(child: Row(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Texto(conteudo: "Estado de saúde do\n sistema da sua ocaviva:", tamFonte: 18),
                      new AnimatedRadialChartExample(value: _score),
                    ],
                  )
                  ), 

           new Transform(
             child: new Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: 
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  (activeIndex > 0 )?Icon(Icons.arrow_back_ios, color: Colors.amber) :  SizedBox(width: 20,),   
                  SizedBox(width: 20,),
                  CircleAvatar(
                    backgroundImage: ExactAssetImage(viewModel.desafioList.imagem),
                    minRadius: 50,
                    maxRadius: 90,
                  ),
                   (activeIndex < desafioPages.length-1 )? SizedBox(width: 20,):SizedBox(width: 0,),
                  (activeIndex < desafioPages.length-1 )? Icon(Icons.arrow_forward_ios, color: Colors.amber) :  SizedBox(width: 20,),
                ]
              )
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    
                        Texto(conteudo: viewModel.desafioList.desafio ,tamFonte: 15.0),
                        SizedBox(height: 20,),
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
  final int fase;
  final Color color;
  final IconData iconName;
  final String title;
  final IconData iconAssetIcon;
  final DesafioList desafioList;
  PageViewModel(this.fase,this.color,this.iconAssetIcon,this.iconName,this.title,this.desafioList);
}