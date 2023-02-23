// ignore_for_file: unused_local_variable, prefer_const_constructors, await_only_futures

@Timeout(Duration(seconds: 200))

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sadms/Database/database.dart';

void main() {
  test('Manager Login Valid', () async {
    final driver = await FlutterDriver.connect(
        dartVmServiceUrl: 'ws://127.0.0.1:50446/GdbI5ylFWWs=/ws');
    await DB.openCon("managerlogin");

    await driver.tap(ByValueKey('Username'));
    await driver.enterText('durvesh8403');
    await driver.tap(ByValueKey('EmailId'));
    await driver.enterText('durveshmore2003@gmail.com');
    await driver.tap(ByValueKey('Password'));
    await driver.enterText('durvesh8');
    await driver.tap(ByValueKey('Login'));

    await driver.waitFor(ByValueKey('ManagerName'));
    String result = await driver.getText(ByValueKey('ManagerName'));

    expect(result, equals('durvesh8403'));

    await driver.close();
    await DB.closeCon();
  });
}
