import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payment_card/db/payment_card_db.dart';

import '../model/payment_card.dart';

PaymentCartDB db = PaymentCartDB();
TextStyle textStyle;

class PaymentCardDetail extends StatefulWidget {
  final PaymentCard paymentCard;

  PaymentCardDetail(this.paymentCard);

  @override
  _PaymentCardDetailState createState() => _PaymentCardDetailState(paymentCard);
}

class _PaymentCardDetailState extends State<PaymentCardDetail> {
  PaymentCard paymentCard;

  _PaymentCardDetailState(this.paymentCard);

  TextEditingController bankController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bankController.text = paymentCard.bank;
    cardNumberController.text = paymentCard.cardNumber;
    cvvController.text = paymentCard.cvv;
    nameController.text = paymentCard.cardHolderName;
    monthController.text = paymentCard.expiryMonth.toString();
    yearController.text = paymentCard.expiryYear.toString();

    textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text('Card Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 10.0, top: 10.0, right: 10.0),
                        child: TextField(
                          controller: bankController,
                          style: textStyle,
                          onChanged: (value) => updateBank(),
                          decoration: InputDecoration(
                              labelText: 'Bank',
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 10.0,
                          top: 10.0,
                        ),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.6, style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ListTile(
                            title: DropdownButton<CardType>(
                              style: textStyle,
                              items: CardType.values
                                  .map((e) => DropdownMenuItem<CardType>(
                                        value: e,
                                        child: Text(e.name),
                                      ))
                                  .toList(),
                              value: paymentCard.cardType,
                              onChanged: (CardType value) =>
                                  updateCardType(value),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: TextField(
                    controller: cardNumberController,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) => updateCardNumber(),
                    decoration: InputDecoration(
                        labelText: 'Card Number',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: TextField(
                    controller: cvvController,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) => updateCvv(),
                    decoration: InputDecoration(
                        labelText: 'CVV',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: TextField(
                    controller: nameController,
                    style: textStyle,
                    onChanged: (value) => updateName(),
                    decoration: InputDecoration(
                        labelText: 'Card Holder Name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15.0, right: 5.0),
                        child: TextField(
                          controller: monthController,
                          style: textStyle,
                          onChanged: (value) => updateExpiryMonth(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                              labelText: 'Expiry Month',
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15.0, left: 5.0),
                        child: TextField(
                          controller: yearController,
                          style: textStyle,
                          onChanged: (value) => updateExpiryYear(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                              labelText: 'Expiry Year',
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    saveButton(),
                    backButton(),
                    deleteButton(),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void updateBank() {
    this.paymentCard.bank = bankController.text.toUpperCase();
  }

  void updateCardType(CardType cardType) {
    this.paymentCard.cardType = cardType;
    setState(() {});
  }

  void updateCardNumber() {
    this.paymentCard.cardNumber = cardNumberController.text;
  }

  void updateCvv() {
    this.paymentCard.cvv = cvvController.text;
  }

  void updateName() {
    this.paymentCard.cardHolderName = nameController.text;
  }

  void updateExpiryMonth() {
    this.paymentCard.expiryMonth = int.parse(monthController.text);
  }

  void updateExpiryYear() {
    this.paymentCard.expiryYear = int.parse(yearController.text);
  }

  Widget saveButton() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: RaisedButton(
          color: Theme.of(context).primaryColorDark,
          textColor: Theme.of(context).primaryColorLight,
          elevation: 20.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: onSaveButtonPressed,
          child: Text(
            'Save',
            textScaleFactor: 1.5,
          ),
        ),
      ),
    );
  }

  onSaveButtonPressed() async {
    debugPrint('Saving Payment Card' + paymentCard.toString());
    if (await validateSave() == false) return;
    paymentCard.shortName = paymentCard.generateShortName();
    if (paymentCard.id != null) {
      db.update(paymentCard);
    } else {
      db.save(paymentCard);
    }
    Navigator.pop(context, true);
  }

  Widget backButton() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: RaisedButton(
          color: Theme.of(context).primaryColorDark,
          textColor: Theme.of(context).primaryColorLight,
          elevation: 20.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: onBackButtonPressed,
          child: Text(
            'Back',
            textScaleFactor: 1.5,
          ),
        ),
      ),
    );
  }

  onBackButtonPressed() {
    Navigator.pop(context, true);
  }

  Widget deleteButton() {
    return paymentCard.id == null
        ? Container()
        : Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                color: Colors.redAccent,
                textColor: Colors.white70,
                elevation: 20.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: confirmDeleteDialog,
                child: Text(
                  'Delete',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
          );
  }

  Future<void> confirmDeleteDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Delete Card",
              style: textStyle,
            ),
            content: Text('Are you sure you want to delete this card'),
            actions: <Widget>[
              RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(
                  'No',
                  textScaleFactor: 1.5,
                ),
              ),
              RaisedButton(
                color: Colors.redAccent,
                textColor: Colors.white70,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {
                  onDeleteButtonPressed();
                  Navigator.pop(context, true);
                },
                child: Text(
                  'Yes',
                  textScaleFactor: 1.5,
                ),
              ),
              //FlatButton("OK")
            ],
            elevation: 24.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          );
        });
  }

  onDeleteButtonPressed() {
    debugPrint('Deleting Payment Card' + paymentCard.toString());
    if (paymentCard.id != null) {
      db.delete(paymentCard.id);
    }
    Navigator.pop(context, true);
  }

  Future<bool> validateSave() async {
    bool result = true;
    if (paymentCard.bank == null || paymentCard.bank.isEmpty) {
      await showAlertDialog("Bank is empty");
      result = false;
    } else if (cardNumberController.text == null ||
        cardNumberController.text.isEmpty) {
      await showAlertDialog("Card Number is empty");
      result = false;
    } else if (cvvController.text == null || cvvController.text.isEmpty) {
      await showAlertDialog("CVV is empty");
      result = false;
    } else if (nameController.text == null || nameController.text.isEmpty) {
      await showAlertDialog("Card Holder Name is empty");
      result = false;
    } else if (monthController.text == null || monthController.text.isEmpty) {
      await showAlertDialog("Month is empty");
      result = false;
    } else if (yearController.text == null || yearController.text.isEmpty) {
      await showAlertDialog("Year is empty");
      result = false;
    } else if (int.parse(monthController.text) < 1 ||
        int.parse(monthController.text) > 12) {
      await showAlertDialog("Month should be between 1 to 12");
      result = false;
    } else if (int.parse(yearController.text) < 2000 ||
        int.parse(yearController.text) > 2100) {
      await showAlertDialog("Year should be between 2000 and 2100");
      result = false;
    }

    return result;
  }

  Future<void> showAlertDialog(String messageContent) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Forget something?",
              style: textStyle,
            ),
            content: Text(messageContent,),
            actions: <Widget>[
              RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(
                  'OK',
                  textScaleFactor: 1.5,
                ),
              ),
            ],
            elevation: 24.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          );
        });
  }
}
