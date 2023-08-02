import 'package:flutter/material.dart';
import 'package:test_item/tqc_data/item_data.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../tqc_service/item_data_source.dart';

class ItemGridScreen extends StatefulWidget {
  const ItemGridScreen({super.key });
  @override
  State<ItemGridScreen> createState() => _ItemGridScreenState();
}

class _ItemGridScreenState extends State<ItemGridScreen> {

  ItemData itemData = ItemData();
  late ItemDataSource itemDataSource;
  late bool isWebOrDesktop;
  EditingGestureType editingGestureType = EditingGestureType.doubleTap;

  Future<void> itemLoadData() async{
    await itemData.initData();
    setState(() {
        itemDataSource = ItemDataSource(items: itemData.itemList);
    });
  }

  @override
  void initState() {
    super.initState();
    itemLoadData();
    isWebOrDesktop = true;
  }

SfDataGrid _buildDataGrid(BuildContext context){
  print("_buildDataGrid : calling SfDataGrid");
      return SfDataGrid(
        allowEditing: true,
        navigationMode: GridNavigationMode.cell,
        selectionMode: SelectionMode.single,
        editingGestureType: editingGestureType,
        source: itemDataSource,
        columnWidthMode: ColumnWidthMode.none,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'id',
              label: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'ID',
                  overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'ItemName',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('ItemName',
                  overflow: TextOverflow.ellipsis,))),
          GridColumn(
              columnName: 'ItemCode',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'ItemCode',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'ItemType',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('ItemType',
                  overflow: TextOverflow.ellipsis,))),
        ],
      );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Item Table")),
      body: itemData.itemList.isEmpty ? const Center(child: CircularProgressIndicator()) : SafeArea(child: _buildDataGrid(context)),
    );   
  }

}