import 'package:flutter/cupertino.dart';

class PaymentCard {
  int _id;
  String _bank;
  CardType _cardType;
  String _cardNumber;
  int _expiryMonth;
  int _expiryYear;
  String _cvv;
  String _cardHolderName;
  String _shortName;

  PaymentCard(this._bank, this._cardType, this._cardNumber, this._expiryMonth,
      this._expiryYear, this._cvv, this._cardHolderName) {
    this.shortName = generateShortName();
  }

  PaymentCard.empty() {
    this.cardType = CardType.DEBIT;
    this._expiryMonth = DateTime
        .now()
        .month;
    this._expiryYear = DateTime
        .now()
        .year;
  }

  String get shortName => _shortName;

  set shortName(String value) {
    _shortName = value;
  }

  String get cardHolderName => _cardHolderName;

  set cardHolderName(String value) {
    _cardHolderName = value;
  }

  String get cvv => _cvv;

  set cvv(String value) {
    _cvv = value;
  }

  int get expiryYear => _expiryYear;

  set expiryYear(int value) {
    _expiryYear = value;
  }

  int get expiryMonth => _expiryMonth;

  set expiryMonth(int value) {
    _expiryMonth = value;
  }

  String get cardNumber => _cardNumber;

  set cardNumber(String value) {
    _cardNumber = value;
  }

  CardType get cardType => _cardType;

  set cardType(CardType value) {
    _cardType = value;
  }

  String get bank => _bank;

  set bank(String value) {
    _bank = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["bank"] = _bank;
    map["cardType"] = _cardType.name;
    map["cardNumber"] = _cardNumber;
    map["expiryMonth"] = _expiryMonth;
    map["expiryYear"] = _expiryYear;
    map["cvv"] = _cvv;
    map["cardHolderName"] = _cardHolderName;
    map["shortName"] = _shortName;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  PaymentCard.fromObject(dynamic obj) {
    this._id = obj["id"];
    this._bank = obj["bank"];
    this._cardType = _fromString(obj["cardType"]);
    this._cardNumber = obj["cardNumber"];
    this._expiryMonth = obj["expiryMonth"];
    this._expiryYear = obj["expiryYear"];
    this._cvv = obj["cvv"];
    this._cardHolderName = obj["cardHolderName"];
    this._shortName = obj["shortName"];
    debugPrint('From Object: ' + this.toString());
  }

  @override
  String toString() {
    return 'PaymentCard{_id: $_id, _bank: $_bank, _cardType: $_cardType, _cardNumber: $_cardNumber, _expiryMonth: $_expiryMonth, _expiryYear: $_expiryYear, _cvv: $_cvv, _cardHolderName: $_cardHolderName, _shortName: $_shortName}';
  }

  String generateShortName() {
    return this.cardHolderName.split(' ')[0] +
        ' - ' +
        this.bank +
        ' - ' +
        this.cardType.name;
  }
}

enum CardType {
  DEBIT,
  CREDIT,
}

extension CardTypeExt on CardType {
  String get name {
    return this
        .toString()
        .split('.')
        .last;
  }
}

CardType _fromString(String card) {
  switch (card) {
    case 'DEBIT' :
      return CardType.DEBIT;
    case 'CREDIT' :
      return CardType.CREDIT;
    default :
      return CardType.DEBIT;
  }
}