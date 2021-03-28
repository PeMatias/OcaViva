
import 'package:flutter/material.dart';
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/screens/home_page.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/circular_chart.dart';
import 'package:ocaviva/widgets/texto.dart';



import '../texto2.dart';



Positioned cardDemo(
    //Box pontuacao,
    String imagem,
    AnimatedRadialChartExample score,
    ProblemaList img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context,
    Function dismissImg,
    int flag,
    Function addImg,
    Function swipeRight,
    Function swipeLeft,
    ) {
  Size screenSize = MediaQuery.of(context).size;
  // print("Card");
  return new Positioned(
    bottom: 9.0 ,
    right: flag == 0 ? right != 0.0 ? right : null : null,
    left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Dismissible(
      key: new Key( img.problema.toString()),
      crossAxisEndOffset: -0.3,
      onResize: () {
        //print("here");
        // setState(() {
        //   var i = data.removeLast();

        //   data.insert(0, i);
        // });
        
      },
      onDismissed: (DismissDirection direction) {
        //swipeAnimation();
        
        if (direction == DismissDirection.endToStart)
        {
          dismissImg(img);
          print("Pontos: "+img.respostaList[0].ponto.toString());
        }
        else
        {
          addImg(img);
         print("Pontos: "+img.respostaList[1].ponto.toString());
        }
              },
              child: new Transform(
                alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
                //transform: null,
                transform: new Matrix4.skewX(skew),
                //..rotateX(-math.pi / rotation),
                child: new RotationTransition(
                   turns: new AlwaysStoppedAnimation( -rotation / 360),
                  /*turns: new AlwaysStoppedAnimation(
                      flag == 0 ? rotation / 360 : -rotation / 360),*/
                  child: new Hero(
                    tag: img.problema.toString(),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //Texto2(conteudo: "Estado de saúde\n da OcaViva:", tamFonte: 12),
                            //Container(child: score,),
                          ],
                        ),
                     
                    
                    new GestureDetector(

                      child: new Card(
                        
                        elevation: 30.0,
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width-30,
                          height: screenSize.height*0.435,
                          padding: EdgeInsets.symmetric(horizontal: 3,vertical: 1),
                          //margin: EdgeInsets.symmetric(horizontal: 10),
                          //margin: EdgeInsets.symmetric(vertical:1),
                          color: (!isDark)? Colors.blue[900] : Colors.black26,
                          child:                              
                              new Stack(
                                //mainAxisAlignment: MainAxisAlignment.end,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                
                                children: <Widget>[
                                  //BodyBackground(),
                                  SingleChildScrollView( child:
                                  Column(
                                    
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      

                                  Texto(conteudo: img.problema.toString(), tamFonte: 15), 
                                  SizedBox(height: 4,),
                                  Container( 
                                    width: MediaQuery.of(context).size.width-30 ,
                                    color: (!isDark)? Colors.yellow[800]: Colors.yellow[900],
                                    child:Texto(conteudo:"O que você fará?",tamFonte: 14,)),
                                  SizedBox(height: 4,),
                                  new RaisedButton(
                                     color: Colors.black45,
                                     highlightColor: Colors.blue[900] ,
                                      shape:RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(18.0),
                                      ) ,
                                    
                                      padding: new EdgeInsets.all(8.0),
                                      onPressed: () {
                                        //dismissImg(img);
                                        swipeLeft(img);
                                      },
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(Icons.arrow_back_ios, color: Colors.white,size: 45,),
                                          Expanded(child: Texto3(conteudo:img.respostaList[0].resposta,tamFonte: 14.0,)),                                               
                                        ],
                                      )
                                      ),
                                      SizedBox(height: 15,),
                                    new RaisedButton(
                                      color: Colors.black45,
                                     highlightColor: Colors.blue[900] ,
                                     shape:RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(18.0),
                                      ) ,
                                    
                                      padding: new EdgeInsets.all(8.0),
                                      onPressed: () {

                                        swipeRight(img);
                                        
                                      },
                                      
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                         
                                          Expanded(child: Texto3(conteudo:img.respostaList[1].resposta,tamFonte: 14.0,)),
                                          Icon(Icons.arrow_forward_ios, color: Colors.white,size: 45,),                                               
                                        ],
                                      )
                                      ),
                                    SizedBox(height: 15,),
                                ]
                              ),),
                                ]
                              )
                           
                        ),
                      ),
                    ),
                      ]
                    )
                  ),
                ),
              ),
            ),
          );
        }


        
