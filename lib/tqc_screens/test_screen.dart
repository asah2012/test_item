import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataTablePage(),
    );
  }
}

class DataTablePage extends StatefulWidget {
  @override
  _DataTablePageState createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  List<Map<String, dynamic>> _dataList = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    final response = await http.get(Uri.parse('http://192.168.29.50:8080/item'));
    if (response.statusCode == 200) {
      // Assuming the API returns a JSON array of data
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _dataList = data.cast<Map<String, dynamic>>();
      });
    } else {
      print('Failed to load data from the API.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Table'),
      ),
      body: _dataList.isNotEmpty
          ? SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Type')),
                ],
                rows: _dataList
                    .map(
                      (data) => DataRow(
                        cells: [
                          DataCell(Text(data['id'].toString())),
                          DataCell(Text(data['itemCode'].toString())),
                          DataCell(Text(data['itemName'].toString())),
                          DataCell(Text(data['itemType'].toString())),
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
