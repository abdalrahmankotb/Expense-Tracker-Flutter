import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/Provider/providerDB.dart';

class Cardcurrentprice extends StatelessWidget {
  const Cardcurrentprice({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        final budget = provider.budget; 
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30).r,
          ),
          elevation: 6,
          child: Container(
            width: 250.w,
            height: 140.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30).r,
              gradient: const LinearGradient(
                colors: [Color(0xff1D2A30), Color.fromARGB(255, 10, 69, 97)],
                stops: [0.4, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Total Balance",
                      style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: 10.h),
                  Text(
                    "$budget\$",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
