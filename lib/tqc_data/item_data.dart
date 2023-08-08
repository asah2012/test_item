
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../tqc_model/item.dart';

class ItemData {
  List<Item> _itemList = [];
  final String ipPortUrl = '192.168.29.50:8080';
  final String path = '/tscm/records/items';
  final String userName = 'admin';
  final String password = 'admin';

  ItemData(){
    print("Calling load data");
  }

  List<Item> get itemList {
    if(_itemList.isEmpty){
      return [];
    }
    else{
      return [..._itemList];
    }
  }
  Future<void> initData() async{
      final url = Uri.http(ipPortUrl,path);
      final response = await http.get(url,
      headers: <String , String > {'Authorization' : 'Basic ${base64Encode(utf8.encode('$userName:$password'))}' });

      print("status is ${response.statusCode}");
      print("Body is : ${response.body}");
      //Map<String,dynamic> records = jsonDecode(response.body);
      var jsonObject = jsonDecode(response.body) as Map<String,Object>;
      List itemObject = jsonObject["records"] as List;
    _itemList= itemObject.map((itemObject) => Item.fromJson(itemObject)).toList();
    _itemList.forEach((element) {print(element.toString());});
  }
}