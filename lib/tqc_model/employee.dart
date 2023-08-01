class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  int id;
  String name;
  String designation;
  int salary;

  List<Employee> employee_list = [];

  static List<Employee> loadInitialEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000)
    ];
  }

List<Employee> getEmployeeData(){
  return employee_list;
}

void setEmployeeData(Employee emp){
  int index = employee_list.indexWhere((element) => element.id == emp.id);
  employee_list[index] = emp;
}

}