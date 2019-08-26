import 'dart:convert';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:http/http.dart' as http;
import 'api_static.dart';

class Employee {
  final int id;
  final int userId;
  final String userName;
  final String userMobile;
  final int businessId;
  final bool isActive;
  Employee(
      {this.id,
       this.userId,this.userName,this.userMobile,
      this.businessId,
      this.isActive});
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
            userId: jsonOrder[EmployeeStatic.keyUserID],
            userName: jsonOrder[EmployeeStatic.keyUserName],
            userMobile: jsonOrder[EmployeeStatic.keyUserMobile],
            businessId: jsonOrder[EmployeeStatic.keyBusinessId],
            isActive: jsonOrder[EmployeeStatic.keyIsActive])
      );
    }

    count = employees.length;

    return GetEmployees(employees: employees, count: count);
  }
}

Future<GetEmployees> fetchEmployee() async {
  final response =
      await http.get(EmployeeStatic.keyEmployeeURL + "?designation=DB");

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
    await ConstantVariables.sentryClient.captureException(
      exception: Exception("Employee Get Failure"),
      stackTrace: '[response.body: ${response.body}, '
          'response.headers: ${response.headers}, response: $response,'
          'status code: ${response.statusCode}]',
    );

    return null;
  }
}
