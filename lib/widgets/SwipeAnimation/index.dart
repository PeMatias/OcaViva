import 'dart:async';

//import 'package:animation_exp/PageReveal/page_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:ocaviva/models/jogo.dart';
import 'package:ocaviva/widgets/SwipeAnimation/activeCard.dart';
import 'package:ocaviva/widgets/SwipeAnimation/data.dart';
import 'package:ocaviva/widgets/SwipeAnimation/dummyCard.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/circular_chart.dart';
import 'package:ocaviva/widgets/texto2.dart';

class CardDemo extends StatefulWidget {
  CardDemo({this.problemas});
   List<ProblemaList> problemas;


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

 
  List selectedData = [1];
  void initState() {
    super.initState();
    data = widget.problemas;

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

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

  Future<Null> swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  dismissImg(ProblemaList img) {
    setState(() {
      data.remove(img);
    });
  }

  addImg(ProblemaList img) {
    setState(() {
      data.remove(img);
      //selectedData.add(img);
    });
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.5;

    double initialBottom = 15.0;
    var dataLength = data.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -50.0;
    return (new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
           backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: new Container(
            margin: const EdgeInsets.all(15.0),
            child: new Icon(
              Icons.equalizer,
              color: Colors.indigo,
              size: 30.0,
            ),
          ),
          actions: <Widget>[
            new GestureDetector(
              onTap: () {

              },
              child: new Container(
                  margin: const EdgeInsets.all(15.0),
                  child: new Icon(
                    Icons.search,
                    color: Colors.indigo,
                    size: 30.0,
                  )),
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
                    color: Colors.red, shape: BoxShape.circle),
              )
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
        children: <Widget>[
          BodyBackground(),
         new Container(
          //color: Colors.blue[800],
          //color: Colors.blueAccent[200],
          alignment: Alignment.center,
          child: dataLength > 0
              ? new Stack(
                  alignment: AlignmentDirectional.center,
                  //children: data.map((item) {
                    children: data.map((item) {
                    //print(widget.data.indexOf(item).toString()+"\n"+dataLength.toString());
                    if (data.indexOf(item) != null  ) {
                      return cardDemo(
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
                          swipeLeft);
                    } else {
                      //backCardPosition = backCardPosition - 10;
                      //backCardWidth = backCardWidth + 10;
                     // return cardDemoDummy(item, backCardPosition, 0.0, 0.0,backCardWidth, 0.0, 0.0, context);
                    }
                  }).toList())
              : new Text("Fim do desafio",
                  style: new TextStyle(color: Colors.white, fontSize: 45.0)),
        ),],)));
  }
}
