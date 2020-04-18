import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:hive/hive.dart';
import 'package:ocaviva/models/firestore.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/screens/desafioPage.dart';
import 'package:ocaviva/screens/loginPage.dart';
import 'package:ocaviva/widgets/SwipeAnimation/index.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/circular_chart.dart';
import 'package:ocaviva/widgets/fase.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:ocaviva/widgets/texto2.dart';

var estado = conectividade();
Box<Usuario> boxUsers = Hive.box<Usuario>('users');
class HomePage extends StatefulWidget {
 @override
    HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<HomePage>
{


  @override
  void initState() 
  {
    
    
    super.initState();
    
    
    

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
            : Colors.orangeAccent,
      child: //Icon(Icons.videocam),
      Texto(conteudo: circle, tamFonte: 45,)
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

    

    ListTile getNavItem(var icon, String s, String routeName) {
      return ListTile(
        leading: Icon(icon),
        title: Text(s),
        onTap: () {
          setState(() {
            // pop closes the drawer
            Navigator.of(context).pop();
            // navigate to the route
            Navigator.of(context).pushNamed(routeName);
          });
        },
      );
    }
   
    var myNavChildren = [
      headerChild,   
      estado,
      getNavItem(Icons.settings, "Configurações", "/home"),
      getNavItem(Icons.home, "Home", "/problemas"),
      getNavItem(Icons.account_box, "Perfil", "AccountScreen.routeName"),
      aboutChild
    ];

    ListView listView = ListView(children: myNavChildren);

    
  
    return Drawer(
   
      child: listView,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeigth = screenSize.height;
     estado = conectividade();
    //var valor = score.value;//database.get('score',defaultValue: 50.0);
    double valor;
    if( boxUsers.getAt(userAuth.indice).score == null)
      valor = 50.0;
    else
      valor = boxUsers.getAt(userAuth.indice).score;
    score = new AnimatedRadialChartExample(value: valor);
    

    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Texto(conteudo:"Bem vindo à sua OCAVIVA", tamFonte:18.0),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          BodyBackground(),
          
          Center(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               //Texto(conteudo:"Bem vindo à sua OCAVIVA", tamFonte:18.0),
               Container(
              height: screenHeigth*0.6,
              margin: EdgeInsets.symmetric(vertical: 40.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => DesafioPage(fase: 1,score: score,) ) ); },
                    child: Fase(asset: 'assets/images/digestorio.png', legenda: "Sistema \nDigestório"),
                  ) ,
                   InkWell(
                    onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => DesafioPage(fase: 2,score: score,) ) ); },
                    child: Fase(asset: 'assets/images/circulatorio.png', legenda: "Sistema \nCirculatório"),
                  ) ,                     
                   //Fase(asset: 'assets/images/respiratorio.png', legenda: "Sistema Respiratório"),
                  //Fase(asset: 'assets/images/excretor.png', legenda: "Sistema Excretor"),
                  InkWell(
                    //onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => DesafioPage(fase: 3,) ) ); },
                    child: Fase(asset: 'assets/images/esqueletico.png', legenda: "Sistema \nEsquelético"),
                  ) , 
                  InkWell(
                    //onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => DesafioPage(fase: 4,) ) ); },
                    child:  Fase(asset: 'assets/images/muscular.png', legenda: "Sistema \nMuscular"),
                  ) ,
                  InkWell(
                    //onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) =>DesafioPage(fase: 5,)) ); },
                    child: Fase(asset: 'assets/images/nervoso.png', legenda: "Sistema\nNervoso"),
                  ) ,
                  //Fase(asset: 'assets/images/endocrino.png', legenda: "Sistema Endócrino"),
                      
                ],
              ),
            ),
             /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Texto2(conteudo: "Estado de saúde\n da OcaViva:", tamFonte: 16),
                    Container(child: score,),
                  ],
                ),*/
              ],
            ),
          ),
        ]
      ),
      // Set the nav drawer
      drawer: getNavDrawer(context),
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
