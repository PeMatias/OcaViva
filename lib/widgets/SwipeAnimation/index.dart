import 'dart:async';

//import 'package:animation_exp/PageReveal/page_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:hive/hive.dart';
import 'package:ocaviva/main.dart';
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/screens/home_page.dart';
import 'package:ocaviva/widgets/PageReveal/page_main.dart';
import 'package:ocaviva/widgets/SwipeAnimation/activeCard.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/circular_chart.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:ocaviva/widgets/texto2.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';



AnimatedRadialChartExample score =  new AnimatedRadialChartExample(value: 50,);
bool proxDesafio;
bool lido = false;



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
  int desempenho;

   List<ProblemaList> data;
  Box<Usuario> database; 

  List selectedData = [1];
  void initState() {
    userAuth.getFromFirestore();

    super.initState();
    data = widget.problemas;
    desempenho = userAuth.usuario.score[fase];
    database = Hive.box<Usuario>('users');
   
 
    

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 300), vsync: this);

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
          if(data.length > 0)
          {
            var i = data.removeLast();
            data.insert(0, i);
          }

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
   
    //duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
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
      //var valor = //database.get('score',defaultValue: 50.0) + img.respostaList[0].ponto*10;
      //var valor = score.value + img.respostaList[0].ponto*5;
      userAuth.usuario.score[fase]+= img.respostaList[0].ponto*5;
      var key = userAuth.usuario.email+userAuth.usuario.senha;
      database.put(key, userAuth.usuario);
      userAuth.updateFromFirestore(userAuth.usuario);
      score = new AnimatedRadialChartExample(value:userAuth.usuario.score[fase]);
     if(lido == false)
      {
        
        var esquerdo = "No canto superior esquerdo temos uma breve descrição das habilidades da BNCC e do ODS correspondente ao desafio";
        showToast(esquerdo, gravity: Toast.TOP, duration: Toast.LENGTH_SHORT)  ;
        //Timer(Duration(seconds: 3), () {
        
        var direito = "No canto direito temos uma aba de pesquisa para ajudar nas dúvidas";
         showToast(direito, gravity: Toast.TOP, duration: Toast.LENGTH_SHORT)  ;
          lido = true;
        //});
      }

    });
  }

  addImg(ProblemaList img) {
    setState(() {
      data.remove(img);
      //var valor = //database.get('score',defaultValue: 50.0) + img.respostaList[1].ponto*10;
      ////database.put('score',valor);
      // var valor = score.value + img.respostaList[1].ponto*5;
      userAuth.usuario.score[fase]+= img.respostaList[1].ponto*5;
      score = new AnimatedRadialChartExample(value: userAuth.usuario.score[fase]);
      var key = userAuth.usuario.email+userAuth.usuario.senha;
      database.put(key, userAuth.usuario);
      userAuth.updateFromFirestore(userAuth.usuario);
      //score =  new AnimatedRadialChartExample(value: 50,);
      if(lido == false)
      {
        var esquerdo = "← No canto superior esquerdo temos uma descrição da BNCC e do ODS correspondente ao desafio";
        showToast(esquerdo, gravity: Toast.TOP, duration: Toast.LENGTH_LONG)  ;
        /*Timer(Duration(seconds: 3), () {*/
        var direito = "No canto direito temos uma aba de pesquisa para ajudar nas dúvidas →";
        showToast(direito, gravity: Toast.TOP, duration: Toast.LENGTH_LONG)  ;
        lido = true;
        /*});*/
      }
      
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
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity, backgroundColor: Colors.blue[900]);
  }


  @override
  Widget build(BuildContext context) {
    //userAuth.usuario.score// = //database.getAt(userAuth.indice).score;
    score = new AnimatedRadialChartExample(value: userAuth.usuario.score[fase]);
    //AnimatedRadialChartExample score_novo =  new AnimatedRadialChartExample(value: score.value,);
    timeDilation = 0.35;
    
    

    //double initialBottom = 15.0;
    var dataLength = data.length;
    double backCardWidth = -50.0;
    return (new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
           backgroundColor: Colors.blue[900],
          centerTitle: true,
          leading: InkWell(
            child: new Container(
            margin: const EdgeInsets.all(15.0),
            child: new Icon(
              Icons.description,
              color:Colors.yellow[800] ,
              size: 30.0,
              semanticLabel: "Descrição da BNCC e da ODS",
            ),
          ),
          
          onTap: (){ 
            showDialog(context: context,
            builder: (BuildContext context)
            {
              return AlertDialog(
                title: Text("O que você está aprendendo", style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.w700),),
                content: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                  "ODS trabalhada:\n"+
                  widget.desafios.desc+
                  "\nHABILIDADES DA BNCC:\n"+
                  habilidade,
                  textAlign: TextAlign.left, style: TextStyle(fontSize: 15,),),),
                actions: <Widget>[
                  FlatButton(onPressed: (){
                     Navigator.push(context, new MaterialPageRoute(builder: (context) => new WebView(initialUrl: widget.desafios.ods,
                    javascriptMode: JavascriptMode.unrestricted, ))); } , child: Text("Ler mais sobre o ODS")),
                  FlatButton(onPressed: (){ Navigator.pop(context);} , child: Text("OK")),
                  
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
                    color: Colors.yellow[800] ,
                    size: 30.0,
                    semanticLabel: "Pesquisar no Google",
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
                    color: Colors.yellow[800] , shape: BoxShape.circle),
              )
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
        children: <Widget>[
          BodyBackground(),          
         new Container(
          alignment: Alignment.bottomCenter,
          child: dataLength > 0
              ? new Stack(
                  alignment: AlignmentDirectional.topCenter,
                    children:<Widget>[
                      SizedBox.fromSize( 
                          size: Size(
                            MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height*.55
                          ),
                          child: Image.asset(widget.desafios.imagem,fit:BoxFit.cover),),
                    Align(
                      alignment: Alignment.center,
                    child: Container(
                      height: 80,
                      color: Colors.black45,
                      child: Row(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Texto(conteudo: "Estado de saúde do sistema:", tamFonte: 18),
                      score,
                    ],
                  )
                  ),), 
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children:
                    data.map((item) {
                    
                      return 
                      cardDemo(
                          //database,
                          widget.desafios.imagem,
                          score,
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
                 
                  }).toList())
                  ])
              : new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: 60,),
                  Texto(conteudo:"Fim do desafio",tamFonte:18),
                  Container(child: Row(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Texto2(conteudo: "Saúde desse sistema\nna OcaViva:", tamFonte: 18),
                      score
                    ],
                  )
                  ), 
                  
                  Container(
                    color: Colors.black12,
                    margin: EdgeInsets.symmetric(horizontal:8),
                    height: MediaQuery.of(context).size.height*.55,
                    child:  SingleChildScrollView(
                          child: Column(children: <Widget>[
                      Align(alignment: Alignment.centerLeft, child: Texto(conteudo: "Relatório do desafio:", tamFonte: 16),),

                      SizedBox.fromSize(
                        size: Size(200,150),
                        child: Image.asset(widget.desafios.imagemfeedback,fit:BoxFit.cover),),
                        (score.value > desempenho) ? 
                         Texto(conteudo:widget.desafios.feedbackList[0].resposta,tamFonte:14)
                        : Texto(conteudo:widget.desafios.feedbackList[1].resposta,tamFonte:14),
                    ],
                    ))
                  ),
                  
                  /*CircleAvatar(
                    backgroundImage: ExactAssetImage(widget.desafios.imagemfeedback,scale:20),
                    backgroundColor: Colors.blueAccent,
                    minRadius: 10,
                    maxRadius: 30,
                  ),*/                  
                  SizedBox(height: 15,),
                   FlatButton(
                     onPressed: (){ userAuth.updateFromFirestore(userAuth.usuario); Navigator.pop(context);} , 
                     child: Row(  
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[  
                         Container(
                           child:Icon(Icons.menu, color: Colors.yellow[800] ,size: 40, ),
                           decoration: new  BoxDecoration(
                            border: Border.all(color: Colors.yellow[800] , width: 3),
                            shape: BoxShape.circle,
                           ),
                         ),             
                         SizedBox(width: 20,),
                         Texto3(conteudo: "Menu de desafios",tamFonte: 16),
                       ],

                     ),
                   ),
                   SizedBox(height: 15,),
                   FlatButton(
                     onPressed: (){
                       userAuth.updateFromFirestore(userAuth.usuario);
                        if(activeIndex+1< maxDesafio)
                        {
                          Navigator.pop(context ); 
                          activeIndex+=1 ;
                          proxDesafio = true;
                        }
                        else
                        {
                           Navigator.of(context).pushNamed("/home");
                           activeIndex=0;
                        } 
                     }, 
                     
                     child: Row(  
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[  
                         Container(
                           child:Icon(Icons.skip_next, color: Colors.yellow[800] ,size: 40, ),
                           decoration: new  BoxDecoration(
                            border: Border.all(color: Colors.yellow[800] , width: 3),
                            shape: BoxShape.circle,
                           ),
                         ),             
                         SizedBox(width: 20,),
                         
                           
                         
                         (activeIndex+1) < maxDesafio ? Texto3(conteudo: "Próximo desafio",tamFonte: 20) :  Texto3(conteudo: "Menu de Fases",tamFonte: 20),
                       ],

                     ),
                   ),
                    SizedBox(height: 15,),
                   //SizedBox(height: 15,),
                   /*FlatButton(
                     onPressed: (){ 
                       score_novo.value = score.value;
                          Navigator.push(context,
                           MaterialPageRoute(builder: (_) =>
                           CardDemo(problemas: widget.problemas, desafios:widget.desafios,),
                           )
                           );                          
                          } , 
                     child: Row(  
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[  
                         Container(
                           child:Icon(Icons.refresh, color: Colors.yellow[800] ,size: 40, ),
                           decoration: new  BoxDecoration(
                            border: Border.all(color: Colors.yellow[800] , width: 3),
                            shape: BoxShape.circle,
                           ),
                         ),             
                         SizedBox(width: 20,),
                         Texto3(conteudo: "Refazer esse desafio",tamFonte: 18),
                       ],

                     ),
                   ),*/
                ]
              ))
        ),],)));
  }
}
