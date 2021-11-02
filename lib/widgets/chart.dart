import 'package:expenses_tracker/model/bar.dart';
import 'package:expenses_tracker/model/transaction.dart';
import 'package:expenses_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<TransactionExp> recentTransactions;
  Chart(this.recentTransactions);

  List<Bar> get getBarsData {
    return List.generate(7, (index) {
      final barDate = DateTime.now().subtract(Duration(days: index));
      final amount = recentTransactions.fold(0.0, (sum, tx) {
        if (tx.timestamp.day == barDate.day &&
            tx.timestamp.month == barDate.month &&
            tx.timestamp.year == barDate.year)
          return sum + tx.amount;
        else
          return sum;
      });
      return Bar(
          DateFormat.E().format(barDate).substring(0, 1), amount, barDate);
    }).reversed.toList();
  }

  double get getTotalAmount {
    return getBarsData.fold(0.0, (sum, bar) {
      return sum + bar.amount;
    });
  }

  final colorBackground = Color.fromRGBO(18, 2, 22, 1);
  final colorBigCircle = Color.fromRGBO(66, 34, 74, 1);
  final colorCircle = Color.fromRGBO(143, 101, 154, 1);
  final colorChartBar = Color.fromRGBO(104, 78, 110, 1);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35), color: Colors.green),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: 380,
      height: 270,
      clipBehavior: Clip.antiAlias,
      child: Container(
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorBackground,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            Positioned(
              top: -25,
              right: -25,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: colorBigCircle),
              ),
            ),
            Positioned(
              top: 40,
              right: 40,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: colorCircle),
              ),
            ),
            Positioned.fill(
              bottom: 0,
              top: 120,
              left: 20,
              right: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: getBarsData.map((trx) {
                  return ChartBar(
                      trx.dayTitle,
                      trx.amount,
                      getTotalAmount == 0 ? 0 : trx.amount / getTotalAmount,
                      trx.barDate,
                      this.colorChartBar);
                }).toList(),
              ),
            ),
            Positioned(
              top: 25,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ukupno",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${getTotalAmount.toStringAsFixed(2)} RSD",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
/* ListView(
          scrollDirection: Axis.horizontal,
          children: getBarsData.map((trx) {
            return ChartBar(trx.dayTitle, trx.amount,
                getTotalAmount == 0 ? 0 : trx.amount / getTotalAmount);
          }).toList(),
        ), 
         Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Color.fromRGBO(66, 34, 74, 1),
                    ),
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top -
                            appBar.preferredSize.height) *
                        0.4,
                    child: 
        
        */
