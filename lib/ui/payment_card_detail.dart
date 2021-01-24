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

  bool _hiddenCsv = true;

  void _toggleHiddenCsv() {
    setState(() {
      _hiddenCsv = !_hiddenCsv;
    });
  }

  TextEditingController bankController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  bool enableGrid = false;
  TextEditingController gridAController = TextEditingController();
  TextEditingController gridBController = TextEditingController();
  TextEditingController gridCController = TextEditingController();
  TextEditingController gridDController = TextEditingController();
  TextEditingController gridEController = TextEditingController();
  TextEditingController gridFController = TextEditingController();
  TextEditingController gridGController = TextEditingController();
  TextEditingController gridHController = TextEditingController();
  TextEditingController gridIController = TextEditingController();
  TextEditingController gridJController = TextEditingController();
  TextEditingController gridKController = TextEditingController();
  TextEditingController gridLController = TextEditingController();
  TextEditingController gridMController = TextEditingController();
  TextEditingController gridNController = TextEditingController();
  TextEditingController gridOController = TextEditingController();
  TextEditingController gridPController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bankController.text = paymentCard.bank;
    cardNumberController.text = paymentCard.cardNumber;
    cvvController.text = paymentCard.cvv;
    nameController.text = paymentCard.cardHolderName;
    monthController.text = paymentCard.expiryMonth.toString();
    yearController.text = paymentCard.expiryYear.toString();
    enableGrid = paymentCard.enableGrid;

    if (enableGrid) {
      gridAController.text = paymentCard.grid.gridA;
      gridBController.text = paymentCard.grid.gridB;
      gridCController.text = paymentCard.grid.gridC;
      gridDController.text = paymentCard.grid.gridD;
      gridEController.text = paymentCard.grid.gridE;
      gridFController.text = paymentCard.grid.gridF;
      gridGController.text = paymentCard.grid.gridG;
      gridHController.text = paymentCard.grid.gridH;
      gridIController.text = paymentCard.grid.gridI;
      gridJController.text = paymentCard.grid.gridJ;
      gridKController.text = paymentCard.grid.gridK;
      gridLController.text = paymentCard.grid.gridL;
      gridMController.text = paymentCard.grid.gridM;
      gridNController.text = paymentCard.grid.gridN;
      gridOController.text = paymentCard.grid.gridO;
      gridPController.text = paymentCard.grid.gridP;
    }

    textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text('Card Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: getBankWidget(),
                    ),
                    Expanded(
                      flex: 2,
                      child: getCardTypeWidget(),
                    ),
                  ],
                ),
                getCardNumberWidget(),
                getCvvWidget(),
                getNameWidget(),
                Row(
                  children: [
                    Expanded(
                      child: getMonthWidget(),
                    ),
                    Expanded(
                      child: getYearWidget(),
                    ),
                  ],
                ),
                getEnableGridWidget(),
                gridWidget(),
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
    } else if (enableGrid &&
            (emptyText(gridAController.text) ||
            emptyText(gridBController.text) ||
            emptyText(gridCController.text) ||
            emptyText(gridDController.text) ||
            emptyText(gridEController.text) ||
            emptyText(gridFController.text) ||
            emptyText(gridGController.text) ||
            emptyText(gridHController.text) ||
            emptyText(gridIController.text) ||
            emptyText(gridJController.text) ||
            emptyText(gridKController.text) ||
            emptyText(gridLController.text) ||
            emptyText(gridMController.text) ||
            emptyText(gridNController.text) ||
            emptyText(gridOController.text) ||
            emptyText(gridPController.text))) {
      await showAlertDialog("Grid Fields are empty");
      result = false;
    }
    return result;
  }

  bool emptyText(String text) {
    return text == null || text.isEmpty;
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
            content: Text(
              messageContent,
            ),
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

  Widget gridWidget() {
    if (!enableGrid) {
      return Container();
    }

    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridAController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridA = gridAController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'A',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridBController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridB = gridBController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'B',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridCController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridC = gridCController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'C',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridDController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridD = gridDController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'D',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridEController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridE = gridEController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'E',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridFController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridF = gridFController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'F',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridGController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridG = gridGController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'G',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridHController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridH = gridHController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'H',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridIController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridI = gridIController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'I',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridJController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridJ = gridJController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'J',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridKController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridK = gridKController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'K',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridLController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridL = gridLController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'L',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridMController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridM = gridMController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'M',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridNController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridN = gridNController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'N',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridOController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridO = gridOController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'O',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 10),
                child: TextField(
                  controller: gridPController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => {
                    this.paymentCard.grid.gridP = gridPController.text,
                  },
                  decoration: InputDecoration(
                    labelText: 'P',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getBankWidget() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0, top: 10.0, right: 10.0),
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
    );
  }

  Widget getCardTypeWidget() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10.0,
        top: 10.0,
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.6, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
            onChanged: (CardType value) => updateCardType(value),
          ),
        ),
      ),
    );
  }

  Widget getCardNumberWidget() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: TextField(
        controller: cardNumberController,
        style: textStyle,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) => updateCardNumber(),
        decoration: InputDecoration(
            labelText: 'Card Number',
            labelStyle: textStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
      ),
    );
  }

  Widget getCvvWidget() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: TextField(
        controller: cvvController,
        style: textStyle,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) => updateCvv(),
        obscureText: _hiddenCsv,
        decoration: InputDecoration(
          labelText: 'CVV',
          labelStyle: textStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: IconButton(
            onPressed: _toggleHiddenCsv,
            icon: _hiddenCsv
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
          ),
        ),
      ),
    );
  }

  Widget getNameWidget() {
    return Padding(
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
    );
  }

  Widget getMonthWidget() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0, right: 5.0),
      child: TextField(
        controller: monthController,
        style: textStyle,
        onChanged: (value) => updateExpiryMonth(),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
            labelText: 'Expiry Month',
            labelStyle: textStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
      ),
    );
  }

  Widget getYearWidget() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0, left: 5.0),
      child: TextField(
        controller: yearController,
        style: textStyle,
        onChanged: (value) => updateExpiryYear(),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
            labelText: 'Expiry Year',
            labelStyle: textStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
      ),
    );
  }

  Widget getEnableGridWidget() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: CheckboxListTile(
        title: Text(
          'Enable Grid',
          style: textStyle,
        ),
        value: enableGrid,
        onChanged: (bool value) {
          setState(() {
            paymentCard.enableGrid = value;
            enableGrid = value;
          });
        },
      ),
    );
  }
}
