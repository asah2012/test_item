import 'package:flutter/material.dart';
import 'package:test_item/tqc_model/item.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ItemDataSource extends DataGridSource {
    List<DataGridRow>  _itemDataGridRows = [];
    dynamic newCellValue;
    List<Item> _itemList = [];

  /// Helps to control the editable text in the [TextField] widget.
  TextEditingController editingController = TextEditingController();

    
  ItemDataSource({required List<Item> items}) {
    _itemList = items;
     _itemDataGridRows = items
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'ItemCode', value: e.itemCode),
              DataGridCell<String>(
                  columnName: 'ItemName', value: e.itemName),
              DataGridCell<String>(columnName: 'ItemType', value: e.itemType),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows =>  _itemDataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
        return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment:Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }

@override
 Future<void> onCellSubmit(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column) async {

    final dynamic oldValue = dataGridRow.getCells().firstWhere((DataGridCell dataGridCell)=> dataGridCell.columnName == column.columnName)?.value??'';


    final int dataRowIndex = _itemDataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName == 'id') {
      _itemDataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'id', value: newCellValue);
      _itemList[dataRowIndex].id = newCellValue as int;
    } 
    else if (column.columnName == 'ItemCode') {
      _itemDataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'ItemCode', value: newCellValue);
      _itemList[dataRowIndex].itemCode = newCellValue.toString();
    } 
    else if (column.columnName == 'ItemName') {
      _itemDataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'ItemName', value: newCellValue);
      _itemList[dataRowIndex].itemName = newCellValue.toString();
    } 
    else {
      _itemDataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'ItemType', value: newCellValue);
      _itemList[dataRowIndex].itemType = newCellValue.toString();
    }
  }



@override
Widget? buildEditWidget(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
  // Text going to display on editable widget
 final dynamic displayText = dataGridRow.getCells().firstWhere((DataGridCell dataGridCell)=> dataGridCell.columnName == column.columnName)?.value??'';


    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    final bool isNumericType =
        column.columnName == 'id';

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        controller: editingController..text = isNumericType ? (displayText as int).toString() : displayText,
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = int.parse(value);
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          // In Mobile Platform.
          // Call [CellSubmit] callback to fire the canSubmitCell and
          // onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }
  }

