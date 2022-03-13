import 'package:example/input_form/transaction_update_form_item.dart';
import 'package:example/model/transaction_model.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/transaction_data.dart';

class TransactionTileIncome extends StatefulWidget {
  final int index;
  final TransactionModel expense;

  TransactionTileIncome({this.index, this.expense});

  @override
  State<TransactionTileIncome> createState() => _TransactionTileIncomeState();
}

class _TransactionTileIncomeState extends State<TransactionTileIncome> {
  @override
  Widget build(BuildContext context) {
    Provider.of<TransactionData>(context).totalPrice =
        double.parse(widget.expense.total);

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
            height: 140,
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
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 5),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) => TransactionUpdateForm(
                                index: widget.index,
                                existedDescription: widget.expense.description,
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
                        onPressed: () async {

                          Provider.of<TransactionData>(context, listen: false)
                              .deleteExpenseList(widget.expense.id);
                          double v =Provider.of<TransactionData>(context,listen: false)
                              .minusTotalPrice(
                            double.parse(widget.expense.price),

                          );
                          print(v);
                          print(widget.expense.price);

                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 30,
                        ),
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
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 150,
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.arrow_upward_rounded,
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
