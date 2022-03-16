import 'package:example/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

import '../model/transaction_data.dart';

class ExpenseCategoriesItem extends StatelessWidget {
  final List listOfExpense;
  final TransactionModel expense;
  double totalPrice;
  final int index;

  ExpenseCategoriesItem(
      {this.listOfExpense, this.index, this.expense, this.totalPrice});

  @override
  Widget build(BuildContext context) {
    final result =Provider.of<TransactionData>(context).expenseList;
    var newDateList = result
        .where((element) =>
    DateTime.parse(element.date).day == DateTime.now().day)
        .toList();

    var zzzz =newDateList.map((e) => e.price).toList();
    var sumTotalprice = 0.0;
    for (int x = 0; x < zzzz.length; x++) {
      sumTotalprice += double.parse(zzzz[x]);
    }

    var y = newDateList.map((e) => e.name).toSet().toList();

    int ccc =DateTime.now().day;
    var yy = listOfExpense.map((e) => DateTime.parse(e.date).day).toSet().toList();
    var x = newDateList.where((e) => e.name.toString() == y[index]).toList();
    var z = x.map((e) => e.name).toList();
    var zz = x.map((e) => e.price).toList();
    var sum = 0.0;
    for (int x = 0; x < z.length; x++) {
      sum += double.parse(zz[x]);
    }
    // print('This is yy $zzzz');
    // // print('This is y $y');
    // print('sum is $sum');
    // print('total is $totalPrice');
    return SizedBox(
      width: double.infinity,
      //color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 18.0),
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
              onPressed: () {},
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
