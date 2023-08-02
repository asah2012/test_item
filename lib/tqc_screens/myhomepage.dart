import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../tqc_model/item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  Item tmp1 =  Item(id: 1,itemCode: 'Item1' , itemName: 'Name1',itemType: 'Type1');
  List<Item> itemList = [Item(id: 1,itemCode: 'Item1' , itemName: 'Name1',itemType: 'Type1')];

  void _loadData() async{
      final url = Uri.http("192.168.29.50:8080","/item/2");
      final response = await http.get(url);
            print("status is ${response.statusCode}");
      print("Body is : ${response.body}");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: (){
            print("Refresh button");
            _loadData();
            }, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.add)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
          
        ],
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (ctx,index){
          return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(child: Text(itemList[index].id.toString()),),
          Container(child: Text(itemList[index].itemCode),),
         Container(child: Text(itemList[index].itemName),),
          Container(child: Text(itemList[index].itemType),),
        ],
      );
      })     
    );
  }
}