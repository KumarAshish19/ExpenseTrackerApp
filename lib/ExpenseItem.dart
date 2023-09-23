import 'package:expensetrackerapp/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem(this.expense, {super.key});

  final Expense expense;
  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(expense.name,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(CategoryIcons[expense.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      expense.formatteddate,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
