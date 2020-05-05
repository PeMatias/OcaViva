import 'dart:async';
import 'dart:developer';
import 'dart:io';


import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ocaviva/main.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/screens/desafioPage.dart';
import 'package:ocaviva/screens/welcomePage.dart';
import 'package:ocaviva/widgets/SwipeAnimation/index.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/circular_chart_copy.dart';
import 'package:ocaviva/widgets/fase.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:ocaviva/widgets/texto2.dart';
import 'package:avataaar_image/avataaar_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';
  


var estado = conectividade();
int position = 0;
int currentPage = 0;
  PageController _pageController;

final avatar = Avataaar.random();

Box<Usuario> boxUsers2 = Hive.box<Usuario>('users');






class HomePage extends StatefulWidget {
 @override
    HomeState createState() {
    return new HomeState();
  }
}
int  fase=0;
class HomeState extends State<HomePage>
{


  @override
  void initState() 
  {
     
    

    
 
        
    super.initState();
    _pageController = PageController();    

  }

   @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  
  Drawer getNavDrawer(BuildContext context) {
    //var headerChild = DrawerHeader(child: Text("Header"));
    var iniciais = userAuth.usuario.nome.split(" ");
    var circle = "";
    for (var item in iniciais) {
      circle+= item[0] ;      
    }
    var headerChild = UserAccountsDrawerHeader(
      accountName: Text(userAuth.usuario.nome),
      accountEmail: Text(userAuth.usuario.email),
      currentAccountPicture: CircleAvatar(
      backgroundColor:
        Theme.of(context).platform == TargetPlatform.iOS
            ? Colors.blue
            : Colors.blue,
      child: //Icon(Icons.videocam),
      //(conectividade2() != false) ? Texto(conteudo: circle, tamFonte: 45,) :
      AvataaarImage(
          avatar: /*Avataaar(
  skin: Skin.pale,
  style: Style.circle,
  top: Top.noHair(),),*/
 avatar,
              errorImage: Icon(Icons.error),
              placeholder: CircularProgressIndicator(),
              width: 100.0,
            ),

      /*Text(
          circle,
        style: TextStyle(fontSize: 40.0),
      ),*/
    ),
    );

    var aboutChild = AboutListTile(
        child: Text("Sobre"),
        applicationName: "OCAVIVA",
        applicationVersion: "v0.0.1",
        applicationIcon: Icon(Icons.adb),
        icon: Icon(Icons.info));

    

    ListTile getNavItem(var icon, String s, String routeName,bool sair) {
      return ListTile(
        leading: Icon(icon),
        title: Text(s),
        onTap: () {
          setState(() async {
            // pop closes the drawer
            Navigator.of(context).pop();
            // navigate to the route
            Navigator.of(context).pushNamed(routeName);
            if(sair == true){
              userAuth.logoutAccount();
              Timer(Duration(seconds: 3), () {
                userAuth.usuario = null;});
            }
          });
        },
      );
    }
    
   
    var myNavChildren = [
      headerChild,      
      estado,
      //getNavItem(Icons.settings, "Configurações", "/home"),
      //getNavItem(Icons.home, "Home", "/tinder"),
      getNavItem(Icons.account_box, "Perfil", "/perfil",false),
      getNavItem(Icons.person_add, "Novo Usuário", "/registro", false),
      getNavItem(Icons.exit_to_app, "Encerrar sessão", "/login", true),

      ListTile(
        leading: Icon(Icons.rate_review),
        title: Text("Avaliação"),
        onTap: (){
          userAuth.usuario.aluno ?
                   Navigator.push(context, new MaterialPageRoute(builder: (context) => new WebView(initialUrl: 'https://docs.google.com/forms/d/17ItUbRLnGIDLYemPKD9ORYlSrqUhda9i3NbJV2hKLZI/viewform?edit_requested=true',
                    javascriptMode: JavascriptMode.unrestricted, )))
                  :Navigator.push(context, new MaterialPageRoute(builder: (context) => new WebView(initialUrl: 'https://docs.google.com/forms/d/1d5OmwuR8uVCqiDSvO_ZIxX9Qad6O3Y6OI0AD8xGdCx8/viewform?edit_requested=true',
                    javascriptMode: JavascriptMode.unrestricted, ))) ; 
        }
      ),
      aboutChild,
      
    ];

    ListView listView = ListView(children: myNavChildren);

    
  
    return Drawer(
   
      child: listView,
    );
  }
  Widget homePrincipal(BuildContext context)
 {
   
  
  
  Size screenSize = MediaQuery.of(context).size;
  double screenHeigth = screenSize.height;
  double score_geral = 0;
  if(userAuth.usuario != null)
  {
    for (var item in userAuth.usuario.score) {
      score_geral+= item;      
    }
    score_geral = score_geral/userAuth.usuario.score.length;
  }
   return Stack(
        children: <Widget>[
          BodyBackground(),        
          Center(
            child:
            
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  //fit: FlexFit.tight,
                  flex: 2,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: <Widget>[
                  InkWell(
                    onTap: () { fase = 0;Navigator.push(context, MaterialPageRoute(builder: (context) => DesafioPage(fase: 1,score: score,) ) ); },
                    child: Fase(asset: 'assets/images/digestorio.png',fase: 0, legenda: "Sistema \nDigestório"),
                  ) ,
                   InkWell(
                    //onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => DesafioPage(fase: 2,score: score,) ) ); },
                    child: Fase(asset: 'assets/images/circulatorio.png',fase: 1, legenda: "Sistema \nCirculatório"),
                  ) ,                     
                   //Fase(asset: 'assets/images/respiratorio.png', legenda: "Sistema Respiratório"),
                  //Fase(asset: 'assets/images/excretor.png', legenda: "Sistema Excretor"),
                  InkWell(
                    //onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => DesafioPage(fase: 3,) ) ); },
                    child: Fase(asset: 'assets/images/esqueletico.png',fase: 2, legenda: "Sistema \nEsquelético"),
                  ) , 
                  InkWell(
                    //onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => DesafioPage(fase: 4,) ) ); },
                    child:  Fase(asset: 'assets/images/muscular.png',fase: 3, legenda: "Sistema \nMuscular"),
                  ) ,
                  InkWell(
                    //onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) =>DesafioPage(fase: 5,)) ); },
                    child: Fase(asset: 'assets/images/nervoso.png',fase: 4, legenda: "Sistema\nNervoso"),
                  ) ,
                  //Fase(asset: 'assets/images/endocrino.png', legenda: "Sistema Endócrino"),
                      
                ],
              ),
            ),
            Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Texto2(conteudo: "Quadro geral de\n saúde da OcaViva:", tamFonte: 17),

                    Container(child:AnimatedRadialChartExampleDouble(value:score_geral),),
                  ],
                ),
              ],
            ),
          ),
        ]
      );
}

  Widget homePrincipal2(BuildContext context)
{
  //if(userAuth.fullNamesFromFirestore.length == 0)
  userAuth.getFromFirestore(); 
  List<Usuario> comunidade = [];
  List<double> comunidadeScore=[];
  for (var item in userAuth.fullNamesFromFirestore) {
    if(item.escola == userAuth.usuario.escola)
    {
      comunidade.add(item);
      double aux = 0;
      for (var score in item.score) {
        aux+=score;
      }
      aux = aux/item.score.length;
      comunidadeScore.add(aux);
    }

    
  }
  

   return Stack(
        children: <Widget>[
          BodyBackground(), 
          //Align( child: Texto(conteudo: userAuth.usuario.escola,tamFonte: 18,), alignment: Alignment.topCenter,),
          //SizedBox(height:60),
          Column(
            children: <Widget>[
         // child: //SingleChildScrollView()
              SizedBox(height:60),
              Align( child: Texto(conteudo: userAuth.usuario.escola,tamFonte: 20,), alignment: Alignment.center,),
             ListView.builder(         
                  scrollDirection: Axis.vertical, 
                  shrinkWrap: true,
                  itemCount: comunidade.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: (comunidade[index].nome!= userAuth.usuario.nome) ? AvataaarImage(
                              avatar: Avataaar(
                                skin: Skin.darkBrown,
                                top: Top.random,
                                style: Style.circle,),//Avataaar.random(),
                              errorImage: Icon(Icons.error),
                              placeholder: CircularProgressIndicator(),
                              width: 47.0,
                            ): AvataaarImage(
                              avatar: avatar,
                              errorImage: Icon(Icons.error),
                              placeholder: CircularProgressIndicator(),
                              width: 47.0, ) ,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width*0.3,
                            child:Texto3(conteudo:comunidade[index].nome, tamFonte: 14,)),
                          SizedBox(width: 6,),
                          Container(
                            //width: MediaQuery.of(context).size.width*0.2,
                            alignment: Alignment.center,
                            color: (comunidadeScore[index]< 0)? Colors.red:(comunidadeScore[index]<50) ? Colors.amber
                              : (comunidadeScore[index]<100)? Colors.lightBlue : Colors.lightGreen,

                            child:Texto(conteudo: "\t"+comunidadeScore[index].toString()+"\t",tamFonte: 13,)
                         ),
                         SizedBox(width: 5,),
                         Container(
                           alignment: Alignment.centerLeft,
                            //width: MediaQuery.of(context).size.width*0.2,
                            child: 
                          (comunidadeScore[index]< 0)? Texto3(conteudo: "Está internado",tamFonte: 10,)
                              :(comunidadeScore[index]<50) ?Texto3(conteudo: "Está Doente",tamFonte: 10,)
                              : (comunidadeScore[index]<100)?Texto3(conteudo: "Melhorando,\nimunidade baixa",tamFonte: 10,)
                              : Texto3(conteudo: "Está Saudável",tamFonte: 10,),
                         )
                        ],
                      )
                      
                      /*leading: Container(
                        width: MediaQuery.of(context).size.width*0.6,
                        alignment: Alignment.centerLeft,
                        child: Row(
                        children: <Widget>[
                          AvataaarImage(
                              avatar: Avataaar.random(),
                              errorImage: Icon(Icons.error),
                              placeholder: CircularProgressIndicator(),
                              width: 50.0,
                            ),
                            Align(alignment: Alignment., child:
                            Expanded(child:Texto3(conteudo:comunidade[index].nome, tamFonte: 16,)),
                          ])
                        ),
                      
                      title: Container(
                        width: MediaQuery.of(context).size.width*0.2,
                        color: (comunidade_score[index]< 0)? Colors.red:(comunidade_score[index]<50) ? Colors.amber
                          : (comunidade_score[index]<100)? Colors.lightBlue : Colors.lightGreen,

                        child:Texto(conteudo: comunidade_score[index].toString(),tamFonte: 14,)),
                        
                      trailing: Container(
                        width: MediaQuery.of(context).size.width*0.3,
                        child: 
                       (comunidade_score[index]< 0)? Texto(conteudo: "    Está internado",tamFonte: 12,)
                          :(comunidade_score[index]<50) ? Texto(conteudo: "     Está Doente",tamFonte: 12,)
                          : (comunidade_score[index]<100)?Texto(conteudo: "Melhorando,\nimunidade baixa",tamFonte: 12,) 
                          : Texto(conteudo: "    Está Saudável",tamFonte: 12,),
                      ), */
                      
                    );
                  },
            )
             ] )
        ]              
      );
}





  
    void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity, backgroundColor: Colors.deepPurpleAccent);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeigth = screenSize.height;
     estado = conectividade();
    
    //var valor = score.value;//database.get('score',defaultValue: 50.0);
    //else
    //valor = boxUsers.getAt(userAuth.indice).score;
    //score = new AnimatedRadialChartExample(value: valor);
    

    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: (currentPage ==0) ? Texto(conteudo:"Bem vindo à sua OCAVIVA", tamFonte:18.0): Texto(conteudo:"Panorama da Comunidade", tamFonte:18.0),
      ),
      extendBodyBehindAppBar: true,
      body: (currentPage ==0) ? homePrincipal(context) : homePrincipal2(context),
     
      // Set the nav drawer
      drawer: getNavDrawer(context),
     /* bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text('Item One'),
            icon: Icon(Icons.home)
          ),
          BottomNavyBarItem(
            title: Text('Item One'),
            icon: Icon(Icons.apps)
          ),
          BottomNavyBarItem(
            title: Text('Item One'),
            icon: Icon(Icons.chat_bubble)
          ),
          BottomNavyBarItem(
            title: Text('Item One'),
            icon: Icon(Icons.settings)
          ),
        ],
      ),*/
      bottomNavigationBar:
       FancyBottomNavigation(
         //barBackgroundColor: Colors.transparent,
    tabs: [
        TabData(iconData: Icons.home, title: "Principal"),
        TabData(iconData: Icons.school, title: "Comunidade"),
    ],
    onTabChangedListener: (position) {
        setState(() {
          print(currentPage);
        currentPage = position;
        if(currentPage == 0)
          showToast("Menu das fases da OcaViva", duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
        else
          showToast("OcaVivas que fazem parte da sua comunidade", duration: Toast.LENGTH_SHORT,gravity: Toast.TOP);
        });
    },
)
    );
    

    
  }

  



}

  Widget conectividade() 
  {
    return FutureBuilder( future: conectividade2(),
        builder: (BuildContext context,estado) {
        if (estado.connectionState!= null && estado.data == true)
          return Container(
            color: Colors.green,
            child: Center(child: Texto(conteudo: "online", tamFonte: 12)),
          );
        return Container(
          color: Colors.red,
          child: Center(child: Texto(conteudo: "offline", tamFonte: 12)),
        );
      }
      );
  
  }

Future<bool> conectividade2() async
{
    prefs.setString('email', userAuth.usuario.email);
    prefs.setString('senha', userAuth.usuario.senha);

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return true;
    }
  } on SocketException catch (_) {
    print('not connected');
    return false;
  }
 
}




