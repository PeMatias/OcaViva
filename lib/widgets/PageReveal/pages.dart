import 'package:flutter/material.dart';
import 'package:ocaviva/main.dart';
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/screens/desafioPage.dart';
import 'package:ocaviva/widgets/PageReveal/page_main.dart';

import 'package:ocaviva/widgets/SwipeAnimation/index.dart';
import 'package:ocaviva/widgets/botao.dart';
import 'package:ocaviva/widgets/circular_chart.dart';
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

  var slidePercent;
Page({this.viewModel,this.percentVisible=1.0});

  @override
  Widget build(BuildContext context) {
     //RandomColor _randomColor = RandomColor();

     // Color _color = _randomColor.randomColor(colorHue: ColorHue.blue);
      var _score = userAuth.usuario.score[viewModel.fase-1];
    return new Container(
      width: double.infinity,
      //color: viewModel.color,
     // color: _color,
      child: new Opacity(
        opacity: percentVisible,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           (viewModel.intro) ? SizedBox(height: 1,)
           :Container(child: Row(
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
                  (activeIndex > 1 )?Icon(Icons.arrow_back_ios, color: Colors.yellow[800] ) :  SizedBox(width: 20,),   
                  SizedBox(width: 20,),
                  (viewModel.intro) ? CircleAvatar(
                    backgroundColor: Colors.yellow[800] ,
                    child: Icon(viewModel.iconName,semanticLabel: "Sobre a fase",),
                    minRadius: 30,
                    maxRadius: 30,
                  )
                  :CircleAvatar(
                    backgroundImage: ExactAssetImage(viewModel.desafioList.imagemfeedback),
                    radius: 70,
                    //minRadius: 1,
                    //maxRadius: 10,
                    //child:Image.asset(viewModel.desafioList.imagemfeedback),
                  ),
                   (activeIndex < desafioPages.length )? SizedBox(width: 20,):SizedBox(width: 0,),
                  (activeIndex < desafioPages.length)? Icon(Icons.arrow_forward_ios, color: Colors.yellow[800] ) :  SizedBox(width: 20,),
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
                    
                        (viewModel.intro)? SingleChildScrollView(child:
                        Container(
                          height: MediaQuery.of(context).size.height*0.5,
                         child: Texto(conteudo: "Você sabe o que são os sistemas do corpo?\nE para que servem?\nNas pessoas saudáveis eles têm de funcionar como uma linha de produção. Em total sincronia e completa interdependência.\n\nAgora, para que tudo funcione harmoniosamente, você tem que fazer sua parte.\n\n No sistema digestivo, o processo começa com a quebra dos alimentos na boca e continua por longo caminho até a absorção, esses alimentos são as políticas públicas da sua OcaViva e em cada etapa da digestão um desafio é apresentado.\n Bom trabalho!",tamFonte: 16,)),
                        )
                        :Texto(conteudo: viewModel.desafioList.desafio ,tamFonte: 16.0),
                        SizedBox(height: 20,),
                        (viewModel.intro)?
                        new FlatButton(
                          
                          onPressed: () { 
                            Center(child: CircularProgressIndicator());
                            Navigator.pop(context);
                            activeIndex++;

                            Navigator.push(context,  MaterialPageRoute(builder: (context) => DesafioPage(fase: 1,score: score,)));},
                          child: Botao(conteudo: "CONTINUAR", tamFonte: 18.0),)
                        
                        : new FlatButton(
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
  final bool intro;
  PageViewModel(this.fase,this.color,this.iconAssetIcon,this.iconName,this.title,this.desafioList,this.intro);
}