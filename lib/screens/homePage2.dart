import 'package:flutter/material.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/fase.dart';
import 'package:ocaviva/widgets/texto.dart';

class HomePage2 extends StatefulWidget {
 @override
    HomeState2 createState() {
    return new HomeState2();
  }
}

class HomeState2 extends State<HomePage2>
{
  @override
  void initState() 
  {
    super.initState();
  }
  
  Drawer getNavDrawer(BuildContext context) {
    var headerChild = DrawerHeader(child: Text("Header"));
    var aboutChild = AboutListTile(
        child: Text("About"),
        applicationName: "OCAVIVA",
        applicationVersion: "v1.0.0",
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
      getNavItem(Icons.settings, "Settings", "sadada"),
      getNavItem(Icons.home, "Home", "/"),
      getNavItem(Icons.account_box, "Account", "AccountScreen.routeName"),
      aboutChild
    ];

    ListView listView = ListView(children: myNavChildren);

    

    return Drawer(
      child: listView,
    );
  }

  @override
  Widget build(BuildContext context) {
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
            child: Container(
              height: 400,
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Fase(asset: 'assets/images/digestorio.png', legenda: "Sistema Digestório"),
                  Fase(asset: 'assets/images/circulatorio.png', legenda: "Sistema Circulatório"),
                   //Fase(asset: 'assets/images/respiratorio.png', legenda: "Sistema Respiratório"),
                  //Fase(asset: 'assets/images/excretor.png', legenda: "Sistema Excretor"),
                  Fase(asset: 'assets/images/esqueletico.png', legenda: "Sistema Esquelético"),
                  Fase(asset: 'assets/images/muscular.png', legenda: "Sistema Muscular"),
                  Fase(asset: 'assets/images/nervoso.png', legenda: "Sistema Nervoso"),
                  //Fase(asset: 'assets/images/endocrino.png', legenda: "Sistema Endócrino"),
                      
                ],
              ),
            ),
          ),
        ]
      ),
      // Set the nav drawer
      drawer: getNavDrawer(context),
    );
  }
}
