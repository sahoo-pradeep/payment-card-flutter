import 'dart:io';

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
  String colEnableGrid = 'enableGrid';

  String colGridA = "gridA";
  String colGridB = "gridB";
  String colGridC = "gridC";
  String colGridD = "gridD";
  String colGridE = "gridE";
  String colGridF = "gridF";
  String colGridG = "gridG";
  String colGridH = "gridH";
  String colGridI = "gridI";
  String colGridJ = "gridJ";
  String colGridK = "gridK";
  String colGridL = "gridL";
  String colGridM = "gridM";
  String colGridN = "gridN";
  String colGridO = "gridO";
  String colGridP = "gridP";

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
    print('Initializing DB');
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "payment_cards.db";
    var dbPaymentCard =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return dbPaymentCard;
  }

  void _createDb(Database db, int newVersion) async {
    print('Create DB');
    await db.execute('CREATE TABLE $tblPaymentCard ('
        '$colId INTEGER PRIMARY KEY,'
        '$colBank TEXT,'
        '$colCardType TEXT,'
        '$colCardNumber TEXT,'
        '$colExpiryMonth INTEGER,'
        '$colExpiryYear INTEGER,'
        '$colCvv TEXT,'
        '$colCardHolderName TEXT,'
        '$colShortName TEXT,'
        '$colEnableGrid INTEGER,'
        '$colGridA TEXT,'
        '$colGridB TEXT,'
        '$colGridC TEXT,'
        '$colGridD TEXT,'
        '$colGridE TEXT,'
        '$colGridF TEXT,'
        '$colGridG TEXT,'
        '$colGridH TEXT,'
        '$colGridI TEXT,'
        '$colGridJ TEXT,'
        '$colGridK TEXT,'
        '$colGridL TEXT,'
        '$colGridM TEXT,'
        '$colGridN TEXT,'
        '$colGridO TEXT,'
        '$colGridP TEXT'
        ')');
  }

  Future<int> save(PaymentCard paymentCard) async {
    print('Inserting into database: ' + paymentCard.toString());
    Database db = await this.db;
    var paymentCardId = await db.insert(tblPaymentCard, paymentCard.toMap());

    return paymentCardId;
  }

  Future<List> findAll() async {
    print('Find All Payment Cards.');
    Database db = await this.db;
    var result = await db
        .rawQuery('SELECT * FROM $tblPaymentCard ORDER BY $colShortName ASC');

    return result;
  }

  Future<int> count() async {
    print('Count Payment Cards');
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tblPaymentCard'));

    return result;
  }

  Future<int> update(PaymentCard paymentCard) async {
    print('Update Payment Card: ' + paymentCard.toString());
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
    print('Delete Payment Card with ID: ' + id.toString());
    Database db = await this.db;
    var result =
        await db.delete(tblPaymentCard, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteAll() async {
    print('Deleting all Payment Card');
    Database db = await this.db;
    var result = await db.delete(tblPaymentCard);
    return result;
  }
}
