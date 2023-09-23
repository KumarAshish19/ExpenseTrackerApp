import 'package:expensetrackerapp/ExpenseList.dart';
import 'package:expensetrackerapp/chart.dart';
import 'package:expensetrackerapp/expense.dart';
import 'package:expensetrackerapp/newepense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  Expenses({
    super.key,
  });
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expense> _requiredexpences = [
    Expense(
      name: "Bali",
      amount: 300.300,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      name: "Russia",
      amount: 600.600,
      date: DateTime.now(),
      category: Category.shopping,
    ),
  ];

  void openaddexpenseoverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onaddexpense: addexpense),
    );
  }

  void addexpense(Expense expense) {
    setState(() {
      _requiredexpences.add(expense);
    });
  }

  void removeexpense(Expense expense) {
    final expenseindex=_requiredexpences.indexOf(expense);
    setState(() {
      _requiredexpences.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Expense deleted"),duration: Duration(seconds: 3),action: SnackBarAction(label: "Undo", onPressed: (){
      setState(() {
        _requiredexpences.insert(expenseindex,expense);
      });
    }),));
  }

  Widget build(context) {
    final width= MediaQuery.of(context).size.width;

    Widget maincontent=const Center(child: Text("No data available, Add some!"),);

  if(_requiredexpences.isNotEmpty)
  {
    maincontent=ExpenseList(
              expenses: _requiredexpences,
              onremovedata: removeexpense,
            );
  }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(onPressed: openaddexpenseoverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width<600? Column(
        children: [
          Chart(expenses: _requiredexpences),
          Expanded(
            child: maincontent,
          ),
        ],
      ):Row(children: [
          Expanded(child: Chart(expenses: _requiredexpences)),
          Expanded(
            child: maincontent,
          ),
        ],),
    );
  }
}
