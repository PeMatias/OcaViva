import 'dart:async';


import 'package:flutter/material.dart';
import 'package:ocaviva/services/jogo_service.dart';
import 'package:ocaviva/widgets/PageReveal/page_dragger.dart';
import 'package:ocaviva/widgets/PageReveal/page_indicator.dart';
import 'package:ocaviva/widgets/PageReveal/page_reveal.dart';
import 'package:ocaviva/widgets/PageReveal/pages.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:random_color/random_color.dart';

SlideUpdate event;
int activeIndex2;
int activeIndex = 0;
int maxDesafio = 0;
String habilidade="";

class PageMain extends StatefulWidget {
  PageMain({this.fase});
  final int fase;
  String titulo;
  
  @override
  PageMainState createState() => new PageMainState();
}

class PageMainState extends State<PageMain> with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPagedragger animatedPagedragger;

  
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;
  

  PageMainState() {
    slideUpdateStream = new StreamController<SlideUpdate>();
    

    slideUpdateStream.stream.listen((event) {
      setState(() {
        /*if(proxDesafio)
        {
          print("entrei");
          slideDirection = SlideDirection.leftToRight;
          slidePercent = event.slidePercent;
          nextPageIndex = activeIndex + 1;
          proxDesafio = false;
        }
        else */if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }

//         nextPageIndex=slideDirection==SlideDirection.leftToRight ? activeIndex-1 : activeIndex+1;
//
//         nextPageIndex.clamp(0.0, pages.length-1);
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            animatedPagedragger = new AnimatedPagedragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );

//           activeIndex=slideDirection==SlideDirection.leftToRight ? activeIndex-1 : activeIndex+1;
//           activeIndex.clamp(0.0, pages.length-1);
          } else {
            animatedPagedragger = new AnimatedPagedragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
            nextPageIndex = activeIndex;
          }
          animatedPagedragger.run();

//         slideDirection=SlideDirection.none;
//       slidePercent=0.0;

        } else if (event.updateType == UpdateType.doneAnimating) {
          activeIndex = nextPageIndex;
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;
          animatedPagedragger.dispose();
        }
      });
    });
  }
  

  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages=[];
    RandomColor _randomColor = RandomColor();
   

    Color _color = _randomColor.randomColor(colorHue: ColorHue.blue);
   
    // print(slidePercent);
    switch (widget.fase) {
    case 1:{
      widget.titulo = "Sistema Digestório";
    }
    break;
    default:{ widget.titulo = "Invalid choice"; } 
  }
  
    
    return (new Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Texto(conteudo: widget.titulo, tamFonte:18.0),
      ),
      extendBodyBehindAppBar: true,
        body: new FutureBuilder(
              future: carregaJogo(widget.fase),
              builder: (BuildContext context,ocaviva) {
                
                while (ocaviva.connectionState==null || !ocaviva.hasData || ocaviva.data.desafioList==null)
                  return  const Center(child: CircularProgressIndicator(),);
                
                int item = 0;
                print(ocaviva.data.desafioList.length);
                //pages.addAll(ocaviva.data.desafioList)  ;
                
                while(item < ocaviva.data.desafioList.length) {
                        
                  pages.insert(item, new PageViewModel(widget.fase, _color, Icons.timer, Icons.contacts, "Desafio", ocaviva.data.desafioList[item],false));
                  item++;
                }
                print(pages.length);
                
                while((ocaviva.data.desafioList.length)!= pages.length)
                  pages.removeLast();
                print(pages.length);
                maxDesafio = pages.length;
                habilidade = ocaviva.data.habilidades;
                pages.insert(0,new PageViewModel(widget.fase, _color, Icons.timer, Icons.lightbulb_outline, "Desafio",  ocaviva.data.desafioList[0],true) );
                
               
                /*pages = [
                  new PageViewModel(Colors.blue, Icons.timer, Icons.contacts,  "Desafio", ocaviva.data.desafioList[0]),
                  new PageViewModel(Colors.red, Icons.phone, Icons.contacts,  "Contact", ocaviva.data.desafioList[1]),
                  new PageViewModel(Colors.green, Icons.phone, Icons.contacts,  "Contact", ocaviva.data.desafioList[2]),
                  



                ];*/
                
                return new Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        BodyBackground(),
                        new Page(
                          viewModel: pages[activeIndex],
                          percentVisible: 1.0,
                        ),             
                        new PageReveal(
                          revealPercent: slidePercent,
                          child: new Page(
                            viewModel: pages[nextPageIndex],
                            percentVisible: slidePercent,
                          ),
                        ),
                        new PagerIndicator(
                          viewModel: new PagerIndicatorViewModel(
                              slideDirection, activeIndex, pages, slidePercent),
                        ),
                        new PageDragger(
                          canDragLeftToRight: activeIndex > 1,
                          canDragRightToLeft:(activeIndex != 0)? (activeIndex +1 < ocaviva.data.desafioList.length): false ,
                          slideUpdateSytream: this.slideUpdateStream,
                        )
                      ],
                    );
              }
            ),
    ));
  }
}
