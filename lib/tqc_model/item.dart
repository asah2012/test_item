class Item {
  int id;
  String itemCode;
  String itemName;
  String itemType;

  Item({required this.id,required this.itemCode,required this.itemName,required this.itemType});

  factory Item.fromJson(dynamic jsonObject){
      return Item(id: jsonObject["id"] as int , itemCode: jsonObject["itemCode"] as String, itemName: jsonObject["itemName"] as String , itemType: jsonObject["itemType"] as String);
  }

@override
  String toString(){

    return '{${this.id.toString()} , ${this.itemCode} , ${this.itemName}, ${this.itemType}}';
  }
}