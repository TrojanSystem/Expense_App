import 'package:example/input_form/transaction_update_form_item.dart';
import 'package:example/model/transaction_model.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/transaction_data.dart';

class TransactionTileIncome extends StatefulWidget {
  final int index;
  final TransactionModel expense;
  final List listOfExpenses;

  TransactionTileIncome({this.index, this.expense, this.listOfExpenses});

  @override
  State<TransactionTileIncome> createState() => _TransactionTileIncomeState();
}

class _TransactionTileIncomeState extends State<TransactionTileIncome> {
  @override
  Widget build(BuildContext context) {
       return Padding(
      padding: const EdgeInsets.fromLTRB(8,8.0,8,0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(4, 8), // changes position of shadow
                ),
              ],
            ),
            width: double.infinity,
            height: 110,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.access_time_filled_rounded,size: 20,),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          DateFormat.E().add_jm().format(
                                DateTime.parse(widget.expense.date),
                              ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      widget.expense.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) => TransactionUpdateForm(
                                index: widget.expense.id,
                                existedIsIncome: widget.expense.isIncome,
                                existedDescription: widget.expense.description,
                                existedName: widget.expense.name,
                                existedPrice: widget.expense.price,
                                existedDate: widget.expense.date),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.purple,
                          size: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Provider.of<TransactionData>(context, listen: false)
                              .deleteExpenseList(widget.expense.id);
                          double totalMinus = Provider.of<TransactionData>(
                                  context,
                                  listen: false)
                              .minusTotalPrice(
                                  double.parse(widget.expense.price),
                                  widget.expense.isIncome);
                                                   final updateExpense = TransactionModel(
                            isIncome: widget.expense.isIncome,
                            id: widget.expense.id,
                            name: widget.expense.name,
                            description: widget.expense.description,
                            price: widget.expense.price,
                            date: widget.expense.date.toString(),
                            total: totalMinus.toString(),
                          );
                          Provider.of<TransactionData>(context, listen: false)
                              .updateExpenseList(updateExpense);


                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: widget.expense.isIncome ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 120,
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   Icon(
                    widget.expense.isIncome ?  Icons.arrow_downward_rounded:Icons.arrow_upward_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                  const Text(
                    'ETB ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.expense.price.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
