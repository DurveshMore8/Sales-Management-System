// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:mongo_dart/mongo_dart.dart';

class DB {
  //variable declaration
  static const url =
      "<<ADD YOUR OWN MONGO URL>>";
  static var database, collection;

  //Function to Open Connection
  static openCon(var col) async {
    database = await Db.create(url);
    await database.open();
    collection = database.collection(col);
  }

  //Function to Update
  static updatedata(
      String eqkey, String eqvalue, String setkey, var setvalue) async {
    await DB.collection
        .updateOne(where.eq(eqkey, eqvalue), modify.set(setkey, setvalue));
  }

  //Function to update stock
  static updatestock(List data, int value) async {
    await DB.collection.updateOne(
        where
            .eq('ProductId', data[0]['ProductId'])
            .eq('ProductName', data[0]['ProductName'])
            .eq('BranchName', data[0]['BranchName']),
        modify.set('Quantity', value));
  }

  //Function to Close Connection
  static closeCon() async {
    await database.close();
  }
}
