import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:ocaviva/main.dart';
import 'package:ocaviva/models/usuario.dart';
import 'package:ocaviva/screens/desafioPage.dart';
import 'package:ocaviva/services/jogo_service.dart';
import 'package:ocaviva/widgets/SwipeAnimation/index.dart';
import 'package:ocaviva/widgets/bodyBackground.dart';
import 'package:ocaviva/widgets/circular_chart_copy.dart';
import 'package:ocaviva/widgets/fase.dart';
import 'package:ocaviva/widgets/texto.dart';
import 'package:ocaviva/widgets/texto2.dart';
import 'package:avataaar_image/avataaar_image.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';
  


int position = 0;
int currentPage = 0;
  PageController _pageController;

Avataaar avatar;

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
    
     
    avatar = Avataaar.random();
    avatar.toJson();   
    if(!Hive.isBoxOpen("users"))
    {
      abrirCaixa();
    }
        
    super.initState();
     
   // _pageController = PageController();    

  }

   @override
  void dispose() {
    //_pageController.dispose();
    super.dispose();
  }

   int _selectedIndex = 0;


  
  Drawer getNavDrawer(BuildContext context) {
    //var headerChild = DrawerHeader(child: Text("Header"));

    
    var iniciais = userAuth.usuario.nome.split(" ");
    var circle = "";
    for (var item in iniciais) {
      circle+= item[0] ;      
    }

    var headerChild =  UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue[900]

      ),
      accountName:(userAuth.usuario.nome != null)? Texto(conteudo:userAuth.usuario.nome,tamFonte: 14,): Text('aguarde'),
      accountEmail:(userAuth.usuario.email != null)? Texto(conteudo: userAuth.usuario.email, tamFonte: 14,): Text('aguarde'),
      currentAccountPicture: CircleAvatar(
      backgroundColor:
        Theme.of(context).platform == TargetPlatform.iOS
            ? Colors.white
            : Colors.white,
      child: //Icon(Icons.videocam),
      //(conectividade2() != false) ? Texto(conteudo: circle, tamFonte: 45,) :
      (avatar!=null) ?
      AvataaarImage(
          avatar: /*Avataaar(
  skin: Skin.pale,
  style: Style.circle,
  top: Top.noHair(),),*/
              avatar,
              errorImage: Icon(Icons.error),
              placeholder: CircularProgressIndicator(),
              width: 100.0,
            )
        : Text(
          circle,
        style: TextStyle(fontSize: 40.0),
      ),
    ),
    );

    var aboutChild = AboutListTile(
        child: Text("Sobre"),
        applicationName: "OCAVIVA",
        applicationVersion: "v4.0.1",
        applicationIcon: Icon(Icons.adb),
        icon: Icon(Icons.info));

    

    ListTile getNavItem(var icon, String s, String routeName,bool sair) {
      return ListTile(
        leading: Icon(icon),
        title: Text(s),
        onTap: () {
          setState(()  {
            // pop closes the drawer

            Navigator.of(context).pop();
            // navigate to the route
             
           // Navigator.of(context).pushNamed(routeName);
            if(sair == true){
              userAuth.logoutAccount(this.context, routeName);
            
             
                 
                //Timer(Duration(seconds: 3), () {
                  

                //});
             
             // Timer(Duration(seconds: 3), () {
             // ;});
            }
    
           Navigator.pushReplacementNamed(context, routeName); 
          });
        },
      );
    }
    
   
    var myNavChildren = [
      headerChild,      
      
      //getNavItem(Icons.settings, "Configurações", "/home"),
      //getNavItem(Icons.home, "Home", "/tinder"),
      getNavItem(Icons.account_box, "Perfil", "/perfil",false),
      //getNavItem(Icons.person_add, "Novo Usuário", "/registro", false),
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
   
  //Size screenSize = MediaQuery.of(context).size;
  //double screenHeigth = screenSize.height;
 
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
              Container(
                alignment: Alignment.topCenter,
                height:MediaQuery.of(context).size.height*0.8 ,
                child:
             ListView.builder(         
                  scrollDirection: Axis.vertical, 
                  shrinkWrap: true,
                  itemCount: comunidade.length,
                  itemBuilder: (context, index) {
                    if(comunidade.length == 0)
                      return SimpleDialog(
                    key: new GlobalKey<State>(),
                    backgroundColor: Colors.white,
                    children: <Widget>[
                      Center(
                        child: Column(children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10,),
                          Text("Sincronizando....",style: TextStyle(color: Colors.blue),)
                        ]),
                      )
                    ]
             ); 
                    else return ListTile(
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
                            color: (comunidadeScore[index]< 0)? Colors.red:(comunidadeScore[index]<50) ? Colors.yellow[800] 
                              : (comunidadeScore[index]<100)? Colors.lightBlue : Colors.lightGreen,

                            child:Texto(conteudo: "\t"+comunidadeScore[index].toString()+"\t",tamFonte: 14,)
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
                        color: (comunidade_score[index]< 0)? Colors.red:(comunidade_score[index]<50) ? Colors.yellow[800] 
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
             ),
            )
             ] )
        ]              
      );

}





  
    void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity, backgroundColor: Colors.blue[900]);
  }

  @override
  Widget build(BuildContext context) {
   
      
    
     

    //Size screenSize = MediaQuery.of(context).size;
    //double screenHeigth = screenSize.height;
     
    
    //var valor = score.value;//database.get('score',defaultValue: 50.0);
    //else
    //valor = boxUsers.getAt(userAuth.indice).score;
    //score = new AnimatedRadialChartExample(value: valor);
    
    return  FutureBuilder(
        future: abrirCaixa(),
        builder: (context, snapshot) {
         
        if (snapshot.connectionState == ConnectionState.done && snapshot.error == null) {
         
           Box<Usuario> boxUsers2 = Hive.box<Usuario>('users');
          var key = prefs.getString('email')+prefs.getString('senha');
        userAuth.usuario = boxUsers2.get(key);
         var nome = userAuth.usuario.nome;
         var comunidade = userAuth.usuario.escola;
         

            
                return Scaffold(
                  appBar: AppBar(
                    textTheme: GoogleFonts.dosisTextTheme(TextTheme(title:TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700))),
                    
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    centerTitle: true,
                    title: (_selectedIndex ==0) ? Text("Bem vindo a\n$nome",textAlign: TextAlign.center,): Text("Panorama da\n$comunidade", textAlign: TextAlign.center ,),
                    //title: (_selectedIndex ==0) ? Texto(conteudo:"Bem vindo a\n$nome", tamFonte:18.0): Texto(conteudo:"Panorama da\n$comunidade", tamFonte:18.0),
                    actions: <Widget>[
            new GestureDetector(
              onTap: () {

              },
              child: new InkWell(
                child:Container(
                  margin: const EdgeInsets.all(15.0),
                  child: new Icon(
                    Icons.help,
                    color: Colors.yellow[800],
                    size: 35.0,
                    semanticLabel: "Ajuda",
                  ),
                ),
                onTap: (){
            showDialog(context: context,
            builder: (BuildContext context)
            {
              return AlertDialog(
                title: Text("Ajuda", style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.w700),),
                content: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                  "Seja bem vindo ao OCAVIVA:\n\n"+
                  "Aqui você vai aprender jogando, a Ocaviva é a cidade como organismo vivo.\n\n"+
                  "Cada fase é um sistema do corpo-humano e cada sistema possuem funções para garantir que o corpo permaneça vivo. A execução destas funções ficará sobre sua responsabilidade podendo influenciar na saúde desse corpo. Essa funções são descritas na forma de desafios que possuem uma serie de problemas sociais para serem resolvidos.\nCuidando da cidade você cuida do corpo!\n\n Boa sorte, se cuida! ",
                  textAlign: TextAlign.left, style: TextStyle(fontSize: 16,),),),
                actions: <Widget>[
                  FlatButton(onPressed: (){ Navigator.pop(context);} , child: Text("OK")),
                ],
              );
            });
              }              
                ),
            ),
          ],
                  ),
                  extendBodyBehindAppBar: true,
                  body: (_selectedIndex ==0) ? homePrincipal(context) : homePrincipal2(context),
                  
                  
                  // Set the nav drawer
                  drawer: getNavDrawer(context),
             
                  bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Fases',style: TextStyle(fontSize: 16),),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school),
                    title: Text('Comunidade',style: TextStyle(fontSize: 16),),
                  ),
                ],
                currentIndex:   _selectedIndex,
        selectedItemColor: Colors.blue ,
        onTap: _onItemTapped,
      ),
            /*FancyBottomNavigation(
              //barBackgroundColor: Colors.transparent,
        tabs: [
            TabData(iconData: Icons.home, title: "Principal"),
            TabData(iconData: Icons.school, title: "Comunidade"),
        ],
        onTabChangedListener: (currentPage) {
  
            /*if(currentPage == 0)
              showToast("Menu das fases da OcaViva", duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
            else
              showToast("OcaVivas que fazem parte da sua comunidade", duration: Toast.LENGTH_SHORT,gravity: Toast.TOP);*/
          if(mounted ){
            setState(() {
              print(currentPage);
            currentPage = position;
            if(currentPage == 0)
              showToast("Menu das fases da OcaViva", duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
            else
              showToast("OcaVivas que fazem parte da sua comunidade", duration: Toast.LENGTH_SHORT,gravity: Toast.TOP);
            });
          }
        },
      )*/
    );}
        
    else{

      log("hive box: "+ Hive.isBoxOpen("users").toString());
      position = 0;
      currentPage = 0;
      return SimpleDialog(
                    key: new GlobalKey<State>(),
                    backgroundColor: Colors.white,
                    children: <Widget>[
                      Center(
                        child: Column(children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10,),
                          Text("Iniciando a OcaViva ...",style: TextStyle(color: Colors.blue[900] ),)
                        ]),
                      )
                    ]
             ); 
    

    }
    });

    
    
    

    
  }
   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  



}

  




