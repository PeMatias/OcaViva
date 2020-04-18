import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/widgets/circular_chart.dart';
import 'package:ocaviva/widgets/texto.dart';



import '../texto2.dart';



Positioned cardDemo(
    Box pontuacao,
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
    bottom: 10.0 + bottom,
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
                            Texto2(conteudo: "Estado de saúde\n da OcaViva:", tamFonte: 16),
                            Container(child: score,),
                          ],
                        ),
                     
                   

                    new GestureDetector(

                      child: new Card(
                        
                        elevation: 10.0,
                        child: Column(
                        children: <Widget>[
                       
                        new Container(
                          alignment: Alignment.center,
                          width: screenSize.width  + cardWidth,
                          height: screenSize.height /1.47,
                          decoration: new BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: new BorderRadius.circular(8.0),
                            image: new DecorationImage(
                                          image: new ExactAssetImage(imagem),
                                          colorFilter: new ColorFilter.mode(Colors.deepPurple.withOpacity(0.8), BlendMode.dstATop),
                                          fit: BoxFit.fill
                                        ),
                          ),
                          child: new Stack(
                            children: <Widget>[
                                new Container(
                                width: screenSize.width  + cardWidth,
                              
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.only(
                                      topLeft: new Radius.circular(8.0),
                                      topRight: new Radius.circular(8.0)),
                                      //color: Colors.cyan[100]
                                      //color: Colors.transparent,
                                ),
                                child: 
                                Texto(conteudo: img.problema.toString(), tamFonte: 16), 
                                margin: EdgeInsets.only(left: 10, right: 10,top: 5) ,
                               // margin: EdgeInsets.all(30)
                              ),
                              
                             
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                /*Container(
                                    width: screenSize.width,
                                    decoration: new BoxDecoration(
                                           color: Colors.yellow[100],
                                    ),
                                    child: Text("Como você resolverá isso?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black
                                    ),),
                                  ),*/
                                  SizedBox(height: 30,),
                                  new RaisedButton(
                                     color: Colors.black45,
                                     highlightColor: Colors.deepPurple,
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
                                      SizedBox(height: 30,),
                                    new RaisedButton(
                                      color: Colors.black45,
                                     highlightColor: Colors.deepPurple,
                                     shape:RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(18.0),
                                      ) ,
                                    
                                      padding: new EdgeInsets.all(8.0),
                                      onPressed: () {
                                        //scoreKey.currentState.atualiza(10);
                                        //addImg(img);
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
                              ),
                            ],
                          ),
                        ),
                        ]
                        )
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


        
