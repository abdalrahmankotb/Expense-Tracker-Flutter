import 'package:expense_tracker/Provider/Toogle.dart';
import 'package:expense_tracker/Provider/providerDB.dart';
import 'package:expense_tracker/Wedgits/statical/ListtileWedgit.dart';
import 'package:expense_tracker/Wedgits/statical/Piechart.dart';
import 'package:expense_tracker/Wedgits/statical/toogle.dart';
import 'package:expense_tracker/const/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Statical extends StatelessWidget {
  const Statical({super.key});

  @override
  Widget build(BuildContext context) {
    final toggle = Provider.of<ToggleProvider>(context);
    final p = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Statical"),centerTitle: true,elevation: 0,surfaceTintColor: Colors.transparent,),
      body: Padding(
        padding: const EdgeInsets.all(24.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Expenses Average",style: Theme.of(context).textTheme.headlineSmall,),
            Text(
              toggle.isWeekly
                  ? p.GetAvrageWeekly().toString()
                  : p.GetAvrageMonthly().toString(),
            style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 20.h,),
            ExpensesBarGraph(),
            SizedBox(height: 30.h),
            WeeklyMonthlyToggle(),
            SizedBox(height: 20.h),

            Expanded(
              child: ListView.builder(
                itemCount: Place.places.length,
                itemBuilder: (context, index) {
                  final category = Place.places[index];
                  final count = toggle.isWeekly
                      ? p.getCategoriesWekklylytotals(category)
                      : p.getCategoriesMonthlyTotals(category);
                  final total = toggle.isWeekly
                      ? p.getCategoriesWeeklyPrices(category)
                      : p.getCategoriesMonthlyPrices(category);

                  return Listtilewedgit(
                    category: category,
                    meeklyOrmonthlyCount: count,
                    meeklyOrmonthlyTotalDecreasing: total,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
