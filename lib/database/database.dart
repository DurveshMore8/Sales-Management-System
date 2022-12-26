// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:mongo_dart/mongo_dart.dart';

class DB {
  //variable declaration
  static const url =
      "mongodb+srv://DurveshMore:durvesh8@durveshmore.l1ois12.mongodb.net/sadms?retryWrites=true&w=majority";
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

  //Function to Close Connection
  static closeCon() async {
    await database.close();
  }
}
