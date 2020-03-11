import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/models/pontos.dart';
import 'package:ocaviva/widgets/SwipeAnimation/detail.dart';
import 'package:ocaviva/widgets/SwipeAnimation/index.dart';
import 'package:ocaviva/widgets/circular_chart.dart';
import 'package:ocaviva/widgets/texto.dart';



import '../texto2.dart';


AnimatedRadialChartExample score = AnimatedRadialChartExample();

Positioned cardDemo(
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
    Function swipeLeft
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
                         Container(child: score,),
                    new GestureDetector(

                      child: new Card(
                        
                        elevation: 4.0,
                        child: Column(
                          //alignment: Alignment.bottomCenter,
                        children: <Widget>[
                       
                       
                        new Container(
                          alignment: Alignment.center,
                          width: screenSize.width  + cardWidth,
                          height: screenSize.height /1.4,
                          decoration: new BoxDecoration(
                            color: Colors.blueAccent[900],
                            borderRadius: new BorderRadius.circular(8.0),
                            image: new DecorationImage(
                                          image: new ExactAssetImage('assets/images/fundo-1.png'),
                                          colorFilter: new ColorFilter.mode(Colors.blue[300].withOpacity(1), BlendMode.dstATop),
                                          fit: BoxFit.cover,
                                        ),
                          ),
                          child: new Stack(
                            children: <Widget>[
                              new Container(
                                width: screenSize.width,
                                //height: 125,
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.only(
                                      topLeft: new Radius.circular(8.0),
                                      topRight: new Radius.circular(8.0)),
                                      //color: Colors.cyan[100]
                                ),
                                child: 
                                Texto(conteudo: img.problema.toString(), tamFonte: 18), 
                                //Text(img.problema.toString(),,),
                                 //margin: EdgeInsets.only(),
                                 margin: EdgeInsets.only(left: 10, right: 10,top: 5) ,
                               // margin: EdgeInsets.all(30)
                              ),
                             
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                                                 Container(
                                    width: screenSize.width,
                                    decoration: new BoxDecoration(
                                           color: Colors.orange[100],
                                    ),
                                    child: Texto2(conteudo: "Como você resolverá isso?", tamFonte: 15),
                                  ),
                                  SizedBox(height: 30,),
                                  new RaisedButton(
                                      color: Colors.transparent,
                                      padding: new EdgeInsets.all(8.0),
                                      onPressed: () {
                                        //score.createState()
                                        dismissImg(img);
                                        swipeLeft();
                                       
                                      },
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                           Icon(Icons.arrow_back, color: Colors.white,size: 50,),
                                          Expanded(child: Texto3(conteudo:img.respostaList[0].resposta,tamFonte: 16.0,)),                                               
                                        ],
                                      )
                                      ),
                                      SizedBox(height: 30,),
                                    new RaisedButton(
                                      color: Colors.transparent,
                                      padding: new EdgeInsets.all(8.0),
                                      onPressed: () {
                                        addImg(img);
                                        swipeRight();
                                        
                                      },
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                         
                                          Expanded(child: Texto3(conteudo:img.respostaList[1].resposta,tamFonte: 16.0,)),
                                          Icon(Icons.arrow_forward, color: Colors.white,size: 50,),                                               
                                        ],
                                      )
                                      ),
                                    SizedBox(height: 30,),
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


        
