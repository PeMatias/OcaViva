import 'dart:async';

//import 'package:animation_exp/PageReveal/page_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:hive/hive.dart';
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/screens/loginPage.dart';
import 'package:ocaviva/widgets/PageReveal/page_dragger.dart';
import 'package:ocaviva/widgets/PageReveal/page_indicator.dart';
import 'package:ocaviva/widgets/PageReveal/page_main.dart';
import 'package:ocaviva/widgets/SwipeAnimation/activeCard.dart';
import 'package:ocaviva/widgets/SwipeAnimation/data.dart';
import 'package:ocaviva/widgets/SwipeAnimation/dummyCard.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/circular_chart.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:ocaviva/widgets/texto2.dart';
import 'package:webview_flutter/webview_flutter.dart';


AnimatedRadialChartExample score =  new AnimatedRadialChartExample(value: 50,);
Box<Usuario> boxUsers = Hive.box<Usuario>('users');
bool proxDesafio;



class CardDemo extends StatefulWidget {
  CardDemo({this.problemas , this.desafios});
   List<ProblemaList> problemas;
   DesafioList desafios;


  @override
  CardDemoState createState() => new CardDemoState();
}

class CardDemoState extends State<CardDemo> with TickerProviderStateMixin {
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;

   List<ProblemaList> data;

  Box database;    
  List selectedData = [1];
  void initState() {
    super.initState();
    data = widget.problemas;
    bool proxDesafio = false;
   // database = Hive.box('jogo');
   // var valor = database.get('score',defaultValue: 50.0);
   if( boxUsers.getAt(userAuth.indice).score == null)
      userAuth.usuario.score = 50.0;
    else
       userAuth.usuario.score = boxUsers.getAt(userAuth.indice).score;
    score = new AnimatedRadialChartExample(value: userAuth.usuario.score);
    

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 400), vsync: this);

    rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = data.removeLast();
          data.insert(0, i);

          _buttonController.reset();
        }
      });
    });

    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> swipeAnimation(ProblemaList img) async {
   
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
    

  }

  dismissImg(ProblemaList img) {
    setState(() {
      data.remove(img);
      //var valor = database.get('score',defaultValue: 50.0) + img.respostaList[0].ponto*10;
      //var valor = score.value + img.respostaList[0].ponto*5;
      userAuth.usuario.score+= img.respostaList[0].ponto*5;
      boxUsers.putAt(userAuth.indice, userAuth.usuario);
      userAuth.updateFromFirestore(userAuth.usuario);
      //database.put('score',valor);
      score = new AnimatedRadialChartExample(value:userAuth.usuario.score);

    });
  }

  addImg(ProblemaList img) {
    setState(() {
      data.remove(img);
      //var valor = database.get('score',defaultValue: 50.0) + img.respostaList[1].ponto*10;
      //database.put('score',valor);
      // var valor = score.value + img.respostaList[1].ponto*5;
      userAuth.usuario.score+= img.respostaList[1].ponto*5;
      score = new AnimatedRadialChartExample(value: userAuth.usuario.score);
      boxUsers.putAt(userAuth.indice, userAuth.usuario);
      userAuth.updateFromFirestore(userAuth.usuario);
      //score =  new AnimatedRadialChartExample(value: 50,);
      
      //selectedData.add(img);
    });
  }

  swipeRight(ProblemaList img) {
    
    if (flag == 0)
      setState(() {
         
        flag = 1;
       
      });
       addImg(img);
    swipeAnimation(img);
  }

  swipeLeft(ProblemaList img) {
    if (flag == 1)
      setState(() {
        flag = 0;
       
      });
       dismissImg(img);
    swipeAnimation(img);
  }

  @override
  Widget build(BuildContext context) {
    AnimatedRadialChartExample score_novo =  new AnimatedRadialChartExample(value: score.value,);
    timeDilation = 0.35;

    double initialBottom = 15.0;
    var dataLength = data.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -50.0;
    return (new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
           backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: InkWell(
            child: new Container(
            margin: const EdgeInsets.all(15.0),
            child: new Icon(
              Icons.description,
              color:Colors.amberAccent,
              size: 30.0,
            ),
          ),
          onTap: (){
            showDialog(context: context,
            builder: (BuildContext context)
            {
              return AlertDialog(
                title: Text("Descrição do desafio", style: TextStyle(fontSize: 18, color: Colors.deepPurple),),
                content: Text(widget.desafios.desafio, style: TextStyle(fontSize: 14),),
                actions: <Widget>[
                  FlatButton(onPressed: (){ Navigator.pop(context);} , child: Text("OK"))
                ],
              );
            }
            );
          },
          ),
          actions: <Widget>[
            new GestureDetector(
              onTap: () {

              },
              child: new InkWell(
                child:Container(
                  margin: const EdgeInsets.all(15.0),
                  child: new Icon(
                    Icons.search,
                    color: Colors.amberAccent,
                    size: 30.0,
                  ),
                ),
                onTap: (){
                   Navigator.push(context, new MaterialPageRoute(builder: (context) => new WebView(initialUrl: 'https://www.google.com.br',
                    javascriptMode: JavascriptMode.unrestricted, ))); 
                                     
                } 
                ),
            ),
          ],
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Texto2(conteudo: "PROBLEMAS", tamFonte: 18),
              new Container(
                width: 21.0,
                height: 21.0,
                margin: new EdgeInsets.only(bottom: 20.0),
                alignment: Alignment.center,
                child: new Texto2( conteudo: data.length.toString(), tamFonte: 15.0),
                decoration: new BoxDecoration(
                    color: Colors.amberAccent, shape: BoxShape.circle),
              )
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
        children: <Widget>[
          BodyBackground(),
         new Container(
          alignment: Alignment.center,
          child: dataLength > 0
              ? new Stack(
                  alignment: AlignmentDirectional.center,
                  //children: data.map((item) {
                    children: data.map((item) {
                    //print(widget.data.indexOf(item).toString()+"\n"+dataLength.toString());
                    if (data.indexOf(item) != null   ) {
                      return cardDemo(
                          database,
                          widget.desafios.imagem,
                          score_novo,
                          item,
                          bottom.value,
                          right.value,
                          0.0,
                          backCardWidth + 10,
                          rotate.value,
                          rotate.value < -10 ? 0.1 : 0.0,
                          context,
                          dismissImg,
                          //swipeLeft,
                          flag,
                          addImg,
                          //swipeRight,
                          swipeRight,
                          swipeLeft,
                          );
                    } else {
                      
                      //backCardPosition = backCardPosition - 10;
                      //backCardWidth = backCardWidth + 10;
                     // return cardDemoDummy(item, backCardPosition, 0.0, 0.0,backCardWidth, 0.0, 0.0, context);
                    }
                  }).toList())
              : new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Texto(conteudo:"Fim do desafio",tamFonte:45),
                  Container(child:score), 
                  SizedBox(height: 20,),
                   FlatButton(
                     onPressed: (){ Navigator.pop(context); score = score_novo;} , 
                     child: Row(  
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[  
                         Container(
                           child:Icon(Icons.menu, color: Colors.amberAccent,size: 45, ),
                           decoration: new  BoxDecoration(
                            border: Border.all(color: Colors.amberAccent, width: 3),
                            shape: BoxShape.circle,
                           ),
                         ),             
                         SizedBox(width: 20,),
                         Texto3(conteudo: "Menu de desafios",tamFonte: 18),
                       ],

                     ),
                   ),
                   SizedBox(height: 15,),
                   FlatButton(
                     onPressed: (){ Navigator.pop(context ); activeIndex+=1; proxDesafio = true;} , 
                     child: Row(  
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[  
                         Container(
                           child:Icon(Icons.skip_next, color: Colors.amberAccent,size: 45, ),
                           decoration: new  BoxDecoration(
                            border: Border.all(color: Colors.amberAccent, width: 3),
                            shape: BoxShape.circle,
                           ),
                         ),             
                         SizedBox(width: 20,),
                         Texto3(conteudo: "Próximo desafio",tamFonte: 18),
                       ],

                     ),
                   ),
                   SizedBox(height: 15,),
                   FlatButton(
                     onPressed: (){ 
                          //data = widget.problemas;
                          //score_novo = score;

                          setState(() {
                            data = widget.problemas;
                            this.build(context);
                            
                          });
                          this.build(context);
                          
                       // CardDemo(problemas: widget.desafios.problemaList, desafios: widget.desafios)));
                          
                           } , 
                     child: Row(  
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[  
                         Container(
                           child:Icon(Icons.refresh, color: Colors.amberAccent,size: 45, ),
                           decoration: new  BoxDecoration(
                            border: Border.all(color: Colors.amberAccent, width: 3),
                            shape: BoxShape.circle,
                           ),
                         ),             
                         SizedBox(width: 20,),
                         Texto3(conteudo: "Refazer esse desafio",tamFonte: 18),
                       ],

                     ),
                   ),
                ]
              )
        ),],)));
  }
}
