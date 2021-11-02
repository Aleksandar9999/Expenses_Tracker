import 'package:expenses_tracker/dao/TransactionsDAO.dart';
import 'package:expenses_tracker/widgets/chart.dart';
import 'package:expenses_tracker/widgets/new_transaction.dart';

import './model/transaction.dart';
import './widgets/transactions_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spisak troskova',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Montserrat',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TransactionExp> _userTransactions = [];

  void _showAddNewTransaction() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  TransactionsDao transactionsDao = TransactionsDao();
  void _addNewTransaction(String title, double amount, DateTime timestamp,
      String emoji, String store) async {
    await transactionsDao.addNew(new TransactionExp(
        amount: amount,
        emoji: emoji,
        store: store,
        id: DateTime.now().toString(),
        timestamp: timestamp,
        title: title));
    _getAllTransactions();
  }

  bool _showChart = false;
  @override
  void initState() {
    transactionsDao.initDB();
    super.initState();
  }

  _getAllTransactions() async {
    transactionsDao.getAll().then((trans) {
      setState(() {
        _userTransactions = trans;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _getAllTransactions();
    final landscapeMode =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 110,
      title: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 35,
          ),
          Text("Spisak", style: TextStyle(color: Colors.black, fontSize: 27)),
          SizedBox(
            height: 5,
          ),
          Text(
            "Troškova",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
          )
        ]),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
              hoverColor: Colors.white10,
              highlightColor: Colors.white10,
              icon:
                  Icon(Icons.add_circle_outline, size: 36, color: Colors.black),
              onPressed: _showAddNewTransaction),
        )
      ],
    );

    final listWidget =
        Container(height: 350, child: TransactionList(_userTransactions));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (landscapeMode)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Show chart"),
                    Switch(
                        value: _showChart,
                        onChanged: (val) {
                          setState(() {
                            _showChart = val;
                          });
                        })
                  ],
                ),
              if (!landscapeMode) Chart(_userTransactions),
              if (!landscapeMode) listWidget,
              if (landscapeMode)
                _showChart
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top -
                                appBar.preferredSize.height) *
                            0.6,
                        child: Chart(_userTransactions))
                    : listWidget
            ],
          ),
        ),
      ),
    );
  }
}
