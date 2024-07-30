import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const Uuid uuid = Uuid();

enum Category { food, travel, leisure, work, other }

var formatter = DateFormat.yMd();

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie_creation,
  Category.travel: Icons.flight_takeoff_rounded,
  Category.work: Icons.work,
  Category.other: Icons.other_houses
};

class Expense {
  final String id, title;
  final double amount;
  final DateTime dateTime;
  final Category category;

  Expense({
    Key? key,
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(dateTime);
  }
}

class ExpenseBucket {
  final List<Expense> expenses;
  final Category category;
  ExpenseBucket(this.expenses, this.category);

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpense {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
