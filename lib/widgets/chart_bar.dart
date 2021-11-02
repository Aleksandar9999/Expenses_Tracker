import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String dayTitle;
  final DateTime chartBarDate;
  final double amount;
  final double proecentageOfSum;
  Color barColor;
  ChartBar(this.dayTitle, this.amount, this.proecentageOfSum, this.chartBarDate,
      this.barColor);
  bool get today {
    final today = DateTime.now();
    return this.chartBarDate.day == today.day &&
        this.chartBarDate.month == today.month &&
        this.chartBarDate.year == today.year;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            height: 15,
            child: FittedBox(
                child: Text(
              '\ ${amount.toStringAsFixed(2)} RSD',
              style: TextStyle(color: Colors.white),
            ))),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 80,
          width: 30,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: proecentageOfSum,
                child: Container(
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      colors: today
                          ? [Colors.orange[600], Colors.orange[300]]
                          : [barColor, barColor]),
                )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
            height: 15,
            child: FittedBox(
                child: Text(
              dayTitle,
              style: TextStyle(color: Colors.white),
            ))),
      ],
    );
  }
}
