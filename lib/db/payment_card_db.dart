import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payment_card/model/payment_card.dart';
import 'package:sqflite/sqflite.dart';

class PaymentCartDB {
  static final _paymentCardDB = PaymentCartDB._internal();

  String tblPaymentCard = "payment_cards";
  String colId = "id";
  String colBank = "bank";
  String colCardType = "cardType";
  String colCardNumber = "cardNumber";
  String colExpiryMonth = "expiryMonth";
  String colExpiryYear = "expiryYear";
  String colCvv = "cvv";
  String colCardHolderName = "cardHolderName";
  String colShortName = "shortName";

  PaymentCartDB._internal();

  factory PaymentCartDB() {
    return _paymentCardDB;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    debugPrint('Initializing DB');
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "payment_cards.db";
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  void _createDb(Database db, int newVersion) async {
    debugPrint('Create DB');
    await db.execute('CREATE TABLE $tblPaymentCard ('
        '$colId INTEGER PRIMARY KEY,'
        '$colBank TEXT,'
        '$colCardType TEXT,'
        '$colCardNumber TEXT,'
        '$colExpiryMonth INTEGER,'
        '$colExpiryYear INTEGER,'
        '$colCvv TEXT,'
        '$colCardHolderName TEXT,'
        '$colShortName TEXT'
        ')');
  }

  Future<int> save(PaymentCard paymentCard) async {
    debugPrint('Inserting into database: ' + paymentCard.toString());
    Database db = await this.db;
    var result = await db.insert(tblPaymentCard, paymentCard.toMap());
    return result;
  }

  Future<List> findAll() async {
    debugPrint('Find All Payment Cards.');
    Database db = await this.db;
    var result = await db
        .rawQuery('SELECT * FROM $tblPaymentCard ORDER BY $colShortName ASC');

    return result;
  }

  Future<int> count() async {
    debugPrint('Count Payment Cards');
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tblPaymentCard'));

    return result;
  }

  Future<int> update(PaymentCard paymentCard) async {
    debugPrint('Update Payment Card: ' + paymentCard.toString());
    Database db = await this.db;
    var result = await db.update(
      tblPaymentCard,
      paymentCard.toMap(),
      where: '$colId = ?',
      whereArgs: [paymentCard.id],
    );
    return result;
  }

  Future<int> delete(int id) async {
    debugPrint('Delete Payment Card with ID: ' + id.toString());
    Database db = await this.db;
    var result =
        await db.delete(tblPaymentCard, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteAll() async {
    debugPrint('Deleting all Payment Card');
    Database db = await this.db;
    var result = await db.delete(tblPaymentCard);
    return result;
  }
}
