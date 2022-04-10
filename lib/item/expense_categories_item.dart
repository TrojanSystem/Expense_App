import 'package:example/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

import '../model/transaction_data.dart';

class ExpenseCategoriesItem extends StatelessWidget {
  final List newDateList;
  final TransactionModel expense;

  final int index;

  ExpenseCategoriesItem({
    this.newDateList,
    this.index,
    this.expense,
  });

  @override
  Widget build(BuildContext context) {
    var zzzz = newDateList.map((e) => e.price).toList();
    var sumTotalprice = 0.0;
    for (int x = 0; x < zzzz.length; x++) {
      sumTotalprice += double.parse(zzzz[x]);
    }

    var y = newDateList.map((e) => e.name).toSet().toList();
    y.sort();
    var x = newDateList.where((e) => e.name.toString() == y[index]).toList();
    var z = x.map((e) => e.name).toList();
    var zz = x.map((e) => e.price).toList();
    var sum = 0.0;
    for (int x = 0; x < z.length; x++) {
      sum += double.parse(zz[x]);
    }

    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 18.0, bottom: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      y[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      height: 25,
                      width: 250,
                      child: FAProgressBar(
                        backgroundColor: Colors.black12,
                        size: 20,
                        progressColor: Colors.green,
                        currentValue: sumTotalprice == 0
                            ? (0).floor()
                            : ((sum * 100) / sumTotalprice).floor(),
                        displayText: '%',
                        displayTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(
              onPressed: () {
                Provider.of<TransactionData>(context, listen: false)
                    .deleteExpenseList(expense.id);
              },
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
