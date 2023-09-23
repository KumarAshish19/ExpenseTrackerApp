import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final dateformatter = DateFormat.yMd();

final uuid = Uuid();

enum Category { food, shopping, residence, travel, leisure }

const CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.shopping: Icons.shopping_cart,
  Category.travel: Icons.flight_takeoff,
  Category.residence: Icons.home,
   Category.leisure: Icons.all_inclusive,
};

class Expense {
  Expense({
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatteddate {
    return dateformatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenses;

  double get totalexpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
