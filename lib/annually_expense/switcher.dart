import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

import '../model/transaction_data.dart';

class Switcher extends StatelessWidget {
  const Switcher({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Switch'),
      ),
      body: Consumer<TransactionData>(
        builder: (context, data, child) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LiteRollingSwitch(
                //initial value
                value: true,
                textOn: 'Income',
                textOff: 'Expense',
                colorOn: Colors.green[800],
                colorOff: Colors.red[800],
                iconOn: FontAwesomeIcons.moneyBill,
                iconOff: FontAwesomeIcons.moneyBill,
                textSize: 16.0,
                onChanged: (bool state) {
                  data.updaterChanger(state);
                },
              ),
              data.isIncome ? const Text('Hello') : const Text('Good Bye'),
            ],
          ),
        ),
      ),
    );
  }
}
