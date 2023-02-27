// ignore_for_file: unused_local_variable, prefer_const_constructors, await_only_futures

@Timeout(Duration(seconds: 200))

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sadms/Database/database.dart';

void main() {
  String url = 'ws://127.0.0.1:55663/Tp-uK_rUMoE=/ws';
  late FlutterDriver driver;

  // Module 1
  group('Module 1: Login', () {
    test('Manager Login Valid', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon("managerlogin");

      await driver.tap(ByValueKey('M-Username'));
      await driver.enterText('durvesh8403');
      await driver.tap(ByValueKey('M-EmailId'));
      await driver.enterText('durveshmore2003@gmail.com');
      await driver.tap(ByValueKey('M-Password'));
      await driver.enterText('durvesh8');
      await driver.tap(ByValueKey('Login'));

      await driver.waitFor(ByValueKey('ManagerName'));
      String result = await driver.getText(ByValueKey('ManagerName'));

      expect(result, equals('durvesh8403'));

      //await driver.tap(ByText('Log Out'));

      await DB.closeCon();
      driver.close();
    });

    test('Manager Login Invalid', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon("managerlogin");

      await driver.tap(ByValueKey('M-Username'));
      await driver.enterText('durvesh8403');
      await driver.tap(ByValueKey('M-EmailId'));
      await driver.enterText('durveshmore2003@gmail.com');
      await driver.tap(ByValueKey('M-Password'));
      await driver.enterText('durvesh934802');
      await driver.tap(ByValueKey('Login'));

      await driver.waitFor(ByText('Login Page'));
      String result = await driver.getText(ByText('Wrong Credentials Entered'));

      expect(result, equals('Wrong Credentials Entered'));

      await driver.tap(ByValueKey('Clear'));

      await DB.closeCon();
      driver.close();
    });

    test('Employee Login Valid', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon('employeelogin');

      await driver.tap(ByText('Employee Login'));
      await driver.tap(ByValueKey('E-Username'));
      await driver.enterText('durvesh8403');
      await driver.tap(ByValueKey('E-Password'));
      await driver.enterText('durvesh8');
      await driver.tap(ByValueKey('Login'));

      await driver.waitFor(ByValueKey('EmployeeName'));
      String result = await driver.getText(ByValueKey('EmployeeName'));

      expect(result, 'durvesh8403');

      await driver.tap(ByText('Log Out'));

      await DB.closeCon();
      driver.close();
    });

    test('Employee Login Invalid', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon('employeelogin');

      await driver.tap(ByValueKey('E-Username'));
      await driver.enterText('durvesh8403');
      await driver.tap(ByValueKey('E-Password'));
      await driver.enterText('durvesh986454');
      await driver.tap(ByValueKey('Login'));

      await driver.waitFor(ByText('Login Page'));
      String result = await driver.getText(ByText('Wrong Credentials Entered'));

      expect(result, equals('Wrong Credentials Entered'));

      await driver.tap(ByValueKey('Clear'));

      DB.closeCon();
      driver.close();
    });

    test('Email Validation', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon('managerlogin');

      await driver.tap(ByText('Manager Login'));
      await driver.tap(ByValueKey('M-Username'));
      await driver.enterText('durvesh8403');
      await driver.tap(ByValueKey('M-EmailId'));
      await driver.enterText('durveshmore2003@94032');
      await driver.tap(ByValueKey('M-Password'));
      await driver.enterText('durvesh8');

      await driver.tap(ByValueKey('Login'));

      String result = await driver.getText(ByText('Invalid Email Id'));

      expect(result, isNotEmpty);

      await driver.tap(ByValueKey('Clear'));

      await DB.closeCon();
      driver.close();
    });
  });

  // Module 2
  group('Module 2: Navigation Bar', () {
    test('Slider', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('Menu'));
      await driver.waitFor(ByText('Edit'));
      await driver.tap(ByValueKey('Menu'));
      await driver.waitFor(ByText('Edit Profile'));

      driver.close();
    });
    test('Buttons Test from Dashboard', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('EditProfile'));
      await driver.waitFor(ByText('Edit Profile'));
      await driver.tap(ByValueKey('Back'));
      await driver.tap(ByValueKey('Manager'));
      await driver.waitFor(ByValueKey('Title_Manager'));
      await driver.tap(ByValueKey('Dashboard'));
      await driver.waitFor(ByValueKey('Title_Dashboard'));
      await driver.tap(ByValueKey('Employee'));
      await driver.waitFor(ByValueKey('Title_Employee'));
      await driver.tap(ByValueKey('Dashboard'));
      await driver.waitFor(ByValueKey('Title_Dashboard'));
      await driver.tap(ByValueKey('Product'));
      await driver.waitFor(ByValueKey('Title_Product'));
      await driver.tap(ByValueKey('Dashboard'));
      await driver.waitFor(ByValueKey('Title_Dashboard'));
      await driver.tap(ByValueKey('Branch'));
      await driver.waitFor(ByValueKey('Title_Branch'));
      await driver.tap(ByValueKey('Dashboard'));
      await driver.waitFor(ByValueKey('Title_Dashboard'));
      await driver.tap(ByValueKey('Stock'));
      await driver.waitFor(ByValueKey('Title_Stock'));
      await driver.tap(ByValueKey('Dashboard'));
      await driver.waitFor(ByValueKey('Title_Dashboard'));
      await driver.tap(ByValueKey('Sales'));
      await driver.waitFor(ByValueKey('Title_Sales'));
      await driver.tap(ByValueKey('Dashboard'));
      await driver.waitFor(ByValueKey('Title_Dashboard'));

      driver.close();
    });
    test('Button Test from Manager', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('Manager'));
      await driver.waitFor(ByValueKey('Title_Manager'));
      await driver.tap(ByValueKey('EditProfile'));
      await driver.waitFor(ByText('Edit Profile'));
      await driver.tap(ByValueKey('Back'));
      await driver.waitFor(ByValueKey('Title_Manager'));
      await driver.tap(ByValueKey('Employee'));
      await driver.waitFor(ByValueKey('Title_Employee'));
      await driver.tap(ByValueKey('Manager'));
      await driver.waitFor(ByValueKey('Title_Manager'));
      await driver.tap(ByValueKey('Product'));
      await driver.waitFor(ByValueKey('Title_Product'));
      await driver.tap(ByValueKey('Manager'));
      await driver.waitFor(ByValueKey('Title_Manager'));
      await driver.tap(ByValueKey('Branch'));
      await driver.waitFor(ByValueKey('Title_Branch'));
      await driver.tap(ByValueKey('Manager'));
      await driver.waitFor(ByValueKey('Title_Manager'));
      await driver.tap(ByValueKey('Stock'));
      await driver.waitFor(ByValueKey('Title_Stock'));
      await driver.tap(ByValueKey('Manager'));
      await driver.waitFor(ByValueKey('Title_Manager'));
      await driver.tap(ByValueKey('Sales'));
      await driver.waitFor(ByValueKey('Title_Sales'));
      await driver.tap(ByValueKey('Manager'));
      await driver.waitFor(ByValueKey('Title_Manager'));

      driver.close();
    });
    test('Button Test from Employee', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('Employee'));
      await driver.waitFor(ByValueKey('Title_Employee'));
      await driver.tap(ByValueKey('EditProfile'));
      await driver.waitFor(ByText('Edit Profile'));
      await driver.tap(ByValueKey('Back'));
      await driver.waitFor(ByValueKey('Title_Employee'));
      await driver.tap(ByValueKey('Product'));
      await driver.waitFor(ByValueKey('Title_Product'));
      await driver.tap(ByValueKey('Employee'));
      await driver.waitFor(ByValueKey('Title_Employee'));
      await driver.tap(ByValueKey('Branch'));
      await driver.waitFor(ByValueKey('Title_Branch'));
      await driver.tap(ByValueKey('Employee'));
      await driver.waitFor(ByValueKey('Title_Employee'));
      await driver.tap(ByValueKey('Stock'));
      await driver.waitFor(ByValueKey('Title_Stock'));
      await driver.tap(ByValueKey('Employee'));
      await driver.waitFor(ByValueKey('Title_Employee'));
      await driver.tap(ByValueKey('Sales'));
      await driver.waitFor(ByValueKey('Title_Sales'));
      await driver.tap(ByValueKey('Employee'));
      await driver.waitFor(ByValueKey('Title_Employee'));

      driver.close();
    });
    test('Button Test from Product', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('Product'));
      await driver.waitFor(ByValueKey('Title_Product'));
      await driver.tap(ByValueKey('EditProfile'));
      await driver.waitFor(ByText('Edit Profile'));
      await driver.tap(ByValueKey('Back'));
      await driver.waitFor(ByValueKey('Title_Product'));
      await driver.tap(ByValueKey('Branch'));
      await driver.waitFor(ByValueKey('Title_Branch'));
      await driver.tap(ByValueKey('Product'));
      await driver.waitFor(ByValueKey('Title_Product'));
      await driver.tap(ByValueKey('Stock'));
      await driver.waitFor(ByValueKey('Title_Stock'));
      await driver.tap(ByValueKey('Product'));
      await driver.waitFor(ByValueKey('Title_Product'));
      await driver.tap(ByValueKey('Sales'));
      await driver.waitFor(ByValueKey('Title_Sales'));
      await driver.tap(ByValueKey('Product'));
      await driver.waitFor(ByValueKey('Title_Product'));

      driver.close();
    });
    test('Button Test from Branch', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('Branch'));
      await driver.waitFor(ByValueKey('Title_Branch'));
      await driver.tap(ByValueKey('EditProfile'));
      await driver.waitFor(ByText('Edit Profile'));
      await driver.tap(ByValueKey('Back'));
      await driver.waitFor(ByValueKey('Title_Branch'));
      await driver.tap(ByValueKey('Stock'));
      await driver.waitFor(ByValueKey('Title_Stock'));
      await driver.tap(ByValueKey('Branch'));
      await driver.waitFor(ByValueKey('Title_Branch'));
      await driver.tap(ByValueKey('Sales'));
      await driver.waitFor(ByValueKey('Title_Sales'));
      await driver.tap(ByValueKey('Branch'));
      await driver.waitFor(ByValueKey('Title_Branch'));

      driver.close();
    });
    test('Button Test from Stock', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('Stock'));
      await driver.waitFor(ByValueKey('Title_Stock'));
      await driver.tap(ByValueKey('EditProfile'));
      await driver.waitFor(ByText('Edit Profile'));
      await driver.tap(ByValueKey('Back'));
      await driver.waitFor(ByValueKey('Title_Stock'));
      await driver.tap(ByValueKey('Sales'));
      await driver.waitFor(ByValueKey('Title_Sales'));
      await driver.tap(ByValueKey('Stock'));
      await driver.waitFor(ByValueKey('Title_Stock'));

      driver.close();
    });
    test('Button Test from Sales', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('Sales'));
      await driver.waitFor(ByValueKey('Title_Sales'));
      await driver.tap(ByValueKey('EditProfile'));
      await driver.waitFor(ByText('Edit Profile'));
      await driver.tap(ByValueKey('Back'));
      await driver.waitFor(ByValueKey('Title_Sales'));

      driver.close();
    });
  });

  // Module 4
  group('Module 4: Manager', () {
    test('Load Manager Data', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon('managerinfo');

      await driver.tap(ByValueKey('Manager'));
      String result = await driver.getText(ByValueKey('Title_Manager'));

      expect(result, 'Manager');

      await DB.closeCon();
      driver.close();
    });
    test('Search Available Manager by Username', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('durvesh8403');

      expect(await driver.getText(ByValueKey('Username')),
          'Username: durvesh8403');

      await driver.enterText('');

      driver.close();
    });
    test('Search Unavailable Manager by Username', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('durvesh294953');

      expect(
          await driver.getText(ByValueKey('Message')), 'No Manager Available');

      await driver.enterText('');

      driver.close();
    });
    test('Add Manager', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon('managerinfo');
      await DB.openCon('managerlogin');

      await driver.tap(ByValueKey('Add'));
      await driver.waitFor(ByText('Add Manager'));

      await driver.tap(ByValueKey('Name'));
      await driver.enterText('testname');
      await driver.tap(ByValueKey('Username'));
      await driver.enterText('testusername');
      await driver.tap(ByValueKey('Mobile'));
      await driver.enterText('9865465735');
      await driver.tap(ByValueKey('EmailId'));
      await driver.enterText('testemail@gmail.com');
      await driver.tap(ByValueKey('Female'));
      await driver.tap(ByValueKey('Calendar'));
      await driver.waitFor(ByValueKey('Calendar'));
      await driver.tap(ByTooltipMessage('Switch to input'));
      await driver.tap(ByType('TextField'));
      await driver.enterText('04/08/2003');
      await driver.tap(ByText('OK'));
      await driver.waitFor(ByValueKey('BranchName'));
      await driver.tap(ByValueKey('BranchName'));
      await driver.tap(ByText('Kisan Nagar Branch'));

      await driver.tap(ByValueKey('Add'));
      await driver.waitFor(ByValueKey('Title_Manager'));

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('testusername');
      String result = await driver.getText(ByText('Username: testusername'));

      expect(result, isNotEmpty);

      await driver.enterText('');
      await DB.closeCon();
      await DB.closeCon();
      driver.close();
    });
    test('Update Manager', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon('managerinfo');
      await DB.openCon('managerlogin');

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('testusername');
      await driver.tap(ByText('Username: testusername'));
      await driver.tap(ByValueKey('Update'));
      await driver.waitFor(ByText('Update Manager'));

      await driver.tap(ByValueKey('Name'));
      await driver.enterText('');
      await driver.enterText('updatedtestname');
      await driver.tap(ByValueKey('Mobile'));
      await driver.enterText('');
      await driver.enterText('7986354789');
      await driver.tap(ByValueKey('EmailId'));
      await driver.enterText('');
      await driver.enterText('updatedtestemail@gmail.com');
      await driver.tap(ByValueKey('Male'));
      await driver.tap(ByValueKey('Calendar'));
      await driver.waitFor(ByValueKey('Calendar'));
      await driver.tap(ByTooltipMessage('Switch to input'));
      await driver.tap(ByType('TextField'));
      await driver.enterText('11/23/1992');
      await driver.tap(ByText('OK'));
      await driver.waitFor(ByValueKey('BranchName'));
      await driver.tap(ByValueKey('BranchName'));
      await driver.tap(ByText('Brahmand Branch'));

      await driver.tap(ByValueKey('Update'));
      await driver.waitFor(ByValueKey('Title_Manager'));

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('testusername');

      expect(await driver.getText(ByValueKey('Name')), 'Name: updatedtestname');
      expect(await driver.getText(ByValueKey('Mobile')), 'Phone: 7986354789');
      expect(await driver.getText(ByValueKey('EmailId')),
          'EmailId: updatedtestemail@gmail.com');
      expect(await driver.getText(ByValueKey('DOB')), 'DOB: 1992-11-23');
      expect(await driver.getText(ByValueKey('Gender')), 'Gender: Male');
      expect(await driver.getText(ByValueKey('BranchName')),
          'Branch Name: Brahmand Branch');

      await driver.enterText('');

      await DB.closeCon();
      await DB.closeCon();
      driver.close();
    });
    test('Delete Manager', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon('managerinfo');
      await DB.openCon('managerlogin');

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('testusername');

      await driver.tap(ByText('Username: testusername'));
      await driver.tap(ByValueKey('Delete'));

      await driver.waitFor(ByValueKey('Title_Manager'));
      await driver.tap(ByValueKey('Search'));
      await driver.enterText('testusername');

      expect(
          await driver.getText(ByValueKey('Message')), 'No Manager Available');

      await driver.enterText('');

      await DB.closeCon();
      await DB.closeCon();
      driver.close();
    });
  });

  //Module 5
  group('Module 5: Employee', () {
    test('Load Employee Data', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon('employeeinfo');

      await driver.tap(ByValueKey('Employee'));
      String result = await driver.getText(ByValueKey('Title_Employee'));

      expect(result, 'Employee');

      await DB.closeCon();
      driver.close();
    });
    test('Search Available Employee by Username', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('durvesh8403');

      expect(await driver.getText(ByValueKey('Username')),
          'Username: durvesh8403');

      await driver.enterText('');

      driver.close();
    });
    test('Search Unavailable Employee by Username', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('durvesh294953');

      expect(
          await driver.getText(ByValueKey('Message')), 'No Employee Available');

      await driver.enterText('');

      driver.close();
    });
    test('Add Employee', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon('employeeinfo');
      await DB.openCon('employeelogin');

      await driver.tap(ByValueKey('Add'));
      await driver.waitFor(ByText('Add Employee'));

      await driver.tap(ByValueKey('Name'));
      await driver.enterText('testname');
      await driver.tap(ByValueKey('Username'));
      await driver.enterText('testusername');
      await driver.tap(ByValueKey('Mobile'));
      await driver.enterText('9865465735');
      await driver.tap(ByValueKey('EmailId'));
      await driver.enterText('testemail@gmail.com');
      await driver.tap(ByValueKey('Female'));
      await driver.tap(ByValueKey('Calendar'));
      await driver.waitFor(ByValueKey('Calendar'));
      await driver.tap(ByTooltipMessage('Switch to input'));
      await driver.tap(ByType('TextField'));
      await driver.enterText('04/08/2003');
      await driver.tap(ByText('OK'));
      await driver.waitFor(ByValueKey('BranchName'));
      await driver.tap(ByValueKey('BranchName'));
      await driver.tap(ByText('Brahmand Branch'));

      await driver.tap(ByValueKey('Add'));
      await driver.waitFor(ByValueKey('Title_Employee'));

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('testusername');
      String result = await driver.getText(ByText('Username: testusername'));

      expect(result, isNotEmpty);

      await driver.enterText('');
      await DB.closeCon();
      await DB.closeCon();
      driver.close();
    });
    test('Update Employee', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon('employeeinfo');
      await DB.openCon('employeelogin');

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('testusername');
      await driver.tap(ByText('Username: testusername'));
      await driver.tap(ByValueKey('Update'));
      await driver.waitFor(ByText('Update Employee'));

      await driver.tap(ByValueKey('Name'));
      await driver.enterText('');
      await driver.enterText('updatedtestname');
      await driver.tap(ByValueKey('Mobile'));
      await driver.enterText('');
      await driver.enterText('8988795354');
      await driver.tap(ByValueKey('EmailId'));
      await driver.enterText('');
      await driver.enterText('updatedtestemail@gmail.com');
      await driver.tap(ByValueKey('Female'));
      await driver.tap(ByValueKey('Calendar'));
      await driver.waitFor(ByValueKey('Calendar'));
      await driver.tap(ByTooltipMessage('Switch to input'));
      await driver.tap(ByType('TextField'));
      await driver.enterText('01/12/1973');
      await driver.tap(ByText('OK'));
      await driver.waitFor(ByValueKey('BranchName'));
      await driver.tap(ByValueKey('BranchName'));
      await driver.tap(ByText('Kisan Nagar Branch'));

      await driver.tap(ByValueKey('Update'));
      await driver.waitFor(ByValueKey('Title_Employee'));

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('testusername');

      expect(await driver.getText(ByValueKey('Name')), 'Name: updatedtestname');
      expect(await driver.getText(ByValueKey('Mobile')), 'Phone: 8988795354');
      expect(await driver.getText(ByValueKey('EmailId')),
          'EmailId: updatedtestemail@gmail.com');
      expect(await driver.getText(ByValueKey('DOB')), 'DOB: 1973-01-12');
      expect(await driver.getText(ByValueKey('Gender')), 'Gender: Female');
      expect(await driver.getText(ByValueKey('BranchName')),
          'Branch Name: Kisan Nagar Branch');

      await driver.enterText('');

      await DB.closeCon();
      await DB.closeCon();
      driver.close();
    });
    test('Delete Employee', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon('employeeinfo');
      await DB.openCon('employeelogin');

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('testusername');

      await driver.tap(ByText('Username: testusername'));
      await driver.tap(ByValueKey('Delete'));

      await driver.waitFor(ByValueKey('Title_Employee'));
      await driver.tap(ByValueKey('Search'));
      await driver.enterText('testusername');

      await driver.enterText('');

      await DB.closeCon();
      await DB.closeCon();
      driver.close();
    });
  });

  // Module 6
  group('Module 6: Product', () {
    test('Load Product Data', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);
      await DB.openCon("product");

      await driver.tap(ByValueKey('Product'));
      expect(await driver.getText(ByValueKey('Title_Product')), 'Product');

      await DB.closeCon();
      driver.close();
    });

    test('Search Available Product', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('Nano');

      expect(await driver.getText(ByValueKey('ProductName')),
          'Product Name: Nano');

      await driver.enterText('');

      driver.close();
    });

    test('Search Unavailable Product', () async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: url);

      await driver.tap(ByValueKey('Search'));
      await driver.enterText('Not Product');

      expect(
          await driver.getText(ByValueKey('Message')), 'No Product Available');

      await driver.enterText('');

      driver.close();
    });
  });
}
