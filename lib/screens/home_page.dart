import 'package:flutter/material.dart';
import 'package:ocaviva/screens/desafioPage.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/circular_chart.dart';
import 'package:ocaviva/widgets/fase.dart';
import 'package:ocaviva/widgets/texto.dart';

AnimatedRadialChartExample score =  new AnimatedRadialChartExample(value: 50,);


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
    var headerChild = UserAccountsDrawerHeader(
      accountName: Text("Aluno 1"),
      accountEmail: Text("aluno1@gmail.com"),
      currentAccountPicture: CircleAvatar(
      backgroundColor:
        Theme.of(context).platform == TargetPlatform.iOS
            ? Colors.blue
            : Colors.white,
      child: //Icon(Icons.videocam),
      Text(
          "A1",
        style: TextStyle(fontSize: 40.0),
      ),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Tela principal das Fases"),
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
               Texto(conteudo:"Bem vindo à sua OCAVIVA", tamFonte:18.0),
               Container(
              height: screenHeigth*0.5,
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
