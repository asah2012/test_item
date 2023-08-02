
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../tqc_model/item.dart';

class ItemData {
  List<Item> _itemList = [];

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
      final url = Uri.http("192.168.29.50:8080","/item");
      final response = await http.get(url);
            print("status is ${response.statusCode}");
      print("Body is : ${response.body}");
      var jsonObjectList = jsonDecode(response.body) as List;
    _itemList= jsonObjectList.map((itemObject) => Item.fromJson(itemObject)).toList();
    _itemList.forEach((element) {print(element.toString());});
  }
}