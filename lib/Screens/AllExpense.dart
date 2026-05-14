import 'package:expense_tracker/Provider/providerDB.dart';
import 'package:expense_tracker/Wedgits/HomeWedgits/HomeListtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Allexpense extends StatelessWidget {
  const Allexpense({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,surfaceTintColor: Colors.transparent,
        title: const Text("All Expenses"),
        centerTitle: true,
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          final expenses = provider.expenses;
          if (expenses.isEmpty) {
            return const Center(child: Text("No transactions yet."));
          }
          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3).r,
                child: HomeListtile(x: expenses[index]),
              );
            },
          );
        },
      ),
    );
  }
}
