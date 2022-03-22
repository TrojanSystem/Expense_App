import 'package:example/model/month_budget_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/monthly_budget_data.dart';

class MonthlyForm extends StatefulWidget {
  const MonthlyForm({Key key}) : super(key: key);

  @override
  State<MonthlyForm> createState() => _MonthlyFormState();
}

class _MonthlyFormState extends State<MonthlyForm> {
  final _formKey = GlobalKey<FormState>();

  String budget = '';

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    final newMonthlyBudget = MonthlyBudget(
                      budget: budget,
                      date: DateTime.now().toString(),
                    );
                    Provider.of<MonthlyBudgetData>(context, listen: false)
                        .addMonthlyBudgetList(newMonthlyBudget);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save MonthBudget'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
