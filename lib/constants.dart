import 'package:flutter/material.dart';

const kkStyles = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 20,
);
const kkExpense = TextStyle(
  color: Colors.white,
  letterSpacing: 1.2,
  fontSize: 25,
  fontWeight: FontWeight.w900,
);
const kkSummaryIncome = TextStyle(
  color: Colors.green,
  fontWeight: FontWeight.w900,
  fontSize: 18,
);
const kkSummaryExpense = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.w900,
  fontSize: 18,
);
const kkDropDown = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w900,
);
const kkSummaryStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w900,
  fontSize: 40,
);
const kkSummaryIncomeStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w900,
  fontSize: 20,
);
final kkButton = Container(
  width: double.infinity,
  height: 30.0,
  decoration: BoxDecoration(
    gradient: LinearGradient(
        colors: [Colors.red[800], Colors.red[800].withOpacity(0.7)],
        begin: const Alignment(0.0, -1.0),
        end: const Alignment(0.0, 1.0)),
    borderRadius: BorderRadius.circular(20.0),
  ),
  child: const Text('Save Expense'),
);
const sloganStyle = TextStyle(
  fontFamily: 'FjallaOne',
  fontSize: 15,
  color: Colors.white,
  letterSpacing: 1,
  fontWeight: FontWeight.w900,
);
const storageTitle = TextStyle(
  fontFamily: 'FjallaOne',
  fontSize: 30,
  fontWeight: FontWeight.w900,
);
const storageItemName = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontWeight: FontWeight.w900,
);
const storageItemQuantity = TextStyle(
  fontFamily: 'FjallaOne',
  fontSize: 25,
  fontWeight: FontWeight.w900,
);
const storageItemDate = TextStyle(
  fontSize: 15,
  color: Colors.black,
);

const storageItemMoney = TextStyle(
  fontFamily: 'FjallaOne',
  fontSize: 18,
  color: Colors.white,
  letterSpacing: 1,
  fontWeight: FontWeight.w900,
);
const storageItemCurrency = TextStyle(
  fontSize: 18,
  color: Colors.black,
  letterSpacing: 1,
  fontWeight: FontWeight.w900,
);
