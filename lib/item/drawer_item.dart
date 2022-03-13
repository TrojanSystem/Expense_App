import 'package:example/screen/expense_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              child: const Text('Monthly Expense'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const ExpenseCategories(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blue,

            ),
          ),
        ],
      ),
    );
  }
}
