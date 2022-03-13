import 'package:example/model/transaction_data.dart';
import 'package:example/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'expense.dart';
import 'income.dart';

class Account extends StatelessWidget {
  const Account({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionData>(
      builder:(context,data,child)=>Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Income(),
              Container(width: 2, height: 100, color: Colors.white54),
              const Expense(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Text(
                'Daily Expense: ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                data.update().toStringAsFixed(2),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
