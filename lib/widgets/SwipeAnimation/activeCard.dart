import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/widgets/SwipeAnimation/detail.dart';
import 'package:ocaviva/widgets/SwipeAnimation/index.dart';
import 'package:ocaviva/widgets/texto.dart';

import '../texto2.dart';


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
    Function swipeLeft) {
  Size screenSize = MediaQuery.of(context).size;
  // print("Card");
  return new Positioned(
    bottom: 100.0 + bottom,
    right: flag == 0 ? right != 0.0 ? right : null : null,
    left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Dismissible(
      key: new Key(new Random().toString()),
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
                  dismissImg(img);
                else
                  addImg(img);
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
                    child: new GestureDetector(
                      onTap: () {/*
                         Navigator.push(
                             context,
                             new MaterialPageRoute(
                                 builder: (context) => new DetailPage(type: img)));
                        Navigator.of(context).push(new PageRouteBuilder(
                              pageBuilder: (_, __, ___) => new DetailPage(type: img),
                            ));*/
                      },
                      child: new Card(
                        color: Colors.transparent,
                        elevation: 4.0,
                        child: new Container(
                          alignment: Alignment.center,
                          width: screenSize.width  + cardWidth,
                          height: screenSize.height /1.5,
                          decoration: new BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: new BorderRadius.circular(8.0),
                            image: new DecorationImage(
                                          image: new ExactAssetImage('assets/images/fundo-1.png'),
                                          fit: BoxFit.cover,
                                        ),
                          ),
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                width: screenSize.width / 1.2 + cardWidth,
                                height: screenSize.height /4,
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.only(
                                      topLeft: new Radius.circular(8.0),
                                      topRight: new Radius.circular(8.0)),
                                      
                                ),
                                child: Texto(conteudo: img.problema.toString(), tamFonte: 18), 
                                margin: EdgeInsets.all(10)
                              ),
                              new Container(
                                  width: screenSize.width /0.8 + cardWidth,
                                  height:
                                      screenSize.height / 1.5 - screenSize.height /2.5,
                                  alignment: Alignment.center,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      new FlatButton(
                                          padding: new EdgeInsets.all(0.0),
                                          onPressed: () {
                                            swipeLeft();
                                          },
                                          child: new Container(
                                            height: 75.0,
                                            width: screenSize.width/1.3,
                                            alignment: Alignment.center,
                                            decoration: new BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  new BorderRadius.circular(60.0),
                                            ),
                                            child: new Text(
                                              img.respostaList[0].resposta,
                                              style: new TextStyle(color: Colors.white),
                                            ),
                                          )),
                                      new FlatButton(
                                          padding: new EdgeInsets.all(0.0),
                                          onPressed: () {
                                            swipeRight();
                                          },
                                          child: new Container(
                                            height: 60.0,
                                            width: 130.0,
                                            alignment: Alignment.center,
                                            decoration: new BoxDecoration(
                                              color: Colors.cyan,
                                              borderRadius:
                                                  new BorderRadius.circular(60.0),
                                            ),
                                            child: new Text(
                                              img.respostaList[1].resposta,
                                              style: new TextStyle(color: Colors.white),
                                            ),
                                          ))
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }


        
