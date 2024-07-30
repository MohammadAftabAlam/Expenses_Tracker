
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widget/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expensesList;
  final Function(Expense expense) removeExpense;
  const ExpensesList(
      {super.key, required this.expensesList, required this.removeExpense});

  snackBar(String message) {}

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: ((context, index) => Dismissible(
            // key: UniqueKey(),
            key: ValueKey(expensesList[index]),
            onDismissed: (direction) {
              removeExpense(expensesList[index]);
            },
            background: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              child: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete,
                    size: 30,
                  ),
                ),
              ),
            ),
            child: ExpenseItem(
              expense: expensesList[index],
            ),
          )),
    );
  }
}
