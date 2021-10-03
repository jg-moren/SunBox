import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunbox/controller/ControllerNavigation.dart';
import 'package:sunbox/prefabs/button.dart';
import '../prefabs/estilo.dart';
import 'save.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class Saves extends StatefulWidget {
  @override
  Saves_Estado createState() => Saves_Estado();
}

class Saves_Estado extends State<Saves> {
  List<Save> list = [];
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }
  
  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Estilo.corPrimaria,
      
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 50,left: 20,right: 20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    Text("My Locations",style: TextStyle(color: Estilo.corSecundaria,fontSize: 40,fontWeight: FontWeight.bold,fontFamily: "Quicksand"),),
                    Expanded(child: SizedBox()),
                    Icon(Icons.wb_sunny,color: Estilo.corSecundaria,),
                    Card()
                  ],
                  
                ),
                
              ),
            ],
          ),
          
          
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navegacao.novo(context)),

      
    );
  }
  Widget emptyList(){
    return Center(
    child:  Text('No items')
    );
  }
  Widget buildListView() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context,int index){
        return buildItem(list[index], index);
      },
    );
  }

  Widget buildItem(Save item, index){
    return Dismissible(
      key: Key('${item.hashCode}'),
      background: Container(color: Colors.red[700]),
      // onDismissed: (direction) => removeItem(item),
      direction: DismissDirection.startToEnd,
      child: Icon(Icons.arrow_back),
    );
  }

  // void removeItem(Todo item){
  //   list.remove(item);
  //   saveData();
  // }
  void loadData() {
    List<String>? listString = sharedPreferences.getStringList('list');
    if(listString != null){
      list = listString.map(
        (item) => Save.fromMap(json.decode(item))
      ).toList();
      setState((){});
    }
  }

   void saveData(){
    List<String> stringList = list.map(
      (item) => json.encode(item.toMap()
    )).toList();
    sharedPreferences.setStringList('list', stringList);
  }

}
