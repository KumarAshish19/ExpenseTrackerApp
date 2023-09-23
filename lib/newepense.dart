import 'dart:io';

import 'package:expensetrackerapp/Expenses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expensetrackerapp/expense.dart';
import 'package:flutter/rendering.dart';

class NewExpense extends StatefulWidget {
  NewExpense({
    super.key,
    required this.onaddexpense,
  });

  final void Function(Expense expense) onaddexpense;
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();

  DateTime? _Selecteddate;
  Category _selectedcategory = Category.leisure;

  void _Persentdatepicker() async {
    var now = DateTime.now();
    final pickeddate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);

    setState(() {
      _Selecteddate = pickeddate;
    });
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }
  
  void _showplatform()
  {
    if(Platform.isIOS)
    {
      showCupertinoDialog( context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text("Invalid input"),
          content: const Text("Please make sure to input a valid input"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            )
          ],
        ),);
    }
      else
      {
          showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Invalid input"),
            content: const Text("Please make sure to input a valid input"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          ),
        );
      }
  }

  void submitExpenseData() {
    final enteredamount = double.tryParse(_amountcontroller.text);
    final amountisinvalid = enteredamount == null || enteredamount <= 0;
    if (_titlecontroller.text.trim().isEmpty ||
        amountisinvalid ||
        _Selecteddate == null) {
          _showplatform();
      return;
    }
    widget.onaddexpense(
      Expense(
        name: _titlecontroller.text,
        amount: enteredamount,
        date: _Selecteddate!,
        category: _selectedcategory,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, Constraints) {
      final maxwidth = Constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardspace + 16),
            child: Column(
              children: [
                if (maxwidth >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titlecontroller,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text("Title"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24,),
                      Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _amountcontroller,
                        maxLength: 15,
                        decoration: const InputDecoration(
                          prefixText: '\$',
                          label: Text("Amount"),
                        ),
                      ),
                    ),
                    ],
                  )
                else          
                    TextField(
                      controller: _titlecontroller,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text("Title"),
                      ),
                    ),
                  

                const SizedBox(
                  height: 8,
                ),
                if(maxwidth>=600)
                  Row(children: [
                    DropdownButton(
                        value: _selectedcategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedcategory = value;
                          });
                        }),
                        const SizedBox(width: 24,),
                        Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_Selecteddate == null
                              ? 'Selected Date'
                              : dateformatter.format(_Selecteddate!)),
                          IconButton(
                              onPressed: _Persentdatepicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ),
                    ),

                  ],)
                else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _amountcontroller,
                        maxLength: 15,
                        decoration: const InputDecoration(
                          prefixText: '\$',
                          label: Text("Amount"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_Selecteddate == null
                              ? 'Selected Date'
                              : dateformatter.format(_Selecteddate!)),
                          IconButton(
                              onPressed: _Persentdatepicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if(maxwidth>=600)
                  Row(children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Discard"),
                    ),
                    ElevatedButton(
                      onPressed: submitExpenseData,
                      child: const Text("Save Expense"),
                    ),
                  ],)
                else
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedcategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedcategory = value;
                          });
                        }),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Discard"),
                    ),
                    ElevatedButton(
                      onPressed: submitExpenseData,
                      child: const Text("Save Expense"),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
