import 'package:example/model/transaction_data.dart';
import 'package:example/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  String description = '';
  String name = '';
  String price = '';
  DateTime date = DateTime.now();

  void showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().month - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    ).then((val) {
      setState(() {
        date = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                LiteRollingSwitch(
                  //initial value
                  value: false,
                  textOn: 'Income',
                  textOff: 'Expense',
                  colorOn: Colors.green[800],
                  colorOff: Colors.red[800],
                  iconOn: FontAwesomeIcons.moneyBill,
                  iconOff: FontAwesomeIcons.moneyBill,
                  textSize: 16.0,
                  onChanged: (bool state) {

                    Provider.of<TransactionData>(context, listen: false)
                        .updaterChanger(state);
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Valid Name';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  label: const Text('Name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onSaved: (value) {
                  name = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Valid Description';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  label: const Text('Description'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onSaved: (value) {
                  description = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  final pattern = RegExp("^[0-9]{1,10}");
                  if (value.isEmpty) {
                    return 'Enter the price';
                  } else if (!pattern.hasMatch(value)) {
                    return 'Enter Valid valid price';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  label: const Text('Item Price'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onSaved: (value) {
                  price = value;
                },
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: showDate,
                  icon: const Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  DateFormat.yMMMEd().format(date),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    double total =
                        Provider.of<TransactionData>(context, listen: false)
                            .addTotalPrice(double.parse(price));
                    final newExpense = TransactionModel(
                      name: name,
                      description: description,
                      price: price,
                      date: date.toString(),
                      total: total.toStringAsFixed(2),
                    );
                    Provider.of<TransactionData>(context, listen: false)
                        .addExpenseList(newExpense);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save Expense'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
