import '../model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionExp> transactions;
  DateTime lastDateTime = null;
  TransactionList(this.transactions);

  firstDate(dateTime) {
    lastDateTime = dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*if (lastDateTime == null)
                  firstDate(transactions[index].timestamp),*/
                chackNewDate(transactions[index].timestamp),
                ListTile(
                  leading: Container(
                    height: 60,
                    width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 244, 247, 1),
                        borderRadius: BorderRadius.circular(18)),
                    child: Text(
                      transactions[index].emoji,
                      style: TextStyle(fontFamily: 'EmojiOne', fontSize: 23),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    transactions[index].store,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Text(
                      "-${transactions[index].amount.toStringAsFixed(2)} RSD",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          );
        });
  }

  chackNewDate(DateTime timestamp) {
    /*if (lastDateTime == null) lastDateTime = timestamp;*/
    var dateFormater = new DateFormat('YYYY-MMM-DDD');
    if (dateFormater.format(timestamp) == dateFormater.format(DateTime.now())) {
      return ListTile(
          title: Text(
        "Today",
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
      ));
    } else {
      return ListTile(
          title: Text(DateFormat('dd MMM').format(timestamp),
              style:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)));
    }
    //return Text("");
  }
}
