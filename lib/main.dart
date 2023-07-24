
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:teste_api/components/cad_frete_gratis.dart';
import 'package:teste_api/components/campo_pesquisa.dart';
import 'package:teste_api/components/card_assinatura.dart';
import 'package:teste_api/components/categoria_botao.dart';
import 'package:teste_api/data/cache.dart';
import 'package:teste_api/data/dataController.dart';
import 'package:teste_api/data/string.dart';
import 'package:teste_api/model/listPersonModel.dart';
import 'package:teste_api/model/moneyModel.dart';
import 'data/internet.dart';
import 'package:cached_network_image/cached_network_image.dart';



void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


//estou chaa
List<ListPersonModel> model = [];
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}








class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController   controller = TextEditingController();

  checkConnection() async{
    internet = await CheckInternet().checkConnection();
    if(internet == false){
      readMemory();
    }
    setState(() {

    });
  }

  bool internet = true;


  @override
  void initState(){
    checkConnection();
    super.initState();
  }



  dynamic endereco = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfff5d415),
    leading: Builder(builder: (BuildContext context){
    return IconButton(
    icon: const Icon(Icons.menu_outlined, color: Colors.black),
    tooltip: 'Menu',
    onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Menu')));
    },
    );
    },
    ),

    actions: <Widget>[
    MeuCampoPesquisa(),

    const Padding(padding: EdgeInsets.all(5)),
    Container(child: IconButton(
    icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
    tooltip: 'Seu carrinho',
    onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Seu carrinho')));
    },
    ),
    ),
    ],
    bottom: PreferredSize(


    preferredSize: Size.fromHeight(50),
    child: ListTile(




      leading:
       Visibility(


      visible: internet == true,
      child: Icon(Icons.network_cell_outlined)),





        title:
    Text("Conectado",
    //  final response = await API().get("viacep.com.br/ws/01001000/json/");
    // return ResultCep.fromJson()


    style: TextStyle(fontSize: 11.5), textAlign: TextAlign.left),



    ),
    ),
    ),

        body:
        internet == false ?
        ListView.builder(
            itemCount: model.length,
            itemBuilder: (context, index) {
              ListPersonModel item = model[index];

              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: "http://via.placeholder.com/350x150",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                // Image.network(errorBuilder: (context, error, stackTrace) {
                //   return Container();
                // }, item.avatar ?? ""),
                title: Text(item.name ?? ""),
                trailing: Text(item.id ?? ""),

              );
            }) :
        FutureBuilder<List<ListPersonModel>>(
          future: DataController().getListPerson(),
          builder: (context, snapshot) {
            /// validação de carregamento da conexão
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            /// validação de erro
            if (snapshot.error == true) {
              return SizedBox(
                height: 300,
                child: Text("Vazio"),
              );
            }
//  List<ListPersonModel> model = [];


            /// passando informações para o modelo criado
            model = snapshot.data ?? model;

            model.removeWhere((pessoa) => pessoa.id == "Yolanda Monahan" ) ;
            model.add(ListPersonModel(id:"9", name:"Lewis Hamilton", avatar: "https://th.bing.com/th/id/R.23536abe048ec4a080f5a7f8cb44c319?rik=4hQj9BeCGEbxrg&pid=ImgRaw&r=0"));


            model.sort(
                  (a, b) => a.name!.compareTo(b.name!),
            );
            model.forEach((pessoa) {
              if(pessoa.id == "9"){
                pessoa.avatar = "https://th.bing.com/th/id/R.cac69ec3d73d815c31263d8db75ee6e3?rik=EIOBrlOxNE0tvA&pid=ImgRaw&r=0";
              }
            });

            verifyData(snapshot);

            return ListView.builder(
                itemCount: model.length,
                itemBuilder: (context, index) {
                  ListPersonModel item = model[index];

                  return ListTile(
                    leading: Image.network(errorBuilder: (context, error, stackTrace) {
                      return Container();
                    }, item.avatar ?? ""),
                    title: Text(item.name ?? ""),
                    trailing: Text(item.id ?? ""),

                  );
                });
          },
        ),
    );
  }

  verifyData(AsyncSnapshot snapshot) async{
    try{

      model.addAll(snapshot.data ?? []);
      await SecureStorage().writeSecureData(pessoas , json.encode(snapshot.data));
    } catch(e){
      print("erro ao salvar lista");
    }
  }


//pegando as informações em json e convertendo em lista
  readMemory() async{
    var result = await SecureStorage().readSecureData(pessoas);
    if(result == null) return;
    List<ListPersonModel> lista = (json.decode(result) as List).
    map((e) => ListPersonModel.fromJson(e)).toList();
    model.addAll(lista);
  }

  Future<Null> refresh() async{
    setState(() {

    });
  }
  }