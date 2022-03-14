import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../input_form/transaction_update_form_item.dart';
import '../model/transaction_data.dart';
import '../model/transaction_model.dart';

class TransactionTileExpense extends StatefulWidget {
  final int index;
  final TransactionModel expense;

  const TransactionTileExpense({this.expense, this.index});

  @override
  State<TransactionTileExpense> createState() => _TransactionTileExpenseState();
}

class _TransactionTileExpenseState extends State<TransactionTileExpense> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 15, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.access_time_filled_rounded),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          DateFormat.jm().format(
                            DateTime.parse(widget.expense.date),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          widget.expense.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (ctx) => TransactionUpdateForm(
                                    index: widget.expense.id,
                                    existedDescription:
                                        widget.expense.description,
                                    existedName: widget.expense.name,
                                    existedPrice: widget.expense.price,
                                    existedDate: widget.expense.date),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.purple,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Provider.of<TransactionData>(context,
                                      listen: false)
                                  .deleteExpenseList(widget.expense.id);
                              double totalMinus = Provider.of<TransactionData>(
                                      context,
                                      listen: false)
                                  .minusTotalPrice(
                                double.parse(widget.expense.price),
                              );
                              print('Minus $totalMinus');
                              final updateExpense = TransactionModel(
                                id: widget.expense.id,
                                name: widget.expense.name,
                                description: widget.expense.description,
                                price: widget.expense.price,
                                date: widget.expense.date.toString(),
                                total: totalMinus.toString(),
                              );
                              Provider.of<TransactionData>(context,
                                      listen: false)
                                  .updateExpenseList(updateExpense);

                              print('index ${widget.expense.id}');
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // const SizedBox(height: 40,),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 150,
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.arrow_downward_rounded,
                    size: 25,
                    color: Colors.white,
                  ),
                  const Text(
                    'ETB ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.expense.price.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
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
