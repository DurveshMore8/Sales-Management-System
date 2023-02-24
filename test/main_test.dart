// ignore_for_file: unused_local_variable, prefer_const_constructors, await_only_futures

@Timeout(Duration(seconds: 200))

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sadms/Database/database.dart';

void main() {
  late FlutterDriver driver;

  void start() async {
    driver = await FlutterDriver.connect(
        dartVmServiceUrl: 'ws://127.0.0.1:49181/6bogwAWK1zk=/ws');
  }

  void end() async {
    driver.close();
  }

  // Module 1
  group('Module 1', () {
    test('Manager Login Valid', () async {
      start();
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

      await driver.tap(ByText('Log Out'));

      await DB.closeCon();
      end();
    });

    test('Manager Login Invalid', () async {
      start();
      await DB.openCon("managerlogin");

      await driver.tap(ByValueKey('M-Username'));
      await driver.enterText('durvesh8403');
      await driver.tap(ByValueKey('M-EmailId'));
      await driver.enterText('durveshmore2003@gmail.com');
      await driver.tap(ByValueKey('M-Password'));
      await driver.enterText('durvesh');
      await driver.tap(ByValueKey('Login'));

      await driver.waitFor(ByText('Login Page'));
      String result = await driver.getText(ByValueKey('M-Password'));

      expect(result, isEmpty);

      await driver.tap(ByValueKey('Clear'));

      await DB.closeCon();
      end();
    });

    test('Employee Login Valid', () async {
      start();
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
      end();
    });

    test('Employee Login Invalid', () async {
      start();
      await DB.openCon('employeelogin');

      await driver.tap(ByValueKey('E-Username'));
      await driver.enterText('durvesh8403');
      await driver.tap(ByValueKey('E-Password'));
      await driver.enterText('durvesh');
      await driver.tap(ByValueKey('Login'));

      await driver.waitFor(ByText('Login Page'));
      String result = await driver.getText(ByValueKey('E-Password'));

      expect(result, isEmpty);

      await driver.tap(ByValueKey('Clear'));

      DB.closeCon();
      end();
    });
  });
}
