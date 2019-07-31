import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_static.dart';

class Employee{
  final int id;
  final String name;
  final String designation;
  final int business;
  final bool isActive;
  final String joinedOn;
  final String leftOn;
  final String salary;

  Employee({
    this.id,
    this.name,
    this.designation,
    this.business,
    this.isActive,
    this.joinedOn,
    this.leftOn,
    this.salary
  });
}

class GetEmployees {
  List<Employee> employees;
  int count;

  GetEmployees({this.employees, this.count});

  factory GetEmployees.fromJson(Map<String, dynamic> response) {
    List<Employee> employees = [];
    int count = response[APIStatic.keyCount];

    List<dynamic> results = response[APIStatic.keyResult];

    for (int i = 0; i < results.length; i++) {
      Map<String, dynamic> jsonOrder = results[i];
      employees.add(
        Employee(
          id: jsonOrder[APIStatic.keyID],
          name: jsonOrder[APIStatic.keyName],
          designation: jsonOrder[EmployeeStatic.keyDesignation],
          business: jsonOrder[APIStatic.keyBusiness],
          isActive: jsonOrder[EmployeeStatic.keyIsActive],
          joinedOn: jsonOrder[EmployeeStatic.keyJoinedOn],
          leftOn: jsonOrder[EmployeeStatic.keyLeftOn],
          salary: jsonOrder[EmployeeStatic.keySalary]
        ),
      );
    }

    count = employees.length;

    return GetEmployees(employees: employees, count: count);
  }
}

Future<GetEmployees> fetchEmployee() async {
  final response = await http.get(EmployeeStatic.keyEmployeeURL+ "?designation=DB");

  if (response.statusCode == 200) {
    int count = jsonDecode(response.body)[APIStatic.keyCount];
    int execute = count ~/ 10 + 1;

    GetEmployees employee = GetEmployees.fromJson(jsonDecode(response.body));
    execute--;

    while (execute != 0) {
      GetEmployees tempOrder = GetEmployees.fromJson(jsonDecode(
          (await http.get(jsonDecode(response.body)[APIStatic.keyNext])).body));
      employee.employees += tempOrder.employees;
      employee.count += tempOrder.count;
      execute--;
    }

    return employee;
  } else {
    throw Exception('Failed to load get');
  }
}