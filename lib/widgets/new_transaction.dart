import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;
  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = new TextEditingController();
  final emojiController = new TextEditingController();
  final storeController = new TextEditingController();
  final amountController = new TextEditingController();
  DateTime _selectedDate;
  void addTransaction() {
    final String titleEntered = titleController.text;
    final double amountEntered = double.parse(amountController.text);
    if (titleEntered.isEmpty || amountEntered <= 0 || _selectedDate == null)
      return;
    widget._addNewTransaction(
        titleController.text,
        double.parse(amountController.text),
        _selectedDate,
        emojiController.text,
        storeController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              left: 10,
              right: 10,
              top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: emojiController,
                decoration: InputDecoration(labelText: "Emoji"),
                onSubmitted: (_) => addTransaction(),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
                onSubmitted: (_) => addTransaction(),
              ),
              TextField(
                controller: storeController,
                decoration: InputDecoration(labelText: "Store"),
                onSubmitted: (_) => addTransaction(),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onSubmitted: (_) => addTransaction(),
                controller: amountController,
                decoration: InputDecoration(labelText: "Amount"),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDate == null
                      ? "Choose date"
                      : DateFormat.yMd().format(_selectedDate)),
                  ElevatedButton(
                      child: Text("Choose date"),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2021),
                                lastDate: DateTime.now())
                            .then((value) {
                          setState(() {
                            _selectedDate = value;
                          });
                        });
                      })
                ],
              ),
              TextButton(
                  onPressed: addTransaction,
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
