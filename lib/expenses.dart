
import 'package:expense_tracker/chart/chart.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widget/expenses_list.dart';
import 'package:expense_tracker/widget/expenses_new.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesWidget();
}

class _ExpensesWidget extends State<Expenses> {
  // final _titleController = TextEditingController();
  // final _amountController = TextEditingController();

  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Cinema",
      amount: 15.69,
      dateTime: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: "Flutter",
      amount: 20.69,
      dateTime: DateTime.utc(2024, 5, 26),
      category: Category.work,
    ),
    Expense(
      title: "Burger",
      amount: 5.69,
      dateTime: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Mfp - Delhi",
      amount: 65.69,
      dateTime: DateTime.utc(2024, 6, 30),
      category: Category.travel,
    ),
    Expense(
      title: "Pizza",
      amount: 65.69,
      dateTime: DateTime.utc(2024, 6, 30),
      category: Category.food,
    ),
  ];

  /* ************ SHOWING OVERLAY FOR ADDING NEW EXPENSES STARTS ******** */
  void _openAddExpensesOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return NewExpense(
          onAddExpense: _addExpense,
        );
      },
    );
  }
  /* ************ SHOWING OVERLAY FOR ADDING NEW EXPENSES ENDS ******** */

  /* *********************** ADDING NEW EXPENSES STARTS *********************** */
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }
  /* *********************** ADDING NEW EXPENSES ENDS *********************** */

  /* *********************** REMOVING EXPENSES STARTS *********************** */
  void removeExpense(Expense expense) {
    var expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    /* ************** ADDING SNACK-BAR FOR "UNDO" STARTS ******** */
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Deleted"),
        // closeIconColor: Colors.red,
        // backgroundColor: Colors.red,
        // showCloseIcon: true,
        // behavior: SnackBarBehavior.floating,
        // margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height - 200),
        action: SnackBarAction(
          label: "Undo",
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
      /* ************** ADDING SNACK-BAR FOR "UNDO" ENDS ******** */
    );
  }
  /* *********************** REMOVING EXPENSES ENDS *********************** */

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    Widget mainContent = const Center(
      child: Text(
        "No expenses found. Start adding some!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          color: Color.fromARGB(255, 76, 140, 147),
        ),
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expensesList: _registeredExpenses,
        removeExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses Tracker"),
        backgroundColor: const Color.fromARGB(255, 61, 128, 162),
        actions: [
          IconButton(
            onPressed: _openAddExpensesOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: width < 500 ? Column(
        children: [
          // const Text("The chart"),
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
      ) : Row(
        children: [
          // const Text("The chart"),
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(child: mainContent),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpensesOverlay,
        child: const Icon(Icons.add),
      ),
    );
  }
}
