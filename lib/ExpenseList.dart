import 'package:expensetrackerapp/ExpenseItem.dart';
import 'package:expensetrackerapp/expense.dart';
import 'package:expensetrackerapp/main.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList({required this.expenses, super.key,required this.onremovedata,});

  final void Function(Expense expense) onremovedata;
  final List<Expense> expenses;
  Widget build(context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
              background: Container(color: Theme.of(context).colorScheme.error.withOpacity(.8),margin: Theme.of(context).cardTheme.margin,),
              key: ValueKey(expenses[index]),
              onDismissed: (direction){
                onremovedata(expenses[index]);
              },
              child: ExpenseItem(expenses[index]),
            ),);
  }
}
