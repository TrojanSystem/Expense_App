import 'package:example/model/month_budget_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/monthly_budget_data.dart';

class MonthlyUpdateForm extends StatefulWidget {
  const MonthlyUpdateForm({this.existedBudget, this.existedDate, this.index});
  final String existedBudget;
  final String existedDate;
  final int index;
  @override
  State<MonthlyUpdateForm> createState() => _MonthlyUpdateFormState();
}

class _MonthlyUpdateFormState extends State<MonthlyUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  bool isTapped = false;
  String budget = '';
  String date = DateTime.now().toString();
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
          date = val.toString();
        } else {
          date = DateTime.now().toString();
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.existedBudget,
                validator: (value) {
                  final pattern = RegExp("^[0-9]{1,10}");
                  if (value.isEmpty) {
                    return 'Enter Monthly Budget';
                  } else if (!pattern.hasMatch(value)) {
                    return 'Enter Valid Budget';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  label: const Text('Enter Monthly Budget'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onSaved: (value) {
                  budget = value;
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
                  DateFormat.yMMMEd().format(DateTime.parse(date)),
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
                    final newMonthlyBudget = MonthlyBudget(
                      id: widget.index,
                      budget: budget,
                      date: date,
                    );
                    Provider.of<MonthlyBudgetData>(context, listen: false)
                        .updateMonthlyBudgetList(newMonthlyBudget);
                    Navigator.of(context).pop();
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: isTapped ? 45 : 50,
                  width: isTapped ? 150 : 160,
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 30,
                        offset: Offset(3, 7),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Save Month Budget',
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
