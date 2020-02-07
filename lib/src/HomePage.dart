

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocaviva/src/loginPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Drawer getNavDrawer(BuildContext context) {
    var headerChild = DrawerHeader(child: Text("Header"));
    var aboutChild = AboutListTile(
        child: Text("About"),
        applicationName: "Application Name",
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
           Container(
              //padding: EdgeInsets.symmetric(horizontal: 640),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.4, 0.6, 0.9],
                      colors: [ Colors.deepPurple,Colors.indigo, Colors.blue, Colors.cyan ])),               
            ),
            Center(
              child:    Container(
             height: 600,
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 160.0,
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: Text("FASE 1"),
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text("FASE 2"),
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.green,
                    alignment: Alignment.center,
                    child: Text("FASE 3"),
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.yellow,
                    alignment: Alignment.center,
                    child: Text("FASE 4"),
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.orange,
                    alignment: Alignment.center,
                    child: Text("FASE 5"),
                  )
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