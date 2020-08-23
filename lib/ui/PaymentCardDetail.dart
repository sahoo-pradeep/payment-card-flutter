import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payment_card/db/PaymentCardDB.dart';

import '../model/PaymentCard.dart';

PaymentCartDB db = PaymentCartDB();

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

    TextStyle textStyle = Theme.of(context).textTheme.headline6;

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
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                    top: 10.0,
                  ),
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
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: ListTile(
                    title: DropdownButton<CardType>(
                      items: CardType.values
                          .map((e) => DropdownMenuItem<CardType>(
                                value: e,
                                child: Text(e.name),
                              ))
                          .toList(),
                      style: textStyle,
                      value: paymentCard.cardType,
                      onChanged: (CardType value) => updateCardType(value),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: TextField(
                    controller: cardNumberController,
                    style: textStyle,
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
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
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
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
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
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          onPressed: () => onSaveButtonPressed(),
                          child: Text(
                            "Save",
                            textScaleFactor: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          onPressed: () => onBackButtonPressed(),
                          child: Text(
                            "Back",
                            textScaleFactor: 1.5,
                          ),
                        ),
                      ),
                    ),
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
    this.paymentCard.bank = bankController.text;
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

  onSaveButtonPressed() {
    debugPrint('Saving Payment Card' + paymentCard.toString());
    paymentCard.shortName = paymentCard.generateShortName();
    if (paymentCard.id != null) {
      db.update(paymentCard);
    } else {
      db.save(paymentCard);
    }
    Navigator.pop(context, true);
  }

  onBackButtonPressed() {
    Navigator.pop(context, true);
  }

  onDeleteButtonPressed() {
    debugPrint('Deleting Payment Card' + paymentCard.toString());
    if (paymentCard.id != null) {
      db.delete(paymentCard.id);
    }
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
                onPressed: () => onDeleteButtonPressed(),
                child: Text(
                  "Delete",
                  textScaleFactor: 1.5,
                ),
              ),
            ),
          );
  }
}
