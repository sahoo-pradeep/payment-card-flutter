import 'package:flutter/material.dart';
import 'package:payment_card/db/payment_card_db.dart';
import 'package:payment_card/model/payment_card.dart';
import 'package:payment_card/ui/payment_card_detail.dart';

class PaymentCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payment Cards',
      theme: ThemeData(
        //brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PaymentCardPage(title: 'Payment Cards'),
    );
  }
}

class PaymentCardPage extends StatefulWidget {
  PaymentCardPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PaymentCardPageState createState() => _PaymentCardPageState();
}

class _PaymentCardPageState extends State<PaymentCardPage> {
  PaymentCartDB db = PaymentCartDB();
  List<PaymentCard> paymentCards;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (paymentCards == null) {
      paymentCards = List<PaymentCard>();
      populatePaymentCards();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: getPaymentCards(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(PaymentCard.empty());
        },
        tooltip: 'Add Card',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getPaymentCards() {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Theme.of(context).primaryColorLight,
          elevation: 2.0,
          child: ListTile(
            title: Text(
              this.paymentCards[index].shortName,
              style: textStyle,
            ),
            onTap: () {
              debugPrint(
                  'Tapped on card: ' + this.paymentCards[index].toString());
              navigateToDetail(this.paymentCards[index]);
            },
          ),
        );
      },
    );
  }

  void navigateToDetail(PaymentCard paymentCard) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentCardDetail(paymentCard),
      ),
    );

    if (result == true) {
      populatePaymentCards();
    }
  }

  void populatePaymentCards() {
    final dbFuture = db.initializeDb();
    dbFuture.then((value) {
      final paymentCardsFuture = db.findAll();
      paymentCardsFuture.then((value) {
        List<PaymentCard> paymentCardList = List<PaymentCard>();
        count = value.length;

        for (int i = 0; i < count; i++) {
          paymentCardList.add(PaymentCard.fromObject(value[i]));
          debugPrint(paymentCardList[i].shortName);
        }

        setState(() {
          this.paymentCards = paymentCardList;
          this.count = paymentCardList.length;
        });
        debugPrint("Items " + count.toString());
      });
    });
  }
}
