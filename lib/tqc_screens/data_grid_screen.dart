import 'package:flutter/material.dart';
import '../tqc_model/employee.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../tqc_service/employee_data_source.dart';

class DataGridScreen extends StatefulWidget {
  const DataGridScreen({super.key });
  //final String title; 

  @override
  State<DataGridScreen> createState() => _DataGridScreenState();
}

class _DataGridScreenState extends State<DataGridScreen> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;
    final ValueNotifier<bool> frontPanelVisible = ValueNotifier<bool>(true);
  void _subscribeToValueNotifier() => panelOpen = frontPanelVisible.value;
  bool panelOpen = false;
  late bool isWebOrDesktop;
  EditingGestureType editingGestureType = EditingGestureType.doubleTap;

  @override
  void initState() {
    super.initState();
    employees = Employee.loadInitialEmployeeData();
    employeeDataSource = EmployeeDataSource(employees: employees);
    panelOpen = frontPanelVisible.value;
    frontPanelVisible.addListener(_subscribeToValueNotifier);
    isWebOrDesktop = true;
  }

SfDataGrid _buildDataGrid(BuildContext context){
      return SfDataGrid(
        allowEditing: true,
        navigationMode: GridNavigationMode.cell,
        selectionMode: SelectionMode.single,
        editingGestureType: editingGestureType,
        source: employeeDataSource,
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
              columnName: 'name',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Name',
                  overflow: TextOverflow.ellipsis,))),
          GridColumn(
              columnName: 'designation',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Designation',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'salary',
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Salary',
                  overflow: TextOverflow.ellipsis,))),
        ],
      );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Employee Table")),
      body: SafeArea(child: _buildDataGrid(context)),
    );   
  }

}