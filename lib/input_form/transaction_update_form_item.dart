import 'package:example/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

import '../model/transaction_data.dart';

class TransactionUpdateForm extends StatefulWidget {
  int index;
  String existedDescription;
  String existedName;
  bool isExpense;
  String existedPrice;
  String existedDate;
  bool existedIsIncome;

  TransactionUpdateForm(
      {Key key,
      this.isExpense,
      this.existedName,
      this.existedPrice,
      this.existedDate,
      this.index,
      this.existedDescription,
      this.existedIsIncome})
      : super(key: key);

  @override
  State<TransactionUpdateForm> createState() => _TransactionUpdateFormState();
}

class _TransactionUpdateFormState extends State<TransactionUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  bool isTapped = false;
  String updatedName = '';
  String updatedDescription = '';
  String updatedPrice = '';
  DateTime updatedDate = DateTime.now();
  int checkIsIncome = 0;
  void showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().month - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    ).then((val) {
      setState(() {
        if (val != null) {
          updatedDate = val;
        } else {
          updatedDate = DateTime.now();
        }
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
                  value: widget.isExpense,
                  textOn: 'Income',
                  textOff: 'Expense',
                  colorOn: Colors.green[800],
                  colorOff: Colors.red[800],
                  iconOn: FontAwesomeIcons.moneyBill,
                  iconOff: FontAwesomeIcons.moneyBill,
                  textSize: 16.0,
                  onChanged: (bool state) {
                    if (state == false) {
                      checkIsIncome = 0;
                    } else {
                      checkIsIncome = 1;
                    }
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.existedName,
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
                  updatedName = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.existedDescription,
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
                  updatedDescription = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.existedPrice.toString(),
                validator: (value) {
                  final pattern = RegExp("^[0-9]{1,10}");
                  if (value.isEmpty) {
                    return 'Enter the price';
                  } else if (!pattern.hasMatch(value)) {
                    return 'Enter Valid price';
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
                  updatedPrice = value;
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
                  DateFormat.yMMMEd().format(updatedDate),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40, top: 10),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onHighlightChanged: (value) {
                  setState(() {
                    isTapped = value;
                  });
                },
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    double total =
                        Provider.of<TransactionData>(context, listen: false)
                            .updateTotalPrice(
                                double.parse(widget.existedPrice),
                                double.parse(updatedPrice),
                                widget.existedIsIncome);

                    final updateExpense = TransactionModel(
                      isIncome: checkIsIncome == 1 ? true : false,
                      id: widget.index,
                      name: updatedName,
                      description: updatedDescription,
                      price: updatedPrice,
                      date: updatedDate.toString(),
                      total: total.toString(),
                    );
                    Provider.of<TransactionData>(context, listen: false)
                        .updateExpenseList(updateExpense);
                  }
                  Navigator.of(context).pop();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: isTapped ? 45 : 50,
                  width: isTapped ? 150 : 160,
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 30,
                        offset: const Offset(3, 7),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.isExpense ? 'Update Income' : 'Update Expense',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
